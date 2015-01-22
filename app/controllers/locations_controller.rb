class LocationsController < ApplicationController
  def new
      @location = Location.new
  end

def create
        @location = Location.new(location_params)
        if @location.save
          @others = Location.where("id != ? AND group_id = ?", @location.id, current_user.group_id)
            if @location.available == true
                @others.each do |other|
                    other.update(:available => false)
                end
                else
              @primary = Location.where("available = ? AND group_id = ?", true, current_user.group_id)
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
    @location = Location.find(params[:id])
end
    
    def edit
        @location = Location.find(params[:id])
    end
    
    def update
        @location = Location.find(params[:id])
      @others = Location.where("id != ? AND group_id = ?", params[:id], current_user.group_id)
        
        if @location.update(location_params)
            if @location.available == true
                @others.each do |other|
                    other.update(:available => false)
                end
                else
                @primary = Location.where("available = ? AND group_id = ?", true, current_user.group_id)
              unless @primary.any?
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
    
end
