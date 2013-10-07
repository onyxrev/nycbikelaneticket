ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'database_cleaner'

Capybara.default_driver    = :selenium
Capybara.javascript_driver = :selenium

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.default_wait_time = 10
Capybara.server_port = 3001

DatabaseCleaner.strategy = :truncation

# don't talk to google... just lookup locally from stub data
Geocoder.configure(:lookup => :test)

Geocoder::Lookup::Test.add_stub(
  "Brooklyn, NY", [
    {
      'latitude'     => 40.551042,
      'longitude'    => -74.05663,
      'address'      => 'Brooklyn, NY, USA',
      'state'        => 'New York',
      'state_code'   => 'NY',
      'country'      => 'United States',
      'country_code' => 'US'
    }
  ]
)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.order = "random"

  config.before(:each) do
    Capybara.current_driver = Capybara.javascript_driver
  end

  config.before(:suite) do
    DatabaseCleaner.clean
  end
end
