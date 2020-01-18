class CardSection < SitePrism::Section
  element :card_brand, '[class="card-brand"]'
  element :card_policy_price, '[class="policy-price"] > span[class="value"]'
end