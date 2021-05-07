library(magrittr)
library(shiny.fluent)

RSS_FEEDS <- c(
  "https://appsilon.com/rss",
  "https://blog.rstudio.com/index.xml"
)

RSS_FEED_DATA_REPOSITORY <- RssFeedDataRepository$new(RSS_FEEDS)


ui <- fluentPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")
  ),
  div(
    class = "grid-container",
    header(),
    div(
      class = "commands",
      shiny.fluent::CommandBar(
        items = list(
          list(
            key = "sort",
            text = "Sort",
            cacheKey = "myCacheKey",
            iconProps = list(iconName = "SortLines"),
            subMenuProps = list(
              items = list(
                list(
                  key = "titleAscending",
                  text = "Sort By Title (from A to Z)",
                  iconProps = list(iconName = "Ascending")
                ),
                list(
                  key = "titleDescending",
                  text = "Sort By Title (from Z to A)",
                  iconProps = list(iconName = "Descending")
                ),
                list(
                  key = "fromNewest",
                  text = "Sort from newest",
                  iconProps = list(iconName = "Recent")
                ),
                list(
                  key = "fromOlders",
                  text = "Sort from oldest",
                  iconProps = list(iconName = "History")
                )
              )
            )
          ),
          list(
            key = "viewType",
            text = "Grid View",
            iconProps = list(iconName = "Tiles"),
            subMenuProps = list(
              items = list(
                list(
                  key = "gridView",
                  text = "Grid View",
                  iconProps = list(iconName = "Tiles")
                ),
                list(
                  key = "listView",
                  text = "List View",
                  iconProps = list(iconName = "List")
                )
              )
            )
          )
        ),
        farItems = list(
          list(
            key = "code",
            text = "Source code",
            ariaLabel = "Source code",
            iconOnly = TRUE,
            iconProps = list(iconName = "Embed")
          ),
          list(
            key = "info",
            text = "Info",
            ariaLabel = "Info",
            iconOnly = TRUE,
            iconProps = list(iconName = "Info")
          )
        )
      )
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
                      RSS_FEED_DATA_REPOSITORY$get_all_feeds(),
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
      grid_feed_ui("grid_feed")
    )
  )
)

server <- function(input, output, session) {
  feed_items <- reactiveVal(RSS_FEED_DATA_REPOSITORY$get_all())
  grid_feed_server(id = "grid_feed", feed_items = feed_items)
}

shinyApp(ui, server)
