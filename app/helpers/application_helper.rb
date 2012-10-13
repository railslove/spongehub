module ApplicationHelper
  def render_calendar_cell(date)
    content_tag :div, class: "m-calendar--cell" do
      date.day.to_s
    end
  end
end
