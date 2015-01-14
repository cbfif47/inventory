class ReportsController < ApplicationController
  def index
      @locations = Location.where(
  end
end
