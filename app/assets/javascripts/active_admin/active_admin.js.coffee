#= require active_admin/base

$ ->
  if $('#product_sub_category_id').length == 0
    return
  $('#product_sub_category_id').change ->
    if typeof gon != 'undefined' && typeof gon.product_id != 'undefined'
      $.get '/ajax_get_filter_options/' + $(@).val() + '?product_id=' + gon.product_id,
        (data) -> $('#product_filter_options_input').html data
    else
      $.get '/ajax_get_filter_options/' + $(@).val(),
        (data) -> $('#product_filter_options_input').html data


$(document).ready ->
  if $('#product_sub_category_id').length == 0
    return

  product_id = gon.product_id

  if $('#product_sub_category_id').val() > 0
    if product_id.length == 0
      $.get '/ajax_get_filter_options/' + $('#product_sub_category_id').val(),
        (data) -> $('#product_filter_options_input').html data
    else
      $.get '/ajax_get_filter_options/' + $('#product_sub_category_id').val() + '?product_id=' + product_id,
        (data) -> $('#product_filter_options_input').html data

