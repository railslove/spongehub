module ApplicationHelper
  def render_calendar_cell(date)
    chores = ""
    if @month_chores[date]
      @month_chores[date].each do |chore|
        chores += content_tag :li, link_to(chore.title, [@space, chore])
      end
      chores = content_tag :ul, chores.html_safe, class: "unstyled"
    else
      chores = ""
    end

    content_tag :div, class: "m-calendar--cell" do
      (date.day.to_s + chores).html_safe
    end
  end
end
