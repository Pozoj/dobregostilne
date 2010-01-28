class ApplicationController < ActionController::Base
  helper :all
  helper_method :admin?, :current_locale, :body_attrs
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
     I18n.locale = current_locale
  end

  def current_locale
    if params[:locale]
      (I18n.available_locales.include? params[:locale].to_sym) ? params[:locale] : "en"
    else
      "en"
    end
  end

  def admin?
    false
  end
  
  def body_attrs
   { :class => controller_name, :id => "#{controller_name}-#{action_name}" }
  end
end
