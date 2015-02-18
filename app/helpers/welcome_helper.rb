module WelcomeHelper
  
  def next_show
    if @next
      link_to "Next Show: #{@next.venue}" , show_path(@next), :class=> 'btn btn-primary'
    else
      "No Upcoming Shows"
    end
  end
  
end
