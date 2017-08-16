ActiveAdmin.register Currency do

  permit_params :name, :exchange_rate, :sign, :code

  filter :name
  filter :exchange_rate
  filter :code

end
