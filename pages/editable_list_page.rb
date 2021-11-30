
require File.join(File.dirname(__FILE__), "abstract_page.rb")

class EditableListPage < AbstractPage

  def initialize(driver)
    super(driver, "") # <= TEXT UNIQUE TO THIS PAGE
    retrieve_shadow_root
  end

  def enter_new_item(new_item)
    input_elem = shadow_root.find_element(:tag_name, "input")
    input_elem.send_keys(new_item)
  end


  def click_add_button
    button_elems = shadow_root.find_elements(:tag_name, "button")
    puts button_elems.count
    add_button = button_elems.last
    add_button.click
  end
end


