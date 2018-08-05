require_relative 'render'
module Api
  module V1

    # Contais all the relevant CRUD parts of Witnesses
    # http://localhost3000/api/v1/survivors/:survivor_id/witnesses
    class WitnessesController < ApplicationController
      # Get request on '/'
      def index
        survivor = Survivor.find(params[:survivor_id])
        render_success('Witnesses Loaded', survivor.witnesses)
      end

      # Get request on '/:id'
      def show
        survivor = Survivor.find(params[:survivor_id])
        witness = survivor.witnesses.find_by(witness_id: params[:id])
        render_success('Witness Loaded', witness)
      end

      # Post request on '/', with witness_id in the body
      def create
        # Gets the ids of suvivor and witness
        survivor_id = params[:survivor_id].to_i
        witness_id = params[:witness_id].to_i
        survivor = Survivor.find(survivor_id)

        # If id of witness doesn't belong in the survivors
        survivor_not_belong(survivor, witness_id)

        # If the survivor IS its own witness
        if survivor_id == witness_id
          render_failure('ERROR: Survivors can\'t witness for themselves', survivor)
          return
        # If the witness hasn't already witnessed
        elsif !survivor.witnesses.find_by(witness_id: witness_id)
          # Creates witness in survivor
          witness = survivor.witnesses.create(witness_params)
          if witness.save
            # Saves abducted => true when survivor has 3 or more witnesses
            abducting_survivor(survivor)
            render_success('Witness Saved', witness)
          else
            render_failure('Witness not Saved', witness)
          end
        else
          render_failure('ERROR: Witness already saved', survivor)
        end
      end

      # There is no need for update or destroy

      private

      # Adds 1 to abducted_quantity of repost
      def update_abducted_reports
        report = Report.find(1)
        update_param = {abducted_quantity: report.abducted_quantity + 1}
        report.update(update_param) ? '' : render_failure("Report couldn't be updated", report)
      end

      def abducting_survivor(survivor)
        if survivor.witnesses.size == 2
          if survivor.update({abducted: true})
            update_abducted_reports()
          else
            render_failure("Survivor couldn't be updated", survivor)
          end
        end
      end

      def survivor_not_belong(survivor, witness_id)
        unless Survivor.find_by(id: witness_id)
          render_failure('ERROR: ID of witness doesn\'t exist', survivor)
          return
        end
      end

      def witness_params
        params.require(:witness).permit(:witness_id)
      end

    end
  end
end
