# frozen_string_literal: true

module Api
  module V1
    class ArtistsController < ApiController

      before_action :authorize_access_request!, except: [:index, :show]
      before_action :set_artist, only: [:destroy, :show, :update]

      def index
        @artists = Artist.all
        render json: @artists
      end

      def show
        render json: @artist
      end

      def create
        @artist = Artist.new(filtered_params)
        if @artist.save
          render json: @artist, status: :created, location: "/artists/#{@artist.id}"
        else
          render json: @artist.errors, status: :unprocessable_entity
        end
      end

      def update
        if @artist.update(filtered_params)
          render json: @artist, status: :ok, location: "/artists/#{@artist.id}"
        else
          render json: @artist.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @artist.destroy
          render head: :ok
        else
          render json: @artist.errors, status: :unprocessable_entity
        end
      end

      private

      def filtered_params
        params.require(:artist).permit(:name)
      end

      def set_artist
        @artist = Artist.find(params[:id])
      end

    end
  end
end

