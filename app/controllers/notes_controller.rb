class NotesController < ApplicationController
  skip_before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token
  def create #allow users to create show notes via cloudmailin emails
    if @user = User.find_by(email:params[:envelope][:from])
      if @date = incoming_date(params[:headers][:Subject])
        if @show = Show.owned(@user).find_by(date:@date)
          if @show.notes.present?
            @show.update(notes:"#{@show.notes}<br>#{params[:plain]}") #if theres already notes, keep them and add a br
          else
            @show.update(notes:params[:plain])
          end
          render :text => 'Success!', :status => 200 #message received and saved on record
        else
          render :text => 'Show not found', :status => 404
        end
      else
        render :text => 'Invalid Date', :status => 404
      end
    else
      render :text => 'Unknown user', :status => 404 # 404 would reject the mail
    end
  end
end
