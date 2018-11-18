# this is selected Television product
class TelevisionProduct
  include RSpec::Matchers
  include Capybara::DSL

  class << self
    def instance
      @instance ||= new
    end
  end

  def loaded_with_selected_model(model)
    page.title.include? model
  rescue Capybara::ElementNotFound => e
    Utils.log_message("No title available:" + e.message)
    save_screenshot
  end
end
