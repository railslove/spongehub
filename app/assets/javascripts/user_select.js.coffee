imageFormat = (user_item) ->
  "<img class='flag' src='" + user_item.remote_image_url + "'/>" + user_item.name

$ ->
  $('[data-role=select]').each (i, element) =>
    item = $(element)
    src_url = item.attr('data-source')
    item.select2
      placeholder: "Choose an user"
      minimumInputLength: 2
      ajax:
        url: src_url
        dataType: 'json'
        data: (term, page) ->
          q: term
          page_limit: 10
          page: page
        results: (data, page) ->
          results: data
      formatResult: imageFormat
      formatSelection: imageFormat
      dropdownCssClass: 'm-user-dropdown'
      containerCssClass: 'm-user-dropdown'
