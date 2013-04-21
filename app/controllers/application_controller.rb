# coding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale, :redirect_current_user
 
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

  def redirect_current_user
    redirect_to :rooms if current_user && (current_uri == "/index" || current_uri == "/")
  end
  
private
  
  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  def get_full_locale
    locale_full = [ "English", "Русский", "Українська" ]
    
    case I18n.locale
      when :en
        return locale_full[0]
      when :ru
        return locale_full[1]
      when :uk
        return locale_full[2]
      end
  end

  def current_uri
    @current_uri = request.env['PATH_INFO']
  end
  
  helper_method :current_user, :get_full_locale, :current_uri
  
end