require 'capybara'
require 'cucumber'
require 'selenium-webdriver'
require 'capybara/dsl'
require 'capybara/cucumber'
require 'site_prism'
require 'byebug'
require 'rspec'
 
Capybara.default_driver = :chrome
Capybara.app_host = "https://www.gobear.com/ph?x_session_type=UAT"
Capybara.register_driver :chrome do |app|
  client = Selenium::WebDriver::Remote::Http::Default.new
  client.open_timeout = 5
  client.read_timeout = 30
  options = Selenium::WebDriver::Chrome::Options.new
  [
    '--aggressive-cache-discard',
    '--disable-application-cache',
    '--disable-cache',
    '--disable-offline-load-stale-cache',
    '--disk-cache-size=0',
    '--disable-extensions',
    '--disable-plugins',
    '--disable-plugins-discovery',
    '--disable-sync',
    '--disable-web-security',
    '--no-pings',
    '--window-size=1280,1024',
    '--window-position=0,0',
    '--no-sandbox'
  ].each do |opt|
    options.add_argument(opt)
  end

  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: {'w3c' => false}
  )

  Capybara::Selenium::Driver.new app, browser: :chrome,
                                 http_client: client,
                                 clear_local_storage: true,
                                 clear_session_storage: true,
                                 desired_capabilities: capabilities,
                                 options: options
end

Capybara.default_max_wait_time = 10
Capybara.ignore_hidden_elements = true
Capybara.default_selector = :css

Before do
  TestManager.run_up
end

After do |scenario|
  if ENV['CI'] == 'true'
    TestManager.track_scenario(scenario)
    TestManager.take_snapshot(scenario, page, REPORT_DIR)
  end

  TestManager.tear_down
end

World(Capybara::DSL)