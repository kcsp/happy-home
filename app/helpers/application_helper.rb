module ApplicationHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.mail.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "img-thumbnail")
	end

end
