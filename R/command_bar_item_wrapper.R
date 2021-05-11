command_bar_item_wrapper <- function(input_id, input_value, text, icon, checked = FALSE) {
  CommandBarItem(
    text = text,
    icon = icon,
    onClick = create_shiny_input_setter_function(
      input_name = input_id,
      value = input_value
    ),
    canCheck = checked,
    checked = checked
  )
}
