class UserAdminAuthorization < ActiveAdmin::AuthorizationAdapter

  def authorized?(admin, subject = nil)
    user.admin?
  end

end
