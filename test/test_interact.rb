require "test_helper"

class LambdaConsoleTestInteract < LambdaConsoleSpec

  it 'basic' do
    response = LambdaConsole::Interact.handle(event_interact_ruby_description)
    expect(response[:statusCode]).must_equal 200
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{ruby .* revision}
  end

  it 'binding is top level' do
    response = LambdaConsole::Interact.handle(event("self"))
    expect(response[:statusCode]).must_equal 200
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{main}
  end

  it 'errors' do
    response = LambdaConsole::Interact.handle(event("raise('hell')"))
    expect(response[:statusCode]).must_equal 422
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{#<RuntimeError:hell>}
  end

  it 'inspected' do
    response = LambdaConsole::Interact.handle(event('true'))
    expect(response[:body]).must_equal 'true'
    response = LambdaConsole::Interact.handle(event('1 + 1'))
    expect(response[:body]).must_equal '2'
    response = LambdaConsole::Interact.handle(event('Object.new.tap { |o| o.instance_variable_set(:@a, 1) }'))
    expect(response[:body]).must_match %r{#<Object:.* @a=1>}
  end

  private

  def event(command)
    super 'interact', command
  end
end
