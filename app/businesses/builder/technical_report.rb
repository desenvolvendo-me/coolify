module Builder

  class TechnicalReport < BusinessApplication
    def initialize(client)
      @client = client
    end

    def call
      generate_all
    end

    def generate_all
      @client.company.equipment
    end
  end
end
