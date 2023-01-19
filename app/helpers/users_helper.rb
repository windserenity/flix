module UsersHelper

    def profile_image(user)
        url = "https://secure.gravatar.com/avatar/"
        url << user.gravatar_id 
        image_tag(url, alt: user.name)
      end

end
