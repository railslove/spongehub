$ ->
  $('[data-role=moment]').each (i, el) =>
    element = $(el)
    element.text(moment(element.text(), 'YYYY-MM-DD hh:mm:ss').fromNow())