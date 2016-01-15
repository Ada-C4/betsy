require "action_view/helpers/number_helper"

module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  def nice_price(price)
    price = price / 100.0
    number_to_currency(price)
  end
end
