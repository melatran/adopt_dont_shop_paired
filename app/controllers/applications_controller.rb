class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.create!(application_params)
    application.save
    redirect_to '/favorites'
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
