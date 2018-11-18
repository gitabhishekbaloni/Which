Given("I navigate to reviews of televisions page") do
  Televisions.instance.visit_location
end

Then("I should see page has successfully loaded on browser") do
  expect(Televisions.instance.loaded?).to be true
end

Given("I should see {int} on the pagination bar") do |page_number|
  Televisions.instance.should_have_link(page_number)
end

When("I click page number {int}") do |page_number|
  Televisions.instance.navigate_link_with_page_number(page_number)
end

Then("I should see television reviews range start from {int}") do |from_number|
  @new_range = Televisions.instance.obtain_to_and_from_range
  expect(@new_range.from.to_i).to match(from_number.to_i)
end

Then("I should see television reviews range ends to {int}") do |to_number|
  expect(@new_range.to.to_i).to match(to_number)
end

Given("I go to filter section on page") do
  @is_filter_as_dropdown = Televisions.instance.click_more_filter
end

When("I select the min value {string}") do |min_number|
  @price_range = Price.new
  @price_range.min = min_number
  Televisions.instance.put_low_price(@price_range.min)
end

And("I click done button if filter appeared as a dropdown") do
  Televisions.instance.click_done_button if @is_filter_as_dropdown
end

And("I get all prices of filtered items") do
  @all_price = Televisions.instance.obtain_all_price
end

Then("I should not have min amount less than {int}") do |min_value|
  expect(@all_price.min).to be >= min_value
end

Given("I see first product on televisions page") do
  @first_product_in_list = Televisions.instance.obtain_first_product
  expect(@first_product_in_list).not_to be(nil)
end

When("I click first product of mentioned model number") do
  @model_number = Televisions.instance.obtain_first_product_display_price(@first_product_in_list)
  @first_product_in_list.click
end

Then("I should see the product page with title having model number") do
  expect(TelevisionProduct.instance.loaded_with_selected_model(@model_number)).to be true
end
