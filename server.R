library(caret)

# Read in the RF model
model <- readRDS("Model.rds")

shinyServer(function(input, output, session) {

  # Input Data
  datasetInput <- reactive({

    df <- data.frame(
      Name = c("satisfaction_level",
               "last_evaluation",
               "number_project",
               "average_montly_hours",
               "time_spend_company",
               "Work_accident",
               "promotion_last_5years",
               "salary"
               ),
      Value = as.character(c(input$satisfaction_level,
                             input$last_evaluation,
                             input$number_project,
                             input$average_montly_hours,
                             input$time_spend_company,
                             input$Work_accident,
                             input$promotion_last_5years,
                             input$salary)),
      stringsAsFactors = FALSE)

    Status <- 0
    df <- rbind(df, Status)
    input <- transpose(df)
    write.table(input,"input.csv", sep=",", quote = FALSE, row.names = FALSE, col.names = FALSE)

    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)

    Output <- data.frame(Prediction=predict(model,test), round(predict(model,test,type="prob"), 3))
    print(Output)

  })

  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) {
      isolate("Calculation complete.")
    } else {
      return("Server is ready for calculation.")
    }
  })

  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) {
      isolate(datasetInput())
    }
  })

})
