require "capybara"

Capybara.default_driver = :selenium

require 'capybara/dsl'
require 'site_prism'

$LOAD_PATH << File.expand_path("..", __FILE__)

require 'settings'
require 'page_objects/pages/instagram_page'
require 'page_objects/pages/explore_tags_page'
require 'page_objects/application'
require 'browse_helpers'

username = ARGV[0].chomp
hash_tag = ARGV[1].chomp
comment  = ARGV[2].chomp

puts "Email: #{username}"
puts "Hash Tag: #{hash_tag}"

ARGV.clear

puts "Please, give me your password to login to Instagram: "
password = gets.chomp
if password.empty?
  puts "It cannot be blank"
  exit 1
end

$app = PageObjects::Application.new

$app.instagram.load

login(username, password)

any_results = search(hash_tag)

unless any_results
  puts "No results"
  exit(0)
end

sleep(2)

i = 0
next_post_button = true
while next_post_button
  like_heart = $app.explore_tags.likes.first

  if like_heart.nil?
    puts "no like heart found"
  else
    like_heart.click

    comment_input = $app.explore_tags.comments.first
    if comment_input.nil?
      puts "no comment area found"
    else
      comment_input.set "#{comment}\n"
    end
  end

  next_post_button = $app.explore_tags.next_post
  sleep(3)

  unless next_post_button.nil?
    next_post_button.click
    i += 1
    puts "going to post #{i}"
    sleep(2)
  end

end