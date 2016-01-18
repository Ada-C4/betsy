module ApplicationHelper
  def dollar_price(amount)
    number_to_currency(amount / 100.0)
  end

  def bootstrap_class_for flash_type
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-block"
      when "notice"
        "alert-info"
      else
        flash_type.to_s
    end
  end

  def readable_date(date)
    date.strftime('%b %-e, %Y')
  end

  def readable_time(date)
    date.strftime("%l:%M%p")
  end
end
