class FilterSection < SitePrism::Section
  element :promotion_radio, '[data-filter-by="promotion"][class^="radio"]'
  element :insurer_checkbox_option, '[data-filter-by="insurerId"] [data-gb-name="filter-option"]'
  element :see_more_button, '[data-filter-by="filter-see-more"]'

  def check_insurercheckbox(insurer)
    toogle_insurercheckbox(insurer, true)
  end

  def uncheck_insurercheckbox(insurer)
    toogle_insurercheckbox(insurer, false)
  end

  private
  
  def toogle_insurercheckbox(insurer,state)
    insurer_checkbox = insurer_checkbox_option(text: insurer)
    checkbox_status = insurer_checkbox.find('input', visible: false).checked?
    insurer_checkbox.click if checkbox_status != state
  end
end