module LambdaConsole
  class Interact
    DIG = [NAMESPACE, 'interact']

    class << self

      def handle?(event)
        !!event.dig(*DIG)
      end

      def handle(event)
        new(event).interact
      end

    end

    def initialize(event)
      @event = event
    end

    def interact
      begin
        body = eval(command, TOPLEVEL_BINDING).inspect
        { statusCode: 200, headers: {}, body: body }
      rescue Exception => e
        body = "#<#{e.class}:#{e.message}>".tap do |b|
          if e.backtrace
            b << "\n"
            b << e.backtrace.join("\n")
          end
        end
        { statusCode: 422, headers: {}, body: body }
      end
    end

    def command
      @event.dig(*DIG)
    end

  end
end
