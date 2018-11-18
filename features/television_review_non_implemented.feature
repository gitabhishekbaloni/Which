Feature: Tests to verify different scenarios of reviews on Televisions.

Background: User is in Televisions page.
 Given I navigate to reviews of televisions page
 Then I should see page has successfully loaded on browser
 
 @non_implemented
Scenario: This is to check, whether of television products are working fine or not.
 Given I should see dropdown next to "Sort by" label
 When I select "Price (low to high)"
 And I save price of first element 
 And I now select "Price (high to low)"
 Then Price of first element should not match old saved price

@non_implemented
Scenario Outline: This is to see televisions appearing on page for only selected Brands. Filter sometime appears as dropdown. 

 Given I go to filter section on page
 When I select the brands as "<brand>"
 And I click done button if filter appeared as a dropdown
 Then I get all products on list with manufacturer as "<manufacturer>"

 
   Examples: 
    | brand  | manufacturer |
    | sony   |  Sony        |