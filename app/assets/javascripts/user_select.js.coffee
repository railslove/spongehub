imageFormat = (user_item) ->
  "<img class='flag' src='" + user_item.remote_image_url + "'/>" + user_item.name

$ ->
  $('[data-role=select]').select2
    placeholder: "Choose an user"
    minimumInputLength: 2
    ajax:
      url: '/users.json'
      dataType: 'jsonp'
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

