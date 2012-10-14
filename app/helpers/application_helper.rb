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

  def formatted_karma(karma)
    if karma > 0
      content_tag(:span, karma, class: 'good')
    elsif karma < 0
      content_tag(:span, karma, class: 'bad')
    else
      content_tag(:span, karma, class: 'none')
    end
  end

  def formatted_rating(rating)
    body = h(rating.text)
    if user = rating.rated
      user_link = link_to("@#{user.name}", user)

      token = TextUserTokenizer.new(rating.text, [rating.rated]).unique_match_token

      body = if body.match(/@#{token}/)
        body.gsub(/@#{token}/, user_link)
      else
        user_link + ' ' + body
      end
    end
    body.html_safe
  end
end
