library(magrittr)
library(shiny.fluent)

RSS_FEEDS <- c(
  "https://appsilon.com/rss",
  "https://blog.rstudio.com/index.xml"
)

RSS_FEED_SERVICE <- RssFeedService$new(RSS_FEEDS)


ui <- fluentPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  div(
    class = "grid-container",
    header(),
    div(
      class = "commands",
      command_bar_module_ui("view_command_bar")
    ),
    div(
      class = "sidenav",
      Stack(
        Nav(
          groups = list(
            list(
              links = list(
                list(name = "All", url = "#!/", key = "all"),
                list(
                  name = "Subscriptions", 
                  isExpanded = TRUE,
                  links = lapply(
                      RSS_FEED_SERVICE$get_all_feeds(),
                      function(feed_title) {
                        list(name = feed_title, url = "#!/", key = feed_title)
                      }
                    )
                )
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
      feed_module_ui("feed")
    )
  )
)

server <- function(input, output, session) {
  settings <- command_bar_module_server("view_command_bar")
  feed_module_server("feed", settings, RSS_FEED_SERVICE)
}

shinyApp(ui, server)
