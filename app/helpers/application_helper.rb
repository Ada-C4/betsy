module ApplicationHelper
  def readable_date(date)
   date.strftime("%B %e, %Y - %I:%M")
  end

  def cents_to_dollars(money)
    number_to_currency(money/100)
  end

  def cc_expiration(date)
    date.strftime("%b %Y")
  end
end
