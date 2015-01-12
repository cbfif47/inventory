class LocationsController < ApplicationController
  def new
      @location = Location.new
  end

def create
        @location = Location.new(location_params)
        
        if @location.save
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
        
        
        if @location.update(location_params)
            redirect_to action: 'index'
                    else
            render 'edit'
        end
    end
    
  def index
      @locations = Location.all
  end


  def delete
  end
    
    private
    def location_params
        params.require(:location).permit(:name,:on_tour,:active)
    end
    
end
