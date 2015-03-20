####################################
####  Shiny Project - server.R   ###
####################################

library (datasets)
library(ggplot2)
library(plyr)
library(shiny)

source ("plot1.R")
setwd ("~/project")

NEI <- readRDS("summarySCC_PM25.rds")
dataset <- NEI


# Define server logic required to summarize and view the selected dataset
shinyServer(function(input, output, session) {


        # By declaring datasetInput as a reactive expression we ensure that:
        #
        #  1) It is only called when the inputs it depends on changes
        #  2) The computation and result are shared by all the callers (it
        #     only executes a single time)
        #rock, pressure, cars
        datasetInput <- reactive({
                switch(input$selectinput,
                       "Question1" = dataset,
                       "Question2" = dataset,
                       "Question3" = dataset)
        })

        # The output$caption is computed based on a reactive expression that
        # returns input$caption. When the user changes the "caption" field:
        #
        #  1) This expression is automatically called to recompute the output
        #  2) The new caption is pushed back to the browser for re-display
        #
        # Note that because the data-oriented reactive expressions below don't
        # depend on input$caption, those expressions are NOT called when
        # input$caption changes.
        output$caption <- renderText({
                #input$caption
                input$selectinput
        })

        output$question <- renderUI ({
                if (input$selectinput=="Question1"){
                        HTML (paste ("Have total emissions from PM2.5 decreased in the United States
                                     from 1999 to 2008? Using the base plotting system, make a plot
                                     showing the total PM2.5 emission from all sources for each of
                                     the years 1999, 2002, 2005, and 2008."))
                }
                else {
                        if (input$selectinput=="Question2"){
                                HTML (paste ("Have total emissions from PM2.5 decreased in the Baltimore City,
                                             Maryland (fips == '24510') from 1999 to 2008?  Use the base
                                             plotting system to make a plot answering this question."))
                        }
                        else {
                                if (input$selectinput=="Question3"){
                                        HTML (paste ("Of the four types of sources indicated by the type (point,
                                                     nonpoint, onroad, nonroad) variable, which of these four
                                                     sources have seen decreases in emissions from 1999–2008 for
                                                     Baltimore City?
                                                     Which have seen increases in emissions from 1999–2008?
                                                     Use the ggplot2 plotting system to make a plot answer this question."))
                                }
                                else {
                                        tags$ol(tags$li("Have total emissions from PM2.5 decreased in the United States
                                                        from 1999 to 2008? Using the base plotting system, make a plot
                                                        showing the total PM2.5 emission from all sources for each of the
                                                        years 1999, 2002, 2005, and 2008."),
                                                tags$li("Have total emissions from PM2.5 decreased in the Baltimore City,
                                                        Maryland (fips == '24510') from 1999 to 2008?  Use the base
                                                        plotting system to make a plot answering this question."),
                                                tags$li("Of the four types of sources indicated by the type (point,
                                                        nonpoint, onroad, nonroad) variable, which of these four sources
                                                        have seen decreases in emissions from 1999–2008 for Baltimore City?
                                                        Which have seen increases in emissions from 1999–2008?
                                                        Use the ggplot2 plotting system to make a plot answer this question."))
                                }
                                }
                                }
                                })

        output$printplot <- renderPlot({
                progress <- shiny::Progress$new(session, min=1, max=15)
                on.exit(progress$close())
                #
                progress$set(message = 'Calculation in progress',
                             detail = 'This may take a while...')

                if (input$selectinput=="Question1"){
                        output$plot <- renderText({ paste ("PLOT")})
                        ## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                        ## !!!!!!!!!!!!!!!!!!!      QUESTION 1      !!!!!!!!!!!!!!!!!!!
                        ## !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                        # 1-. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
                        #     Using the base plotting system, make a plot showing the total PM2.5 emission
                        #      from all sources for each of the years 1999, 2002, 2005, and 2008.
                        #totalEmissions
                        #totalEmissions <- aggregate (Emissions ~ year, NEI, sum)

                        isolate (dataset <<- aggregate (Emissions ~ year, NEI, sum))
                        ## Plotting with barplot
                        ## OPTION 1: Base Plotting System
                        barplot ( dataset$Emissions/1000000,
                                  names.arg = dataset$year,
                                  xlab  = "Year",
                                  ylab  = "PM2.5 Emissions (Million Tons)",
                                  main  = "PM2.5 emission from all sources - United States",
                                  col   = c("darkblue", "darkgray", "darkcyan", "lavender"),
                                  border = "darkblue",
                                  legend = dataset$year,
                                  beside = TRUE
                        )
                        lines (dataset$Emissions/1000000, col = "red")
                        points (dataset$Emissions/1000000, col = "red")
                }
                else {
                        if (input$selectinput=="Question2"){
                                output$plot = renderText({ paste ("PLOT")})
                                # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                # !!!!!!!!!!!!!!!!!!!      QUESTION 2      !!!!!!!!!!!!!!!!!!!
                                # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                                # 2-. Have total emissions from PM2.5 decreased in the Baltimore City,
                                #     Maryland (fips == "24510") from 1999 to 2008?
                                #     Use the base plotting system to make a plot answering this question.
                                emissionsBaltimore <- NEI[NEI$fips == "24510",]
                                #totalEmissionsBaltimore
                                isolate (dataset <<- aggregate (Emissions ~ year,
                                                                emissionsBaltimore,
                                                                sum))

                                ## Plotting with barplot
                                ## OPTION 1: Base Plotting System
                                barplot ( dataset$Emissions,
                                          names.arg = dataset$year,
                                          xlab  = "Year",
                                          ylab  = "PM2.5 Emissions",
                                          main  = "PM2.5 emission from all sources - Baltimore City / Maryland",
                                          col   = c("darkblue", "darkgray",
                                                    "darkcyan", "lavender"),
                                          border = "darkblue",
                                          legend = dataset$year,
                                          beside = TRUE
                                )
                                lines (dataset$Emissions,
                                       col = "red"
                                )
                                points (dataset$Emissions,
                                        col = "red")
                        }
                        else {
                                if (input$selectinput=="Question3"){
                                        output$plot = renderText({ paste ("PLOT")})
                                        # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                                        # !!!!!!!!!!!!!!!!!!!      QUESTION 3      !!!!!!!!!!!!!!!!!!!
                                        # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

                                        # 3-. Of the four types of sources indicated by the type
                                        #     (point, nonpoint, onroad, nonroad) variable, which of these
                                        #     four sources have seen decreases in emissions from 1999–2008
                                        #     for Baltimore City?
                                        #     Which have seen increases in emissions from 1999–2008?
                                        #     Use the ggplot2 plotting system to make a plot
                                        ##       answer this question.
                                        emissionsBaltimore <- NEI[NEI$fips == "24510",]
                                        #printanswer
                                        isolate (dataset <<- ggplot (emissionsBaltimore,
                                                                     aes (factor (year),
                                                                          Emissions,
                                                                          fill = type)
                                        ) +
                                                geom_bar (stat = "identity") +
                                                facet_grid (.~type,
                                                            scales = "free",
                                                            space = "free") +
                                                labs ( x = "Year",
                                                       y = "Total PM2.5 emission (Tons)") +
                                                ggtitle ("PM2.5 emission - in the Baltimore City, Maryland - 1999 - 2008 - By Source Type")
                                        )

                                        print (dataset)
                                }
                        }
                }
        })

        # The output$summary depends on the datasetInput reactive expression,
        # so will be re-executed whenever datasetInput is invalidated
        # (i.e. whenever the input$dataset changes)
        output$summary <- renderPrint({

                if (input$selectinput!= "All Questions") {
                        output$summaryt = renderText({ paste ("Summary")})
                        #dataset <- datasetInput()
                        summary(dataset)
                }
        })

        # The output$view depends on both the databaseInput reactive expression
        # and input$obs, so will be re-executed whenever input$dataset or
        # input$obs is changed.
        output$view <- renderTable({

                if (input$selectinput!= "All Questions" & input$selectinput!= "Question3") {
                        output$observations = renderText({ paste ("Observations")})
                        head(dataset)#, n = input$obs)
                        dataset <- NEI
                }
        })
                                })

