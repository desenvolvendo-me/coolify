module Manager
  class TechnicalReportsController < ApplicationController
    before_action :set_technical_report, only: %i[show edit update destroy]

    def show; end

    def new
      @client = Client.find(params[:client_id])
      @technical_report = @client.technical_reports.build
    end

    def create
      @client = Client.find(params[:client_id])
      @technical_report = @client.technical_reports.build(client: @client, company: @client.company)

      if @technical_report.save
        redirect_to manager_technical_report_path(@technical_report)
      else
        redirect_to manager_clients_path
      end
    end

    private

    def set_technical_report
      @technical_report = TechnicalReport.find(params[:id])
    end

    def technical_report_params
      params.require(:technical_report).permit(:client_id, :company_id)
    end
  end
end

