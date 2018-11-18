Feature: Tests to verify different scenarios of reviews on Televisions.

Background: User is in Televisions page.
 Given I navigate to reviews of televisions page
 Then I should see page has successfully loaded on browser
 
 @televisions
Scenario Outline: This is to check, pagination is working as expected when user select different numbers.
 Given I should see <page_number> on the pagination bar
 When I click page number <page_number> 
 Then I should see television reviews range start from <from>
 And I should see television reviews range ends to <to>
 
  Examples: 
    | page_number | from | to |
    | 1           | 1    | 48 |
    | 6           | 241  | 288|

 @televisions
Scenario Outline: This is to see televisions appearing on page for the selected max and min range. Filter sometime appears as dropdown. 

 Given I go to filter section on page
 When I select the min value "<min_value_filter>"
 And I click done button if filter appeared as a dropdown
 And I get all prices of filtered items
 Then I should not have min amount less than <min_value>

 
  Examples: 
    | min_value_filter  | min_value |
    | 60000-60000       |  600      |

 @televisions
Scenario: When user click on product with some model number then user should see new page specific to that model. 

 Given I see first product on televisions page
 When I click first product of mentioned model number
 Then I should see the product page with title having model number


