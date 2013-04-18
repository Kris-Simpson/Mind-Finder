class HomeController < ApplicationController
  def index
    @user = User.new
  end

  def change_locale
    locale = params[:locale]
    raise 'unsupported locale' unless ['ru', 'en', 'uk' ].include?(locale)

    User.find(current_user.id).update_attribute(:locale, locale) if current_user && !current_user.blank?

    I18n.locale = locale

    redirect_to :index
  end
end
