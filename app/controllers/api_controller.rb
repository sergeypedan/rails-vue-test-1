# frozen_string_literal: true

class ApiController < ActionController::API

  include JWTSessions::RailsAuthorization

  rescue_from JWTSessions::Errors::Unauthorized, with: :unauthorized

  private

  def current_user
    @current_user ||= User.find(payload["user_id"])
  end

  def unauthorized
    render json: { error: "Unauthorized" }, status: :unauthorized
  end

end
