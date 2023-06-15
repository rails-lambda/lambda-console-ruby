require "test_helper"

class LambdaConsoleTestBase < LambdaConsoleSpec

  it 'handle?' do
    expect(LambdaConsole.handle?(event_run_ls)).must_equal true
    expect(LambdaConsole.handle?(event_interact_ruby_description)).must_equal true
    expect(LambdaConsole.handle?({'x-lambda-console' => {'some' => 'thing'}})).must_equal false
  end

  it 'handle - run' do
    LambdaConsole::Run.expects(:handle).with(event_run_ls)
    LambdaConsole::Interact.expects(:handle).never
    LambdaConsole.handle(event_run_ls)
  end

  it 'handle - interact' do
    LambdaConsole::Interact.expects(:handle).with(event_interact_ruby_description)
    LambdaConsole::Run.expects(:handle).never
    LambdaConsole.handle(event_interact_ruby_description)
  end

end
