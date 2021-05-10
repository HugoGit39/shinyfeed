feed_module_ui <- function(id) {
  ns <- NS(id)
  reactOutput(ns("feed_items"))
}

feed_module_server <- function(id, settings, feed_items) {
  moduleServer(
    id,
    function(input, output, session) {
      output$feed_items <- renderReact({
        feed_data <- feed_items()
        
        switch(
          settings$view_type,
          grid = .create_grid_view(feed_data),
          list = .create_list_view(feed_data)
        )
      })
    }
  )
}

.create_grid_view <- function(feed_data) {
  Stack(
    horizontal = TRUE,
    horizontalAlign = "flex-start",
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
}

.create_list_view <- function(feed_data) {
  feed_data$item_pub_date = as.character(feed_data$item_pub_date)
  
  columns <- list(
    list(key = "title", fieldName = "item_title", name = "Title", minWidth = 100, maxWidth = 600, isResizable = TRUE),
    list(key = "date_published", fieldName = "item_pub_date", name = "Date published", minWidth = 100, maxWidth = 200, isResizable = TRUE),
    list(key = "author", fieldName = "feed_title", name = "Author", minWidth = 100, maxWidth = 200, isResizable = TRUE)
  )
  
  DetailsList(
    items = feed_data,
    columns = columns,
    selectionMode = 0,
    onRenderItemColumn = shiny.react::JS(
      "(item, index, column) => {
              const fieldContent = item[column.fieldName];
              
              switch (column.key) {
                case 'title':
                  return React.createElement(
                    jsmodule['@fluentui/react']['Link'], 
                    {href: `${item['item_link']}`}, 
                    fieldContent
                  );
              
                default:
                  return React.createElement('span', null, fieldContent);
              }
            }
      "
    )
  )
}