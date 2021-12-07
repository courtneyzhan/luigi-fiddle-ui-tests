# use utils in RWebSpec and better integration with TestWise
require "#{File.dirname(__FILE__)}/../agileway_utils.rb"

# This is the parent page for all page objects, for operations across all pages, define here
class AbstractPage

  # Optional:
  # provide some general utility functions such as fail_safe { }
  #
  include AgilewayUtils

  # Optional:
  # TestWise Integration, supporting output text to TestWise Console with  puts('message') to TestWise Console
  #
  if defined?(TestWiseRuntimeSupport)
    include TestWiseRuntimeSupport
  end

  def initialize(driver, text = "")
    page_delay
    @driver = driver
    # TODO check the page text contains the given text
    @shadow_root = nil
  end

  def driver
    @driver
  end

  def shadow_root
    @shadow_root
  end

  alias browser driver

  # add delay on landing a web page. the default implementation is using a setting in TestWise IDE
  def page_delay
  end

  # return shadow root of luigi page (such as luigi-wc-2f77632f6c6973742e6a73)
  def retrieve_shadow_root
    elem = driver.find_elements(:xpath, "//div[contains(@class, 'wcContainer svelte-')]").first
    puts "ELEM: #{elem}"
    
    elem_html = driver.execute_script("return arguments[0].outerHTML;", elem)
    puts elem_html

    if elem_html =~ /<luigi-wc-([\d\w]+)>/
      shadow_element_wrapper_tag_name = "luigi-wc-" + $1

      # https://stackoverflow.com/questions/55761810/how-to-automate-shadow-dom-elements-using-selenium
      elem = driver.find_element(:xpath, "//div[contains(@class, 'wcContainer svelte-')]/#{shadow_element_wrapper_tag_name}")
      @shadow_root = driver.execute_script("return arguments[0].shadowRoot", elem)
    end
  end
end
