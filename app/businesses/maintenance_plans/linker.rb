module MaintenancePlans
  class Linker < BusinessApplication

    def initialize(maintenance)
      @maintenance = maintenance
    end

    def call
      find_to_do_plan
      link_to_plan
    end

    private

    def find_to_do_plan
      @todo_plan = MaintenancePlan.find_by(status: :to_do, company_id: @maintenance.company_id)
    end

    def link_to_plan
      return unless @todo_plan

      @maintenance.update(maintenance_plan: @todo_plan)
    end
  end
end
