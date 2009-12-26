class ApplicationController < ActionController::Base
  helper :all
  helper_method :admin?
  protect_from_forgery
  
  before_filter :set_locale
  
  def set_locale
     I18n.locale = current_locale || "en"
  end

  def current_locale
    if params[:locale]
      (I18n.available_locales.include? params[:locale].to_sym) ? params[:locale] : nil
    end
  end

  def admin?
    true
  end
end
