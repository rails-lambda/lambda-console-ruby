require_relative "lib/lambda-console-ruby/version"

Gem::Specification.new do |spec|
  spec.name = "lambda-console-ruby"
  spec.version = LambdaConsole::VERSION
  spec.authors = ["Ken Collins"]
  spec.email = ["ken@metaskills.net"]
  spec.summary = "A Ruby implementation of the Lambda Console project specification."
  spec.description = "A Ruby implementation of the Lambda Console project specification."
  spec.homepage = "https://github.com/rails-lambda/lambda-console-ruby"
  spec.license = "MIT"
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ .git])
    end
  end
  spec.require_paths = ["lib"]
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
end
