
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class ExampleLuigiClientPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
    sleep 0.75 
      retrieve_shadow_root  
  end

  def click_open_modal
    shadow_root.find_element(:id, "bConModal").click
    sleep 0.5
  end

  def click_open_dialog
    shadow_root.find_element(:id, "bOpenDialog").click
    sleep 0.5
  end


end


