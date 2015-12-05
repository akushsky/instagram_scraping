module PageObjects
  module Pages
    class ExploreTagsPage < SitePrism::Page
      set_url "#{Settings.instagram_root_url}/explore/tags{/hash_tag}/"

      elements :posts, "a[class='t79 i49']"
#'a.-cx-PRIVATE-PostsGridItem__root.-cx-PRIVATE-PostsGrid__item'
      elements :likes,  'a.coreSpriteHeartOpen'
      elements :comment_forms, 'form.-cx-PRIVATE-PostInfo__commentCreator'
      elements :comments, ".-cx-PRIVATE-PostInfo__commentCreatorInput"

      element :next_post, 'a.coreSpriteRightPaginationArrow'
#'a.-cx-PRIVATE-PostModalConsumer__rightArrow'
    end
  end
end
