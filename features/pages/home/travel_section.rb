class TravelSection < SitePrism::Section
  element :form_content, '[class="form-content"]'
  element :show_my_result_button, 'button[name="product-form-submit"] link'
  element :trip_type, '[data-gb-name="trip-type"]'

end