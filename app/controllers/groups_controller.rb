class GroupsController < ApplicationController
  before_filter :check_admin
  
  def new
      @group = Group.new
  end

def create
        @group = Group.new(group_params)
        if @group.save
            redirect_to action: 'index'
        else
            render 'new'
        end
end

def show
    @group = Group.find(params[:id])
end
    
    def edit
        @group = Group.find(params[:id])
    end
    
    def update
        @group = Group.find(params[:id])
        if @group.update(group_params)
                redirect_to action: 'index'
                    else
            render 'edit'
        end
    end
    
  def index
    @groups = Group.all
  end


  def delete
  end
    
    private
    def group_params
        params.require(:group).permit(:name)
    end
  
  def check_admin
    unless current_user.admin?
      flash[:error] = "Quit sneaking around, you ain't no admin!"
      redirect_to root_url # halts request cycle
    end
  end
end
