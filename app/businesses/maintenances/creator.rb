module Maintenances
  class Creator < BusinessApplication

    def initialize(maintenance_params)
      @maintenance_params = maintenance_params
    end

    def call
      create
      find_to_do_plan
      link_to_plan
      @maintenance
    end

    private

    def create
      @maintenance = Maintenance.new(@maintenance_params)
    end

    def find_to_do_plan
      @todo_plan = MaintenancePlan.find_by(status: :to_do, company_id: @maintenance.company_id)
    end

    def link_to_plan
      return unless @todo_plan

      @maintenance.update(maintenance_plan: @todo_plan)
    end
  end
end
