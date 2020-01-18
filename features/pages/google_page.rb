class GooglePage < SitePrism::Page
  set_url '/'
  element :textbox, 'input[class="gLFyf gsfi"]'
  
  def enter_textbox (text)
    textbox.set(text)
  end
end
