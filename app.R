library(shiny.fluent)

# RSS_FEEDS <- c(
#   "https://appsilon.com/rss"
# )
# 
# RSS_FEED_READER <- RssFeedReader$new(RSS_FEEDS)
# RSS_FEED_READER$read()


ui <- fluentPage(
  Stack(
    horizontal = TRUE,
    tokens = list(childrenGap = 10),
    wrap = TRUE,
    lapply(seq_len(30), function(x) {
      item_card(
        title = shinipsum::random_text(nword = 5),
        description = shinipsum::random_text(nword = 30),
        image_url = glue::glue("https://picsum.photos/318/196?random={x}"),
        publish_date = Sys.time() + sort(sample(1:10, 1)),
        author = shinipsum::random_text(nword = 1)
      )
    })
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
