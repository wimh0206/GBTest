class DetailSection < SitePrism::Section
  element :policy_type_radio, '[data-gb-name="triptype"] [class="radio radio-primary"]'
  element :traveller_radio, '[data-gb-name="traveller"] [class="radio radio-primary"]'
  section :destination_section, '[data-gb-name="destinations"]' do
    sections :select_option, '[data-gb-name="destinations"] [class="field field-select"]' do
      element :filter_option, 'span[class="filter-option clearfix"]'
      element :select_component, '[class="select-component"]'
      element :dropdown_item, '[class^="dropdown-menu"] li'
    end
    element :add_field, '[class="add-field"] i'
  end
  section :travel_date, '[class=" field travel-date-field"]' do
    element :from, '[class="date-from"] input'
    element :to, '[class="date-to"] input'

  end
  
  def add_destination(destinations)
    click_add_field(destinations)
    select_option(destinations)
  end

  def set_date_from_date(from_date, to_date)
    execute_script("$('.date-from input').val('#{from_date}')")
    travel_date.from.send_keys[:tab]
    execute_script("$('.date-to input').val('#{to_date}')")
    travel_date.to.send_keys[:tab]
  end

  private

  def click_add_field(destinations)
    add_count = destinations.count - 1

    add_count.times { destination_section.add_field.click } unless add_count <= 0
  end

  def select_option(destinations)
    destinations.each_with_index do |destination, index|
      option = destination_section.select_option[index]
      if destination != option.filter_option.text
        option.select_component.click
        option.wait_until_dropdown_item_visible
        option.dropdown_item(match: :first, text: destination).click
      end
    end
  end

end