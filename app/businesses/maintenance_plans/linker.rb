module MaintenancePlans
  class Linker < BusinessApplication

    def initialize(maintenance)
      @maintenance = maintenance
    end

    def call
      check_to_do_plan
      link_to_plan
    end

    private

    def check_to_do_plan
      @todo_plan = MaintenancePlan.find_by(status: :to_do)
    end

    def link_to_plan
      @maintenance.update(maintenance_plan: @todo_plan)
    end
  end
end
