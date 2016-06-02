module PageObjects
  module Pages
    class InstagramPage < SitePrism::Page
      set_url Settings.instagram_login_url

      element :username, "input[name='username']"
#'#lfFieldInputUsername'
      element :password, "input[name='password']"
#'#lfFieldInputPassword'
      element :login,    "button[class='_aj7mu _taytv _ki5uo _o0442']"

      ### Id of old button on main page
      #'.0.1.0.1.0.1.0.1.3'"

      element :search_input, "input[data-reactid='.0.2.0.1.$searchBox.0']"
    end
  end
end
