
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class ExampleDialogModalPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
  end

  def check_row(row_no)
    table_checkboxes = driver.find_elements(:xpath, "//table[@class='fd-table']//tr/td[1]/input[@type='checkbox']")
    checkbox_elem = table_checkboxes[row_no - 1]
    driver.action.move_to(checkbox_elem).click.perform unless checkbox_elem.selected?
  end

  def uncheck_row(row_no)
    table_checkboxes = driver.find_elements(:xpath, "//table[@class='fd-table']//tr/td[1]/input[@type='checkbox']")
    checkbox_elem = table_checkboxes[row_no - 1]
    driver.action.move_to(checkbox_elem).click.perform if checkbox_elem.selected?
  end




  def click_close_icon
    sleep 0.25
    driver.find_element(:xpath, "//button[@aria-label='close']").click
  end
end




