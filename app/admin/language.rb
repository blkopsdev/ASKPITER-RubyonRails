ActiveAdmin.register Language do

  permit_params :name

  filter :name

end
