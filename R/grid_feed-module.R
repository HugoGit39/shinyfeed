grid_feed_ui <- function(id) {
  ns <- NS(id)
  reactOutput(ns("grid_items"))
}

grid_feed_server <- function(id, feed_items) {
  moduleServer(
    id,
    function(input, output, session) {
      output$grid_items <- renderReact({
        feed_data <- feed_items()
        
        Stack(
          horizontal = TRUE,
          horizontalAlign = "space-evenly",
          tokens = list(childrenGap = 20),
          wrap = TRUE,
          lapply(seq_len(nrow(feed_data)), function(item_id) {
            item_card(
              on_click_href = feed_data[item_id, ]$item_link,
              title = feed_data[item_id, ]$item_title,
              description = feed_data[item_id, ]$item_description,
              image_url = LinkPreviewDataExtractor$new()$extract_og_attribute(feed_data[item_id, ]$item_link, "image"),
              publish_date = feed_data[item_id, ]$item_pub_date,
              author = feed_data[item_id, ]$feed_title,
              author_image = ""
            )
          })
        )
      })
    }
  )
}
