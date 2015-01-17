class WelcomeController < ApplicationController
  def index
      @preroll = Preroll.find_by id: 1
  end
end
