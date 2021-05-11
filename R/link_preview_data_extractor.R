LinkPreviewDataExtractor <- R6::R6Class(
  classname = "LinkPreviewDataExtractor",
  public = list(
    initialize = function() {
    },
    extract_og_attribute = function(link, og_attribute) {
      checkmate::assert_string(link)
      
      rvest::read_html(x = link) %>% 
        rvest::html_element(xpath = "//meta[contains(@property, 'og:image')]") %>% 
        rvest::html_attr(name = "content")
    },
    extract_icon = function(link) {
      checkmate::assert_string(link)
      rvest::read_html(x = link) %>% 
        rvest::html_element(xpath = "//link[@rel = 'icon' and (not(boolean(@sizes)) or @sizes = '32x32')]") %>% 
        rvest::html_attr(name = "href")
    }
  ),
  private = list(
  )
)

extract_link_preview <- (function() {
  extractor <- LinkPreviewDataExtractor$new()
  function(link) {
    extractor$extract_og_attribute(link, NULL)
  }
})()

extract_link_preview_cached <- memoise::memoise(extract_link_preview)