Spree::UserRegistrationsController.class_eval do

  after_filter :clear_omniauth, :only => :create

  private

  def build_resource(*args)
    super
    if session[:omniauth]
      spree_current_user.apply_omniauth(session[:omniauth])
    end
    spree_current_user
  end

  def clear_omniauth
    session[:omniauth] = nil unless spree_current_user.new_record?
  end
end
