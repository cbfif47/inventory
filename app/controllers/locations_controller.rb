class LocationsController < ApplicationController
    before_action :set_location, only: [:show, :edit, :update, :destroy]
  
  def new
      @location = Location.new
  end

  def create
        @location = Location.new(location_params)
        @others = @location.others(current_user)
        if @location.save
            if @location.primary == true
                @others.each do |other|
                    other.update(:primary => false)
                end
              else
              @primary = Location.prime(current_user) 
              if !@primary
                @location.update(primary: true)
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
            if @location.primary == true
                @others.each do |other|
                    other.update(:primary => false)
                end
                else
            if @primary
                @location.update(primary: true)
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
        params.require(:location).permit(:name,:primary,:active).merge(group_id: current_user.group_id)
    end
    
  
  def set_location
    @location = Location.find(params[:id])
    check_user(@location.group_id)
    @primary = Location.prime(current_user)
  end
  
  def set_others

  end
  
end
