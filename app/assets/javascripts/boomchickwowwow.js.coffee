jQuery.fn.boomchickawowwow = ->
  $(this).animate {height: '100px', width: '80px'}, 200, ->
    $(this).parent().siblings('[data-role=text]').fadeIn 'fast', ->
      $(this).parent('li').find('img').animate {height: '80px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeOut 'fast'

$ ->
  $('[data-role=boomchickawowwow] img')
    .on('mouseenter', ->
      $(this).animate {height: '100px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeIn('fast')
    ).on('mouseleave', ->
      $(this).animate {height: '80px', width: '80px'}, 200, ->
        $(this).parent().siblings('[data-role=text]').fadeOut('fast')
    )

