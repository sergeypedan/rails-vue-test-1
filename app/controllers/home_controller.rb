# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @artists = Artist.includes(:records)
    render layout: "application"
  end

end
