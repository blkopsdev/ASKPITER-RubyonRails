class RegistrationsController < Devise::RegistrationsController
  def edit
    current_user.build_address unless current_user.address
  end

  private
  def account_update_params
    params.require(:user).permit(:email,:password, :password_confirmation, :current_password,
      :name, :last_name, :language_id, :currency_id, address_attributes: [:id, :country, :city])
  end
end