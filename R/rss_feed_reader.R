RssFeedReader <- R6::R6Class(
  classname = "RssFeedReader",
  public = list(
    initialize = function(feed_urls) {
      checkmate::assert_character(feed_urls)
      private$feed_urls <- feed_urls
    },
    read = function() {
      data.table::rbindlist(
        lapply(private$feed_urls, function(feed_url) {
          private$read_single_feed(feed_url)
      }), fill = TRUE)
    }
  ),
  private = list(
    feed_urls = NA,
    read_single_feed = function(feed_url) {
      checkmate::assert_string(feed_url)
      
      feed_data <- tidyRSS::tidyfeed(feed = feed_url)
      data.table::data.table(feed_data)
    }
  )
)
