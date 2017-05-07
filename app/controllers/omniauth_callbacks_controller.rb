class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # used to upgrade the app access rights
  # <%= link_to "Upgrade Access", user_omniauth_upgrade_path( :google_oauth2 ) %>
  def upgrade
    scope = nil
    if params[:provider] == "google_oauth2"
      scope = "email,profile,offline"#,https://www.googleapis.com/auth/admin.directory.user"
    end

    redirect_to user_omniauth_authorize_path( params[:provider] ), flash: { scope: scope }
  end

  def setup
    request.env['omniauth.strategy'].options['scope'] = flash[:scope] || request.env['omniauth.strategy'].options['scope']
    render :plain => "Setup complete.", :status => 404
  end

  def facebook
    generic_callback( 'facebook' )
  end

  def google_oauth2
    generic_callback( 'google_oauth2' )
  end
  
  def generic_callback( provider )
    @identity = Identity.find_for_oauth request.env["omniauth.auth"]

    @user = @identity.user || current_user

    if @user.nil?
      @user = User.create( email: @identity.email, oauth_callback: true )
      @identity.update_attribute( :user_id, @user.id )
    end

    if @user.email.blank? && @identity.email
      @user.update_attribute( :email, @identity.email)
    end

    if @user.persisted?
      @identity.update_attribute( :user_id, @user.id )
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end