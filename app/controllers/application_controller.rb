# coding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
 
  def set_locale
    if current_user
      I18n.locale = current_user.locale
    else
      I18n.locale = params[:locale] || I18n.default_locale
    end
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end
  
private
  
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def get_full_locale
    locale_full = ""
    
    case I18n.locale
      when :en
        locale_full = "English"
      when :ru
        locale_full = "Русский"
      when :uk
        locale_full = "Українська"
      end

    locale_full
  end
  
  helper_method :current_user, :get_full_locale
  
end
