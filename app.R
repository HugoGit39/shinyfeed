library(shiny.fluent)

# RSS_FEEDS <- c(
#   "https://appsilon.com/rss"
# )
# 
# RSS_FEED_READER <- RssFeedReader$new(RSS_FEEDS)
# RSS_FEED_READER$read()


ui <- fluentPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  div(
    class = "grid-container",
    div(
      class = "header",
      Text(variant = "xxLarge", "shinyfeed")
    ),
    div(
      class = "sidenav",
      Stack(
        Nav(
          groups = list(
            list(
              links = list(
                list(name = "All", url = "#!/", key = "all"),
                list(name = "Feed1", url = "#!/", key = "feed1"),
                list(name = "Feed2", url = "#!/", key = "feed2")
              )
            )
          ),
          initialSelectedKey = 'all',
          styles = list(
            root = list(
              height = '100%',
              boxSizing = 'border-box',
              overflowY = 'auto'
            )
          )
        )
      )
    ),
    div(
      class = "main", 
      Stack(
        horizontal = TRUE,
        horizontalAlign = "center",
        tokens = list(childrenGap = 10),
        wrap = TRUE,
        lapply(seq_len(30), function(x) {
          item_card(
            on_click_href = "https://www.google.com",
            title = shinipsum::random_text(nword = 5),
            description = shinipsum::random_text(nword = 30),
            image_url = glue::glue("https://picsum.photos/318/196?random={x}"),
            publish_date = Sys.time() + sort(sample(1:10, 1)),
            author = shinipsum::random_text(nword = 1)
          )
        })
      )
    ),
    div(
      class = "footer",
      "footer"
    )
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
