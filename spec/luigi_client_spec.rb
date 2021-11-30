load File.dirname(__FILE__) + "/../test_helper.rb"

describe "Luigi Client" do
  include TestHelper

  before(:all) do
    # browser_type, browser_options, site_url are defined in test_helper.rb
    @driver = $driver = Selenium::WebDriver.for(browser_type, browser_options)
    driver.manage().window().resize_to(1280, 720)
    driver.get(site_url)
  end

  after(:all) do
    driver.switch_to.default_content

    driver.quit unless debugging?
  end

  it "Sample Luigi Client operations" do
    click_nav_web_component
    click_sub_nav("WC Luigi Client")

    example_luigi_client_page = ExampleLuigiClientPage.new(driver)
    example_luigi_client_page.click_open_modal

    confirmation_modal_page = ConfirmationModalPage.new(driver)
    confirmation_modal_page.click_no

    example_luigi_client_page.click_open_dialog
    dialog_frame = driver.find_element(:xpath, "//iframe[contains(@src, 'table-demo-page')]")
    driver.switch_to.frame(dialog_frame)

    example_dialog_modal_page = ExampleDialogModalPage.new(driver)
    example_dialog_modal_page.uncheck_row(1)
    example_dialog_modal_page.check_row(3)

    driver.switch_to.default_content
    example_dialog_modal_page.click_close_icon
  end
end
