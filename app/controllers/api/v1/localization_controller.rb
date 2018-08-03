module Api
  module V1

    # Contains the most relevant parts of the CRUD of Localization
    # http://localhost3000/api/v1/survivors/:survivor_id/localization
    class LocalizationController < ApplicationController

      # As there is only one localization per survivor, index equals show
      # Get request on '/'
      def index
        survivor = Survivor.find(params[:survivor_id])
        render_success('Localization loaded', survivor.localization)
      end

      # There is no need for a create, as the Localization is created 
      # as the survivor is created. Nor there is a need for destroy
      # as must exist ONE Localization per survivor

      # Patch request on '/:id', with latitude and logitude in the body
      def update
        localization = Survivor.find(params[:survivor_id]).localization

        if localization.update(localization_params)
          render_success('Localization Updated', localization)
        else
          render_failure('Localization not Updated', localization)
        end
      end

      private

      def localization_params
        params.require(:localization).permit(:latitude, :longitude)
      end

      def render_success(message, data)
        render json: {
          status: 'SUCCESS',
          message: message,
          data: data
        }, status: :ok
      end

      def render_failure(message, data)
        render json: {
          status: 'ERROR',
          message: message,
          data: data.errors
        }, status: :unprocessable_entity
      end

    end
  end
end
