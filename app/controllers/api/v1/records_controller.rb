# frozen_string_literal: true

module Api
  module V1
    class RecordsController < ApiController

      before_action :authorize_access_request!
      before_action :set_record, only: [:destroy, :show, :update]

      def index
        @records = current_user.records
        render json: @records
      end

      def show
        render json: @record
      end

      def create
        @record = current_user.records.build(filtered_params)
        if @record.save
          render json: @record, status: :created, location: "/records/#{@record.id}"
        else
          render json: @record.errors, status: :unprocessable_entity
        end
      end

      def update
        if @record.update(filtered_params)
          render json: @record
        else
          render json: @record.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @record.destroy
      end

      private

      def filtered_params
        params.require(:record).permit(:title, :year, :artist_id)
      end

      def set_record
        @record = current_user.records.find(params[:id])
      end

    end
  end
end

