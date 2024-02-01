module Manager
  class TechnicalReportsController < ApplicationController
    before_action :set_technical_report, only: %i[show edit update destroy]

    def show; end

    def new
      @client = Client.find(params[:client_id])
      @technical_report = @client ? @client.technical_reports.build : TechnicalReport.new
    end

    def create
      @client = Client.find(params[:client_id])
      @technical_report = @client ? @client.technical_reports.build(technical_report_params) : TechnicalReport.new(technical_report_params)

      if @technical_report.save
        redirect_to @technical_report
      else
        render :new
      end
    end

    def edit; end

    def update
      if @technical_report.update(technical_report_params)
        redirect_to @technical_report, notice: 'Technical report was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @technical_report.destroy
      redirect_to technical_reports_path, notice: 'Technical report was successfully destroyed.'
    end

    def generate_reports; end

    private

    def set_technical_report
      @technical_report = TechnicalReport.find(params[:id])
    end

    def technical_report_params
      params.require(:technical_report).permit(:client_id, :company_id)
    end
  end
end

