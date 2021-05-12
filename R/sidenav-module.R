sidenav_module_ui <- function(id, label = "Counter") {
  ns <- NS(id)
  reactOutput(ns("sidebar"))
}

sidenav_module_server <- function(id, rss_feed_service) {
  moduleServer(
    id,
    function(input, output, session) {
      
      output$sidebar <- renderReact({
        if(is.null(rss_feed_service())) {
          return(div())
        }
        
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
                      rss_feed_service()$get_all_feeds(),
                      function(feed_title) {
                        list(
                          name = feed_title,  
                          url = glue::glue("#!/?feed_source={feed_title}"), 
                          key = feed_title
                        )
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
      })
    }
  )
}
