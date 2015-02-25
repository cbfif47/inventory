module ShowsHelper
  
  def show_guests
    if @guests.count > 0
      link_to pluralize((@guests.count + @guests.sum(:plus)),"guest"), "#", rel:"popover", :"data-toggle"=>"popover", :"title"=>"#{current_user.group.name} Guests #{@show.date.strftime("%-m/%-d")}", :"data-content"=> "#{render 'guestlist'}" 
    else
    link_to "Add Guests", edit_show_path(component:"guests")
    end
  end
  
  def show_notes
    if @show.notes.blank?
      link_to "Add Notes", edit_show_path(component:"notes"), class:"btn btn-primary"
    else
      render 'notes'
    end
  end

  def show_count
    if @islatest && @countins.blank? && @needins.present?
      link_to 'Count In', new_show_count_path(@show, direction:"in"), :class=> 'btn btn-primary'
    elsif @islatest && @needouts.present?
      link_to 'Count Out', new_show_count_path(@show, direction:"out"), :class=> 'btn btn-primary'
    end
  end

end
