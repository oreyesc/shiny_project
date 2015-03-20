###############################
### Shiny Projject - ui.R ###
###############################

library(shiny)

# Define UI for dataset viewer application
shinyUI(pageWithSidebar(

        # Application title
        headerPanel("Shiny Project"),

        # Sidebar with controls to provide a caption, select a dataset, and
        # specify the number of observations to view. Note that changes made
        # to the caption in the textInput control are updated in the output
        # area immediately as you type
        sidebarPanel(
                tags$img(src="img/OR.png", height = "300px", width = "300px"),
                textInput("caption", "Caption:", "Data Summary"),

                selectInput("selectinput", "Choose an Option:",
                            choices = c("All Questions", "Question1", "Question2", "Question3"))

                #numericInput("obs", "Number of observations to view:", 10)
        ),


        # Show the caption, a summary of the dataset and an HTML table with
        # the requested number of observations
        mainPanel(

                h3(textOutput("caption")),
                br(),

                htmlOutput ("question"),
                br(),

                strong (textOutput ("plot")),
                plotOutput ("printplot"),
                br(),

                strong (textOutput ("summaryt")),
                verbatimTextOutput ("summary"),
                br(),

                strong (textOutput ("observations")),
                tableOutput ("view")
        )
))

