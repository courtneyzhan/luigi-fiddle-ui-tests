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

  def click_nav_web_component
    driver.find_element(:partial_link_text, "Web Component").click
    sleep 1
  end


  def click_sub_nav(item)
    driver.find_element(:partial_link_text, item).click
    sleep 1
  end

  it "Add and remove from list" do
    click_nav_web_component
    click_sub_nav("WC Editable List")

    lis = driver.find_elements(:xpath, "//ul[@class='item-list']")
    puts lis

    sleep 0.1 # no as in frames
    puts driver.find_elements(:tag_name, "iframe").count
    puts driver.find_elements(:tag_name, "frame").count

    # the content is an invalid tag
    # <luigi-wc-2f77632f6c6973742e6a73></luigi-wc-2f77632f6c6973742e6a73>
    elem = driver.find_elements(:xpath, "//div[@class='wcContainer svelte-1scomxs']").first
    elem_html = driver.execute_script("return arguments[0].outerHTML;", elem)
    puts elem_html
    # https://stackoverflow.com/questions/55761810/how-to-automate-shadow-dom-elements-using-selenium
    # approach on stackoverlfow in JavaScrtip Selenium, same as below

    # a selenium talk about why use shadow and how to test with Selenium
    # https://confengine.com/conferences/selenium-conf-2020/proposal/13709/rise-of-shadow-dom-lets-solve-it-through-webdriver

    elem = driver.find_elements(:xpath, "//div[@class='wcContainer svelte-1scomxs']").first
    elem_html = driver.execute_script("return arguments[0].outerHTML;", elem)
    puts elem_html
    # based on the pattern, find the host element of shadow dom
    if elem_html =~ /<luigi-wc-([\d\w]+)>/
      shadow_element_wrapper_tag_name = "luigi-wc-" + $1
      File.open("/tmp/luigi-tag.xhtml", "w").write(elem_html)

      # https://stackoverflow.com/questions/55761810/how-to-automate-shadow-dom-elements-using-selenium
      elem = driver.find_element(:xpath, "//div[@class='wcContainer svelte-1scomxs']/#{shadow_element_wrapper_tag_name}")
      shadow_root = driver.execute_script("return arguments[0].shadowRoot", elem)
      puts shadow_root.class

      # search based on shadom, xpath might not well?!
      input_elem = shadow_root.find_element(:tag_name, "input")
      input_elem.send_keys("Mario, here I come!")

      button_elems = shadow_root.find_elements(:tag_name, "button")
      puts button_elems.count

      add_button = button_elems.last
      add_button.click
    end
  end
end
