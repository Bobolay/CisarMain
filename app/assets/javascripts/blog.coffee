apply_filter = ()->
  $tags_container = $(".tag-container")
  checked_tag_ids = $tags_container.find(".tag.checked").map(
    ()->
      $tag = $(this)
      tag_ids = parseInt($tag.attr("data-tag-id"))
  ).toArray()

#  $article.split(",").toArray().map(
#    (e)->
#      if e && e.length
#        parseInt(e)
#      else
#        null
#  ).filter(
#    (e)->
#      e != null && e != undefined
#  )

  $articles = $(".article")
  $articles.removeClass("hide").addClass("show")
  $articles_to_hide = $articles.filter(
    ()->
      article_tag_ids = $(this).attr("data-tag-ids").split(",").map(
        (e)->
          parseInt(e)
      )

      for id in article_tag_ids
        if checked_tag_ids.indexOf(id) >= 0
          return false

      return true
  )

  if checked_tag_ids.length > 0
    $articles_to_hide.removeClass("show").addClass("hide")


  console.log "checked_tag_ids", checked_tag_ids



$("body").on "click", ".tag-container .tag", ()->
  $tag = $(this)

  checked = $tag.hasClass("checked")
  if checked
    $tag.removeClass("checked")
  else
    $tag.addClass("checked")

  apply_filter()