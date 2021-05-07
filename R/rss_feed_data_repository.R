RssFeedDataRepository <- R6::R6Class(
  classname = "RssFeedDataRepository",
  public = list(
    initialize = function(feed_urls) {
      checkmate::assert_character(feed_urls)
      private$feed_data = RssFeedReader$new(feed_urls)$read()
    },
    get_all = function() {
      private$feed_data
    },
    get_all_feeds = function() {
      sort(unique(private$feed_data$feed_title))
    }
  ),
  private = list(
    feed_data = NA
  )
)