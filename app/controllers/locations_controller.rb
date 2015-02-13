class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
  
  def new
      @location = Location.new
  end

  def create
        @location = Location.new(location_params)
        @others = @location.others(current_user)
        if @location.save
            if @location.available == true
                @others.each do |other|
                    other.update(:available => false)
                end
                else
              @primary = Location.primary(current_user) 
              unless @primary.any?
                @location.update(available: true)
              end
            end
            redirect_to action: 'index'
        else
            render 'new'
        end
  end

  def show
  end
    
  def edit
  end
    
  def update
    @others = @location.others(current_user)
        if @location.update(location_params)
            if @location.available == true
                @others.each do |other|
                    other.update(:available => false)
                end
                else
            if @primary.blank?
                @location.update(available: true)
            end
        end
                redirect_to action: 'index'
                    else
            render 'edit'
        end
    end
    
  def index
    @locations = Location.where("group_id = ?", current_user.group_id)
  end


  def delete
  end
    
  private
    def location_params
        params.require(:location).permit(:name,:available,:active).merge(group_id: current_user.group_id)
    end
    
  
  def set_location
    @location = Location.find(params[:id])
    check_user(@location)
    @primary = Location.primary(current_user)
  end
  
  def set_others

  end
  
end
