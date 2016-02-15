require "capybara"

Capybara.default_driver = :selenium

require 'capybara/dsl'
require 'site_prism'

$LOAD_PATH << File.expand_path("..", __FILE__)

require 'settings'
require 'page_objects/pages/instagram_page'
require 'page_objects/pages/explore_tags_page'
require 'page_objects/pages/explore_locations_page'
require 'page_objects/application'
require 'browse_helpers'

def read_from_file(filename)
  full_path = "#{File.expand_path("..", __FILE__)}/#{filename}"
  result = []
  File.readlines(full_path).each do |line|
    line.chomp!
    result << line unless line.empty?
  end
  result
end

username = ARGV[0].chomp
# hash_tag = ARGV[1].chomp
hash_tags = nil
hash_tags = read_from_file(ARGV[1].chomp) unless ARGV[1].nil?
#comment  = ARGV[2].chomp

ARGV.clear

puts "Please, give me your password to login to Instagram: "
password = gets.chomp
if password.empty?
  puts "It cannot be blank"
  exit 1
end

puts "Email: #{username}"

Capybara.register_driver :firefox_bin do |app|

  require 'selenium/webdriver'
  Selenium::WebDriver::Firefox::Binary.path = "/usr/bin/firefox"

  Capybara::Selenium::Driver.new(app, :browser => :firefox)
end

Capybara.default_driver = :firefox_bin


$app = PageObjects::Application.new

$app.instagram.load

login(username, password)

hash_tags.each { |hash_tag|

  if hash_tag.is_i?
    puts "Location: #{hash_tag}" #TODO

    any_results = search_location(hash_tag)
  else

    puts "Hash Tag: #{hash_tag}"

    any_results = search_tag(hash_tag)
  end

  unless any_results
    puts "No results"
    # exit(0)
    next
  end

  sleep(2)

  i = 1
  j = 1
  next_post_button = true
  while next_post_button
    puts "[#{Time.now.strftime("%H:%M")}]" + " going to post #{i}"

    like_heart = $app.explore_tags.likes.first

    if like_heart.nil?
      puts "...no like heart found"
      j += 1
    else
      if j > 0
        j -= 1
      end
      like_heart.click

  #    comment_input = $app.explore_tags.comments.first
  #    if comment_input.nil?
  #      puts "...no comment area found"<
  #    else
  #      comment_input.set "#{comment}\n"
  #      puts "...comment posted"
  #    end
    end

    # TODO: Rewrite, not 3000, but check days on page
    if j == 10 || i > 3000
      next_post_button = false

      # Write info about current tag likes at all
      File.open("logs/#{Time.now.strftime("%d-%m-%Y")}.log", 'a') { |file| file.puts("[##{hash_tag}] - #{i} likes") }

      # TODO: Move to function
      sleeping_time = Time.now + 45*60
      puts "Sleeping until #{sleeping_time.strftime("%H:%M")}"

      sleep(45*60)


      next
    end

    next_post_button = $app.explore_tags.next_post
    sleep(3)

    unless next_post_button.nil?
      next_post_button.click
      i += 1
      sleep(2)
    end

    if i % 100 == 0
      sleeping_time = Time.now + 45*60
      puts "Sleeping until #{sleeping_time.strftime("%H:%M")}"

      sleep(45*60)
    end
  end
}
