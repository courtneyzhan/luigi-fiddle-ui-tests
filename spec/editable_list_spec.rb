load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Editable List" do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
    sleep 1
  end

  after(:all) do
    driver.quit unless debugging?
  end

  it "Add and remove from list" do
    click_nav_web_component
    click_sub_nav("WC Editable List")

    editable_list_page = EditableListPage.new(driver)
    editable_list_page.enter_new_item("Mario, here I come!")
    editable_list_page.click_add_button
    
    puts @shadow_root
    expect(@shadow_root.text).to include("Mario, here I come!")
  end
end
