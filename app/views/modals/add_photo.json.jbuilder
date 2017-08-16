json.title 'Add a photo'
json.body render partial: 'photos/add', formats: %i(html), locals: body_locals
json.footer yield :action
