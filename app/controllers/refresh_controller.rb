# frozen_string_literal: true

class RefreshController < ApiController

  before_action :authorize_access_request!

  def create
    session = JWTSessions::Session.new payload: claimless_payload, refresh_by_access_allowed: true
    tokens  = session.refresh_by_access_allowed do
      raise JWTSessions::Errors::Unauthorized, "Something's not right"
    end
    response.set_cookie JWTSessions.access_cookie, value: tokens[:access], http_only: true, secure: Rails.env.production?
    render json: { csrf: tokens[:csrf] }
  end

end
