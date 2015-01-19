class WelcomeController < ApplicationController
  def index
      @preroll = Preroll.find_by id: 1
    @locations = Location.where(:active => true)   
  end
end
