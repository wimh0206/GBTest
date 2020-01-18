require_relative './/travel_section'

class InsuranceHomePage < SitePrism::Page
  set_url '/'
  element :insurance_tab, '[data-gb-name="Insurance"] a'
  element :travel_tab, '[data-gb-name="Travel"] a'
  section :travel_page_section, TravelSection, '[id="Travel"]'
  element :travel_page, '[class^="page-insurance-travel"]'

end
