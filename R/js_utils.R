create_shiny_input_setter_function <- function(input_name, value) {
  function_body <- glue::glue(
    "
    () => {
      Shiny.setInputValue('<<input_name>>', '<<value>>')
    }
    ",
    .open = "<<",
    .close = ">>"
  )
  
  shiny.fluent::JS(function_body)
}
