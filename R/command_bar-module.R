command_bar_module_ui <- function(id) {
  ns <- NS(id)
  reactOutput(ns("command_list"))
}

command_bar_module_server <- function(id) {
  moduleServer(
    id,
    function(input, output, session) {
      settings <- reactiveValues(
        sort_type = "from_newest",
        view_type = "list"
      )
      
      observeEvent(input$view_type, {
        settings$view_type <- input$view_type
      })
      
      observeEvent(input$sort_type, {
        settings$sort_type <- input$sort_type
      })
      
      output$command_list <- renderReact({
        shiny.fluent::CommandBar(
          items = list(
            .create_sort_type_command_bar_item(settings$sort_type, NS(id, "sort_type")),
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
    CommandBarItem(
      text = "Source code",
      icon = "Embed",
      iconOnly = TRUE,
      href = "https://github.com/rszymanski/shinyfeed"
    ),
    CommandBarItem(
      text = "Info",
      icon = "Info",
      iconOnly = TRUE
    )
  )
}

.create_sort_type_command_bar_item <- function(sort_type, input_name) {
  is_checked_helper <- function(item_name, selected_item) {
    checkmate::assert_string(selected_item)
    item_name == selected_item
  }
  
  CommandBarItem(
    text = "Sort",
    icon = "SortLines",
    subitems = list(
      command_bar_item_wrapper(
        input_id = input_name,
        input_value = "title_ascending",
        text = "Sort By Title (From A to Z)",
        icon = "Ascending",
        checked = is_checked_helper("title_ascending", sort_type)
      ),
      command_bar_item_wrapper(
        input_id = input_name,
        input_value = "title_descending",
        text = "Sort By Title (From Z to A)",
        icon = "Descending",
        checked = is_checked_helper("title_descending", sort_type)
      ),
      command_bar_item_wrapper(
        input_id = input_name,
        input_value = "from_newest",
        text = "Sort from newest",
        icon = "Recent",
        checked = is_checked_helper("from_newest", sort_type)
      ),
      command_bar_item_wrapper(
        input_id = input_name,
        input_value = "from_oldest",
        text = "Sort from oldest",
        icon = "History",
        checked = is_checked_helper("from_oldest", sort_type)
      )
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
      command_bar_item_wrapper(
        input_id = input_name,
        input_value = "grid",
        text = "Grid View",
        icon = "Tiles"
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