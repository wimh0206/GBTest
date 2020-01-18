Given('user stands at travel insurance search') do
  @current_page = InsuranceHomePage.new
  @current_page.load
  @current_page.insurance_tab.click
  @current_page.travel_tab.click
end

When('user click on show result page') do
  @current_page.travel_page_section.wait_until_form_content_visible
  @current_page.travel_page_section.show_my_result_button.click
end

Then('user sees at least 3 cards displays') do
  @current_page.wait_until_travel_page_visible
  @current_page = TravelPage.new
  expect(@current_page).to have_at_least_3_cards
end

When('user selects {string} in insurers') do |insurers|
  insurers = insurers.split(',')
  insurers.each do |insurer|
    @current_page.filter_section.check_insurercheckbox(insurer)
  end
end

Then('page only displays insurer {string}') do |insurers|
  insurers = insurers.split(',')
  expect(@current_page).to have_correct_filter_insurer(insurers)
end

When('user selects {string} in sorts') do |sort_type|
  @current_page.sort_section.sort_type_radio(text: sort_type).click
end

Then('cards were sorted by ascending price') do
  expect(@current_page).to have_correct_price_sort(true)
end

Then('cards were sorted by descending price') do
  expect(@current_page).to have_correct_price_sort(false)
end

Then('cards were sorted by ascending Insurer') do
  expect(@current_page).to have_correct_insurer_sort(true)
end

Then('cards were sorted by descending Insurer') do
  expect(@current_page).to have_correct_insurer_sort(false)
end

When('user selects {string} in details') do |destinations|
  destinations = destinations.split(',')
  execute_script("window.scrollBy(0,10000)")
  @current_page.detail_section.add_destination(destinations)
end
When('user selects {string} in policy type') do |policy_type|
  @current_page.detail_section.policy_type_radio(text: policy_type).click
end

When('user selects {string} in travellers') do |traveler_type|
  @current_page.detail_section.traveller_radio(text: traveler_type).click
end

Then('user sees {string} in travellers bar') do |status|
  expected_status = status.split('|')
  @current_page.has_correct_travel_status?(expected_status)
end

When('user enter {string} in travel from date and {string} in travel to date') do |from_date, to_date|
  from_date = date = (Date.today + 1).strftime("%d-%m-%Y") if from_date == "date" 
  to_date = (Date.today + 366).strftime("%d-%m-%Y") if to_date == "date" 
  @current_page.detail_section.set_date_from_date(from_date, to_date)
end