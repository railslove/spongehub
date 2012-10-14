hideFlash = -> $('[data-role=flash]').fadeOut('slow')

$ ->
  $('[data-role=flash]')
    .css('bottom', $(document).height() - $(window).height() - $(window).scrollTop())
    .slideDown('slow', ->
      $(window).unbind('scroll').scroll(hideFlash)
      window.clearTimeout(window.flash_timeout)
      window.flash_timeout = window.setTimeout(hideFlash, (if $(this).data('type')=='alert' then 10000 else 5000))
      $(this).find('[data-role=close]').unbind('click').click(hideFlash)
    )
