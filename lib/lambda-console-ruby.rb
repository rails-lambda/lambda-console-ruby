require 'lambda-console-ruby/version'
require 'lambda-console-ruby/namespace'
require 'lambda-console-ruby/run'
require 'lambda-console-ruby/interact'

module LambdaConsole
  def handle?(event)
    Run.handle?(event) || LambdaConsole::Interact.handle?(event)
  end

  def handle(event)
    if Run.handle?(event)
      Run.handle(event)
    elsif Interact.handle?(event)
      Interact.handle(event)
    end    
  end

  extend self
end
