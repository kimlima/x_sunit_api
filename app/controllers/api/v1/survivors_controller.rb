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
        surv = survivor_params()
        surv[:abducted] = false
        survivor = Survivor.new(surv)

        # Creates an adds the Localization of the Survivor
        survivor.localization = Localization.new({
          latitude: params[:latitude],
          longitude: params[:longitude]
        })

        if survivor.save
          # Adds 1 on the survivors_quantity of report
          update_survivors_reports(+1, survivor.abducted)

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

        # Removes 1 from survivors_quantity and, if the survivor was one
        # abducted, removes from abducted_quantity
        update_survivors_reports(-1, survivor.abducted)

        survivor.destroy

        render_success('Survivor Deleted', survivor)
      end

      private

      def create_report(value)
        report = Report.new({
          abducted_quantity: 0,
          survivors_quantity: value
        })
        report.save ? '' : render_failure("Report couldn't be initialized", report)
      end

      def update_survivors_reports(value, is_abducted)

        # Creates a report if no one exists
        if Report.all.size.zero?
          create_report(value)
        else
          report = Report.find(1)
          update_param = {survivors_quantity: report.survivors_quantity + value}
          update_param[:abducted_quantity] = report.abducted_quantity + value if is_abducted
          report.update(update_param) ? '' : render_failure("Report couldn't be updated", report)
        end
      end

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
