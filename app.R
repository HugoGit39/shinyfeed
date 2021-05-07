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
                  links = list(
                    list(name = "Feed1", url = "#!/", key = "feed1"),
                    list(name = "Feed2", url = "#!/", key = "feed2")
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
      Stack(
        horizontal = TRUE,
        horizontalAlign = "space-evenly",
        tokens = list(childrenGap = 20),
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
    )
  )
)

server <- function(input, output, session) {
}

shinyApp(ui, server)
