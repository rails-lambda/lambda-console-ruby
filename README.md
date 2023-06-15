# Lambda Console (Ruby) [![Actions Status](https://github.com/rails-lambda/lambda-console-ruby/workflows/CI/CD/badge.svg)](https://github.com/rails-lambda/lambda-console-ruby/actions) 

A Ruby implementation of the Lambda Console project specification:

https://github.com/rails-lambda/lambda-console

Please see that project for CLI usage with Ruby Lambda Functions or Rails Applications on Lambda using [Lamby](https://github.com/rails-lambda/lamby) which leverages this gem.

## Integration

An example of how to add Lambda Console to your own Ruby function.

```ruby
def handler(event: context:)
  return LambdaConsole.handle(event) if LambdaConsole.handle?(event)
  # your code ...
end
```

## License

The gem is available as open source project under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LambdaConsole::Ruby project's codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/metaskills/lambda-console-ruby/blob/main/CODE_OF_CONDUCT.md).
