list_feed_ui <- function(id) {
  ns <- NS(id)
  reactOutput(ns("list_items"))
}

list_feed_server <- function(id, feed_items) {
  moduleServer(
    id,
    function(input, output, session) {
      output$list_items <- renderReact({
        feed_data <- feed_items()
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
            }"
          )
        )
      })
    }
  )
}
