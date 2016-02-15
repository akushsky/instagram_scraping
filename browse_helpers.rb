def login(username, password)
  $app.instagram.username.set username
  $app.instagram.password.set password
  $app.instagram.login.click
  sleep(3)
end

def search_tag(hash_tag)
  $app.explore_tags.load hash_tag: hash_tag
  sleep(3)

  first_post = $app.explore_tags.posts.first
  if first_post.nil?
    false
  end
  first_post.click
  true
end

def search_location(location_id)
  $app.explore_locations.load location_id: location_id
  sleep(3)

  first_post = $app.explore_locations.posts.first
  if first_post.nil?
    false
  end
  first_post.click
  true
end

class String
    def is_i?
       /\A[-+]?\d+\z/ === self
    end
end