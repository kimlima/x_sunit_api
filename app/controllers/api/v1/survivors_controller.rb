module Api
  module V1

    # Contais all the CRUD of Survivors in
    # http://localhost3000/api/v1/survivors
    class SurvivorsController < ApplicationController
      # Get request on '/'
      def index
        survivors = Survivor.all
        render_success('Survivors Loaded', survivors)
      end
      
      # Get request on '/:id'
      def show
        survivor = Survivor.find(params[:id])
        render_success('Survivor Loaded', survivor)
      end

      # Post request on '/', with name, age, and gender in the body
      def create

        # Sets abducted to false, as there is no need to pass it by request
        surv = survivor_params
        surv[:abducted] = false
        survivor = Survivor.new(surv)

        # Creates an adds the Localization to the Survivor
        survivor.localization = Localization.new({
          latitude: params[:latitude],
          longitude: params[:longitude]
        })

        if survivor.save
          render_success('Survivor Saved', survivor)
        else
          render_failure('Survivor not saved', survivor)
        end
      end

      # Patch request on '/:id', with name, age, and gender in the body
      def update
        survivor = Survivor.find(params[:id])

        if survivor.update(survivor_params)
          render_success('Survivor Updated', survivor)
        else
          render_failure('Survivor not updated', survivor)
        end
      end

      # Delete request on '/:id
      def destroy
        survivor = Survivor.find(params[:id])
        survivor.destroy

        render_success('Survivor Deleted', survivor)
      end

      private

      def survivor_params
        params.require(:survivor).permit(:name, :gender, :age)
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
