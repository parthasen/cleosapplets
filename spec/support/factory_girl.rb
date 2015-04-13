RSpec.configure do |config|
  #additional factory_girl configuration

  # Factory girl methods don't need to be prefaced with FactoryGirl
  config.include FactoryGirl::Syntax::Methods

  # Best each test suite is run, make sure the factories are valid
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end