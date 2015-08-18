require 'capybara'
require 'capybara/cucumber'
require 'capybara-screenshot/cucumber'
require 'selenium-webdriver'
require 'capybara/poltergeist'
require 'open-uri'
require 'pathname'

class Capybara::Poltergeist::Driver 
  def click
    trigger('click')
  end
end

if ENV['APPHOST']
  # Specify a remote host.  Format:
  #   APPHOST=http://192.168.1.0:3000
  Capybara.run_server = false
  Capybara.app_host = "#{ENV['APPHOST']}"
end


if ENV['SELENIUM']
  Capybara.default_driver = :selenium
  Capybara.register_driver :selenium do |app|
    prefs = {
      'download' => {
        'directory_upgrade' => true,
        'extensions_to_open' => ''
      }
    }
    caps = Selenium::WebDriver::Remote::Capabilities.chrome
    caps['chromeOptions'] = {'prefs' => prefs}
    Capybara::Selenium::Driver.new(app,
                                  :browser => :chrome,
                                  :desired_capabilities => caps,
                                  :args => ["--window-size=1440,900"]
    )
  end


  # Check to see if the server is running (for Selenium tests only)
  if Capybara.default_driver == :selenium && !Capybara.run_server
    begin
      open(Capybara.app_host)
    rescue
      puts "\nCannot connect to server #{Capybara.app_host}\n\n"
      exit
    end
  end
  
else
  # Poltergeist -- the default

  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      {
        debug: false,
        window_size: [1440, 900]
      }
    )
  end
  Capybara.javascript_driver = :poltergeist
  Capybara.default_driver = :poltergeist
end
