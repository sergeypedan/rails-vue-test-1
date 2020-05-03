# frozen_string_literal: true

class SessionsController < ApiController

  before_action :authorize_access_request!, only: [:destroy]

  def create
    return not_found unless user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      payload = { user_id: user.id }
      session = JWTSessions::Session.new payload: payload, refresh_by_access_allowed: true
      tokens  = session.login
      response.set_cookie JWTSessions.access_cookie, value: tokens[:access], http_only: true, secure: Rails.env.production?
      render json: { csrf: tokens[:csrf] }
    else
      unauthorized
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

  private

  def not_found
    render json: { error: "E-mail / password not found" }, status: :not_found
  end

end
