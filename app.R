library(magrittr)
library(shiny)
library(shiny.fluent)
library(shiny.router)

CONFIG <- config::get()

shiny::addResourcePath("shiny.router", system.file("www", package = "shiny.router"))
shiny_router_js_src <- file.path("shiny.router", "shiny.router.js")
shiny_router_script_tag <- shiny::tags$script(type = "text/javascript", src = shiny_router_js_src)

RSS_FEED_SERVICE <- RssFeedService$new(CONFIG$rss_feeds)

ROUTER <- make_router(
  route("/",  feed_module_ui("feed"))
)

ui <- fluentPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    shiny_router_script_tag
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
                        list(name = feed_title, url = glue::glue("#!/?feed_source={feed_title}"), key = feed_title)
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
      ROUTER$ui
    )
  )
)

server <- function(input, output, session) {
  ROUTER$server(input, output, session)
  settings <- command_bar_module_server("view_command_bar")
  feed_module_server("feed", settings, RSS_FEED_SERVICE)
}

shinyApp(ui, server)
