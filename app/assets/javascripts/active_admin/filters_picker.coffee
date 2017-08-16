$ ->
  $('#product_sub_category_id').change ->
    $.get '/ajax_get_filter_options/' + $(@).val(),
      (data) -> $('#product_filter_options_input').html data


