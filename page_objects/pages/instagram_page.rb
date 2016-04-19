module PageObjects
  module Pages
    class InstagramPage < SitePrism::Page
      set_url Settings.instagram_login_url

      element :username, "input[data-reactid='.0.0.0.0.1.2.0.0']"
#'#lfFieldInputUsername'
      element :password, "input[data-reactid='.0.0.0.0.1.2.1.0']"
#'#lfFieldInputPassword'
      element :login,    "button[data-reactid='.0.0.0.0.1.2.2.0']"

      ### Id of old button on main page
      #'.0.1.0.1.0.1.0.1.3'"

      element :search_input, "input[data-reactid='.0.2.0.1.$searchBox.0']"
    end
  end
end
