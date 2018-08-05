module Api
  module V1

    # Contais all the CRUD of Reports in
    # http://localhost3000/api/v1/reports
    class ReportsController < ApplicationController
      # index, show and destroy requests aren't required, as there must be only
      # one report

      # create and update request aren't required, as Report is created when the 
      # first Survivor is added, and updates as the Survivors are added, deleted
      # or abducted

      # Get request on '/list'
      def list
        survivors = Survivor.order("name ASC")
        new_survivors = survivors.map do |survivor|
          {
            survivor: survivor.name,
            flag: survivor.abducted ? '[X]' : '[ ]' 
          }
        end
        render_success('Survivors Loaded', new_survivors)
      end

      # Get request on '/abducted_percentage'
      def abducted_percentage
        report = Report.find(1)
        data = report.abducted_quantity * 100/ report.survivors_quantity
        render_success('Percentage of abducted survivors loaded', data.to_s + '%')
      end

      # Get request on '/non_abducted_percentage'
      def non_abducted_percentage
        report = Report.find(1)
        non_abducted = report.survivors_quantity - report.abducted_quantity
        data = non_abducted * 100/ report.survivors_quantity
        render_success('Percentage of abducted survivors loaded', data.to_s + '%')
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
    end
  end
end
