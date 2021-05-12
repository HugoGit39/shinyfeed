LinkPreviewDataExtractor <- R6::R6Class(
  classname = "LinkPreviewDataExtractor",
  public = list(
    initialize = function() {
    },
    extract_image_preview = function(link) {
      checkmate::assert_string(link)
      
      rvest::read_html(x = link) %>% 
        rvest::html_element(xpath = "//meta[contains(@property, 'og:image')]") %>% 
        rvest::html_attr(name = "content")
    }
  ),
  private = list(
  )
)

extract_link_preview <- (function() {
  extractor <- LinkPreviewDataExtractor$new()
  function(link) {
    extractor$extract_image_preview(link)
  }
})()

extract_link_preview_cached <- memoise::memoise(extract_link_preview)