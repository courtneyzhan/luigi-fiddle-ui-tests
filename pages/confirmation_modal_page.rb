
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class ConfirmationModalPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def click_no
    driver.find_element(:xpath, "//button[@data-testid='luigi-modal-dismiss']").click
    sleep 0.5
  end


end


