Feature: Verify all function of travel insurance work correctly in show result page

Background: 
  Given user stands at travel insurance search

Scenario: Verify at least 3 cards display correctly with search result
  When user click on show result page
  Then user sees at least 3 cards displays

Scenario: Verify filter works correctly
  When user click on show result page
  Then user sees at least 3 cards displays
  When user selects "Pacific Cross,Prudential Guarantee" in insurers
  Then page only displays insurer "Pacific Cross,Prudential Guarantee"

Scenario: Verify sort works correctly
  When user click on show result page
  Then user sees at least 3 cards displays
  When user selects "Price: Low to high" in sorts
  Then cards were sorted by ascending price
  When user selects "Price: High to low" in sorts
  Then cards were sorted by descending price
  When user selects "Insurer: A to Z" in sorts
  Then cards were sorted by ascending Insurer
  When user selects "Insurer: Z to A" in sorts
  Then cards were sorted by descending Insurer

Scenario: Verify details works correctly
  When user click on show result page
  Then user sees at least 3 cards displays
  When user selects "single trip" in policy type
  And user selects "3 persons" in travellers
  When user selects "South Korea,Japan,Singapore" in details
  When user enter "date" in travel from date and "date" in travel to date
  Then user sees "single trip|3 persons|South Korea, Japan, Singapore" in travellers bar
