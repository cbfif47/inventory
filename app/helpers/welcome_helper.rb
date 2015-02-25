module WelcomeHelper
  
  def showtime_link(show, text)
    if show
      link_to "#{text} Show: #{show.venue}" , show_path(show), :class=> 'btn btn-primary'
    end
  end
  
  def setup_links(object,text,place)
    if object == 0
      link_to "Setup #{text}", place, :class=> 'btn btn-primary'
    end
  end

end
