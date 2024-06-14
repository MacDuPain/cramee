class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    flash[:notice] = "Votre compte a été créé avec succès !"
    super(resource)
  end
end