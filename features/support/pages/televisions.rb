# this is televisions page
class Televisions
  include RSpec::Matchers
  include Capybara::DSL

  class << self
    def instance
      @instance ||= new
    end
  end

  def visit_location
    visit Constants::TELEVISIONS_URL
  end

  def loaded?
    has_title? Constants::TITLE
  rescue Capybara::ElementNotFound => e
    Utils.log_message("No title available:" + e.message)
    save_screenshot
  end

  def should_have_link(number)
    within(:css, "nav[aria-label='Pagination']") do
      page.should have_selector(:css, "a[aria-label='Page #{number}']")
    end
  rescue Capybara::ElementNotFound => e
    Utils.log_message("Could not find pagination element:" + e.message)
    save_screenshot
  end

  def navigate_link_with_page_number(navigation_number)
    within(:css, "nav[aria-label='Pagination']") do
      click_link(navigation_number.to_s)
    end
    Utils.wait_post_ui_action
  rescue Capybara::ElementNotFound => e
    Utils.log_message("Navigation to page number failed:" + e.message)
    save_screenshot
  end

  def set_range_values(range, elements_with_range_numbers)
    range.from = elements_with_range_numbers.first.text
    range.to = elements_with_range_numbers.last.text
  end

  def obtain_to_and_from_range
    range = SelectionRange.new
    Utils.log_message("Started getting the new range")
    begin
      within(:css, "div[data-which-id='page-count-container']") do
        elements_with_range_numbers = page.all("span._1sjhe")
        set_range_values(range, elements_with_range_numbers)
      end
    rescue Capybara::ElementNotFound => e
      Utils.log_message("Range to and from is not available:" + e.message)
      save_screenshot
    end
    Utils.log_message("Finished getting the new range from:#{range.from}, to:#{range.to}")
    range
  end

  def click_more_filter
    is_filter_dropdown = false
    begin
      page.find("span", text: "More filter").click
      is_filter_dropdown = true
    rescue Capybara::ElementNotFound => e
      Utils.log_message("Filter not available:" + e.message)
      is_filter_dropdown = false
      save_screenshot
    end
    Utils.wait_post_ui_action
    is_filter_dropdown
  end

  def put_low_price(low)
    find(:css, "select[name$='search[range][price][price][lower]']").find("option[value='#{low}']").select_option
    Utils.wait_post_ui_action
  rescue Capybara::ElementNotFound => e
    Utils.log_message("Fail to select low price:" + e.message)
    save_screenshot
  end

  def put_high_price(high)
    find(:css, "select[name$='search[range][price][price][upper]']").find("option[value='#{high}']").select_option
  rescue Capybara::ElementNotFound => e
    Utils.log_message("Fail to select low price:" + e.message)
    save_screenshot
  end

  def click_done_button
    find(:css, "button[data-which-id$='done-button']").click
  rescue Capybara::ElementNotFound => e
    Utils.log_message("Fail to select low price:" + e.message)
    save_screenshot
  end

  def obtain_all_price
    list_amount = []
    begin
      page.all(:css, "p[data-test-element$='product-amount']").each do |element|
        amount = element.text
        # this is to remove currency from the string of amount
        amount.slice!(0)
        list_amount.push amount.delete(",").to_f
      end
    rescue Capybara::ElementNotFound => e
      Utils.log_message("Price list of items on page not found:" + e.message)
      save_screenshot
    end
    list_amount
  end

  def obtain_first_product
    first_product = nil
    begin
      within(:css, "ul[data-test-element='product-list']") do
        first_product = page.all(:css, "li[id='product-card-wrapper']").first
      end
    rescue Capybara::ElementNotFound => e
      Utils.log_message("Item not found" + e.message)
      save_screenshot
    end
  end

  def obtain_first_product_display_price(first_displayed_product)
    model = nil
    within(first_displayed_product) do
      within(:css, "div[data-which-id='manufacturer-model']") do
        page.all(:css, "p[itemprop='model']").each do |element|
          model = element.text
        end
      end
    end
    model
  end

  def save_screenshot
    page.save_screenshot(["screenshots/", Time.now.utc.to_i, ".png"].join)
  end
end
