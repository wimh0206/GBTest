require_relative './/filter_section'
require_relative './/sort_section'
require_relative './/detail_section'
require_relative './/card_section'

class TravelPage < SitePrism::Page
  section :filter_section, FilterSection, '[data-gb-name="filter-bar"]'
  section :sort_section, SortSection, '[data-gb-name="sort-bar"]'
  section :detail_section, DetailSection, '[class="edit-detail sidebar-item"]'
  sections :card_details, CardSection, '[class*="card-full"]'
  section :travel_bar, '[data-gb-name="travel-nav-data"]' do
    element :plan, 'h5'
    element :details, 'p'
  end

  def has_at_least_3_cards?
    card_details.count >= 3
  end

  def has_correct_filter_insurer?(insurers)
    cards = find_card_insurer(insurers)
    cards.each do |card|
      return false unless insurers.include? card.card_brand.text.strip
    end
  end

  def has_correct_price_sort?(ascending = true)
    actual_card_item = card_details.map { |card| card.card_policy_price.text.to_s.gsub(/[,]/,'').to_f }
    sort_item(actual_card_item, ascending)
  end

  def has_correct_insurer_sort?(ascending = true)
    actual_card_item = card_details.map { |card| card.card_brand.text.downcase }
    sort_item(actual_card_item, ascending)
  end
  def has_correct_travel_status?(expected_status)
    status = travel_bar.details.text
    status = status.split('|')
    status.each_with_index do |val, index|
      unless expected_status[index].nil?
        return false unless status[index].include? (expected_status[index])
      end 
    end
  end
  private

  def find_card_insurer(insurers)
    card_insurers =  Array.new
    insurers.each do |insurer|
      card_insurers += card_details(text: insurer)
    end
    card_insurers
  end

  def sort_item(actual_card_item, ascending)
    if ascending
      actual_card_item == actual_card_item.sort
    else
      actual_card_item == actual_card_item.sort.reverse
    end
  end

end
