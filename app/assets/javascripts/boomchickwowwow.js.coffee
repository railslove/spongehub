jQuery.fn.boomchickawowwow = ->
  $(this).animate {height: '100px', width: '80px'}, 200, ->
    $(this).parent().siblings('[data-role=text]').fadeIn 'fast', ->
      $(this).parent('li').find('img').animate {height: '80px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeOut 'fast'

$ ->
  $('[data-role=boomchickawowwow] li')
    .on('mouseenter', ->
      $(this).find('img').animate {height: '100px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeIn('fast')
    ).on('mouseleave', ->
      $(this).find('img').animate {height: '80px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeOut('fast')
    )

