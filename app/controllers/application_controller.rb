class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user_info_session, :current_user_info

  private

  def current_user_info_session
  	@current_user_info_session ||= UserInfoSession.find
  end

  def current_user_info
  	@current_user_info ||= current_user_info_session && current_user_info_session.record
  end
end
