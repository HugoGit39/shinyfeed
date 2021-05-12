library(data.table)
library(magrittr)
library(future)
library(promises)
library(shiny)
library(shiny.fluent)
library(shiny.router)
plan(multisession)

CONFIG <- config::get()

shiny::addResourcePath("shiny.router", system.file("www", package = "shiny.router"))
shiny_router_js_src <- file.path("shiny.router", "shiny.router.js")
shiny_router_script_tag <- shiny::tags$script(type = "text/javascript", src = shiny_router_js_src)

router <- make_router(route("/",  feed_module_ui("feed")))

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
      sidenav_module_ui("sidenav")
    ),
    div(
      class = "main",
      router$ui
    )
  )
)

server <- function(input, output, session) {
  router$server(input, output, session)
  
  rss_feed_service <- reactiveVal(NULL)
  
  future({
     RssFeedService$new(CONFIG$rss_feeds)
  }) %...>%
    (function(outer_result) {
      rss_feed_service(outer_result)
    })
  
  settings <- command_bar_module_server("view_command_bar")
  feed_module_server("feed", settings, rss_feed_service)
  sidenav_module_server("sidenav", rss_feed_service)
}

shinyApp(ui, server)
