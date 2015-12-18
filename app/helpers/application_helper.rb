module ApplicationHelper
  def render_stars(rating)
    output = ''
    if (1..5).include?(rating)
      rating.times { output += fa_icon('star') }
    end
    output.html_safe
  end
end
