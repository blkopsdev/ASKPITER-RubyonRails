json.title 'Add a video'
json.body render partial: 'videos/add', formats: %i(html), locals: body_locals
json.footer yield :action
