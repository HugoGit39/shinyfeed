RssFeedService <- R6::R6Class(
  classname = "RssFeedService",
  public = list(
    initialize = function(feed_urls) {
      checkmate::assert_character(feed_urls)
      private$repository <- RssFeedDataRepository$new(feed_urls)
    },
    get_all = function() {
      private$repository$get_all()
    },
    get_all_feeds = function() {
      private$repository$get_all_feeds()
    },
    get_items = function(feed_source, sort_type) {
      feed_items <- self$get_all()
      
      if (!is.null(feed_source)) {
        feed_items <- feed_items[feed_title == feed_source]
      }
      
      switch(
        sort_type,
        "title_ascending" = feed_items[order(item_title)],
        "title_descending" = feed_items[order(-item_title)],
        "from_newest" = feed_items[order(-item_pub_date)],
        "from_oldest" = feed_items[order(item_pub_date)]
      )
    }
  ),
  private = list(
    repository = NA
  )
)