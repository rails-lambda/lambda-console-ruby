$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "lambda-console-ruby"
require "minitest/autorun"

class LambdaConsoleSpec < Minitest::Spec

  let(:event_run_ls) {
    { LambdaConsole::NAMESPACE => { 'run' => 'ls' } }
  }

  let(:event_interact_ruby_description) {
    { LambdaConsole::NAMESPACE => { 'interact' => 'RUBY_DESCRIPTION' } }
  }

  private
  
  def event(name, command)
    { LambdaConsole::NAMESPACE => { name.to_s => command } }
  end
  
end

require "mocha/minitest"
