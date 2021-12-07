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
    # puts button_elems.count
    add_button = button_elems.last
    add_button.click
  end

  def list_items
    # xpath in shadow seems not working well
    # shadow_root.find_elements(:class, "item-list") # => return 1
    shadow_root.find_elements(:css, "ul.item-list>li")
  end

  def list_item_texts
    list_items.collect { |x| x.text.gsub("\u2296\n", "") }
  end

  # index start from 1
  def click_remove_button(list_number = -1)
    button_elems = shadow_root.find_elements(:tag_name, "button")
    # puts button_elems.count
    if list_number == -1
      remove_button = button_elems[button_elems.count - 2]
    else
      remove_button = button_elems[list_number + 1]
    end
    remove_button.click
    sleep 0.5
  end
end
