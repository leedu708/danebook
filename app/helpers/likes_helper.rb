module LikesHelper


  def display_likers(object)

      names = get_liker_names(object)

      name_string = names.join(" and ")
      verb = conjugate_like(names)

      if object.likers.count > 2
        "#{name_string} and #{pluralize(object.likers.count - 2, 'other')} #{verb} this."
      elsif object.likers.count > 0
         "#{name_string} #{verb} this."
      end

  end


  private


  def get_liker_names(object)

    names = []
    names << "You" if liked_by_current_user?(object)

    object.likers.first(2).map do |liker|
      names << liker.profile.full_name unless liker == current_user
    end

    names.first(2)

  end

  def liked_by_current_user?(object)

    current_user && object.likers.include?(current_user)

  end

  def conjugate_like(names)

    if names.size == 1 && !names.include?('You')
      'likes'
    else
      'like'
    end

  end

end