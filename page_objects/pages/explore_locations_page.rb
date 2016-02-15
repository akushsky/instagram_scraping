module PageObjects
  module Pages
    class ExploreLocationsPage < SitePrism::Page
      set_url "#{Settings.instagram_root_url}/explore/locations{/location_id}/"

      elements :posts, "a[class='_8mlbc _t5r8b']"
#'a.-cx-PRIVATE-PostsGridItem__root.-cx-PRIVATE-PostsGrid__item'
      elements :likes,  'a.coreSpriteHeartOpen'
      elements :comment_forms, 'form.-cx-PRIVATE-PostInfo__commentCreator'
      elements :comments, ".-cx-PRIVATE-PostInfo__commentCreatorInput"

      element :next_post, 'a.coreSpriteRightPaginationArrow'
#'a.-cx-PRIVATE-PostModalConsumer__rightArrow'
    end
  end
end
