command_bar_module_ui <- function(id) {
  ns <- NS(id)
  reactOutput(ns("command_list"))
}

command_bar_module_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      settings <- reactiveValues(
        sort_type = NULL,
        view_type = "list"
      )
      
      observeEvent(input$view_type, {
        settings$view_type <- input$view_type
      })
      
      output$command_list <- renderReact({
        shiny.fluent::CommandBar(
          items = list(
            CommandBarItem(
              text = "Sort",
              icon = "SortLines",
              subitems = list(
                CommandBarItem(
                  text = "Sort By Title (From A to Z)",
                  icon = "Ascending"
                ),
                CommandBarItem(
                  text = "Sort By Title (From Z to A)",
                  icon = "Descending"
                ),
                CommandBarItem(
                  text = "Sort from newest",
                  icon = "Recent"
                ),
                CommandBarItem(
                  text = "Sort from oldest",
                  icon = "History"
                )
              )
            ),
            .create_view_type_command_bar_item(settings$view_type, NS(id, "view_type"))
          ),
          farItems = .create_command_bar_far_items()
        )
      })
      
      return(
        settings
      )
    }
  )
}

.create_command_bar_far_items <- function() {
  list(
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
}

.create_view_type_command_bar_item <- function(view_type, input_name) {
  view_type_to_text_mapping <- list(
    grid = "Grid View",
    list = "List View"
  )
  
  view_type_to_icon_mapping <- list(
    grid = "Tiles",
    list = "List"
  )
  
  CommandBarItem(
    text = view_type_to_text_mapping[[view_type]], 
    icon = view_type_to_icon_mapping[[view_type]],
    subitems = list(
      CommandBarItem(
        text = "Grid View",
        icon = "Tiles",
        onClick = create_shiny_input_setter_function(
          input_name = input_name,
          value = "grid"
        )
      ),
      CommandBarItem(
        text = "List View",
        icon = "List",
        onClick = create_shiny_input_setter_function(
          input_name = input_name,
          value = "list"
        )
      )
    )
  )
}