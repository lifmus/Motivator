module ApplicationHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar", size: "50x50")
  end

  def profile_pic_for(user)
    if user.image != nil
      image_tag(user.image, size: "50x50")
    else
      gravatar_for(user)
    end
  end

end

# "http://graph.facebook.com/540988941/picture?type=square"