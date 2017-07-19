class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  def allowed?(action: , user:)
    if action == "verify"
      if user.moderator? || user.admin?
        return true
      else
        return false
      end
    end
  end
end
