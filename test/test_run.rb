require "test_helper"

class LambdaConsoleTestRun < LambdaConsoleSpec

  it 'pwd file context is top level gem directory' do
    response = LambdaConsole::Run.handle(event('pwd'))
    expect(response[:statusCode]).must_equal 0
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{\/lambda-console-ruby\n\z}
    response = LambdaConsole::Run.handle(event('cat lib/lambda-console-ruby/version.rb'))
    expect(response[:statusCode]).must_equal 0
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{1.0.0}
  end

  it 'non shell captureable errors due to command not existing' do
    response = LambdaConsole::Run.handle(event('dirdoesnotexist'))
    expect(response[:statusCode]).must_equal 1
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{No such file or directory}
  end

  it 'shell errors' do
    response = LambdaConsole::Run.handle(event('cat /foo/bar'))
    expect(response[:statusCode]).must_equal 1
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{cat.*No such file or directory}
  end

  it 'captures standard error' do
    response = LambdaConsole::Run.handle(event('echo "This is a message" >&2'))
    expect(response[:statusCode]).must_equal 0
    expect(response[:headers]).must_equal({})
    expect(response[:body]).must_match %r{This is a message}
  end

  private

  def event(command)
    super 'run', command
  end
end
