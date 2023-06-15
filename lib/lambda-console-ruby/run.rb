require 'open3'

module LambdaConsole
  class Run
    class Error < StandardError ; end
    class UnknownCommandPattern < Error ; end

    DIG = [NAMESPACE, 'run']
    PATTERNS = [%r{.*}]

    class << self

      def handle?(event)
        !!event.dig(*DIG)
      end

      def handle(event)
        new(event).run
      end

    end

    def initialize(event)
      @event = event
      @body = ''
    end

    def run
      validate!
      begin
        status = Open3.popen3(env, command, chdir: chdir) do |_stdin, stdout, stderr, thread|
          @body << stdout.read
          @body << stderr.read
          thread.value.exitstatus
        end
        { statusCode: status, headers: {}, body: @body }
      rescue Exception => e
        { statusCode: 1, headers: {}, body: e.message }
      end
    end

    def command
      @event.dig(*DIG)
    end

    private

    def chdir
      defined?(::Rails) ? ::Rails.root : Dir.pwd
    end

    def validate!
      return if pattern?
      raise UnknownCommandPattern.new(command)
    end

    def pattern?
      PATTERNS.any? { |p| p === command }
    end

    def env
      Hash[ENV.to_hash.map { |k,v| [k, ENV[k]] }]
    end
  end
end
