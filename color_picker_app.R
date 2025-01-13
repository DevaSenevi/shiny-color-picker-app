# Load required libraries
library(shiny)
library(colourpicker)

# Define UI
ui <- fluidPage(
  titlePanel("Dynamic Color Display"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider", "Adjust Transparency:", min = 0, max = 100, value = 100),
      colourInput("colorPicker", "Pick a Color:", value = "#0000FF")
    ),
    mainPanel(
      uiOutput("colorBox"),
      textOutput("colorCode")
    )
  )
)

# Define Server
server <- function(input, output, session) {
  # Reactive expression to create the RGBA color
  reactiveColor <- reactive({
    color <- input$colorPicker
    transparency <- input$slider / 100  # Convert slider value to fraction
    rgba_color <- paste0("rgba(", paste(col2rgb(color), collapse = ", "), ", ", transparency, ")")
    rgba_color
  })
  
  # Dynamically update the color box
  output$colorBox <- renderUI({
    div(
      style = paste0(
        "height: 200px; width: 200px; border: 1px solid black; margin: 20px; ",
        "background-color: ", reactiveColor(), ";"
      )
    )
  })
  
  # Display the RGBA color code as text
  output$colorCode <- renderText({
    paste("Selected Color (RGBA):", reactiveColor())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
