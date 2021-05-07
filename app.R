library(shiny.fluent)
library(shiny.react)

ui <- div(
  Checkbox.shinyInput("checkbox", FALSE),
  textOutput("checkboxValue")
)

server <- function(input, output, session) {
  output$checkboxValue <- renderText({
    sprintf("Value: %s", input$checkbox)
  })
}

shinyApp(ui, server)
