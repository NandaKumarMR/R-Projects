library(shiny)

# Training set
TrainSet <- read.csv("TrainingSet.csv", header = TRUE)
TrainSet <- TrainSet[,-1]

pageWithSidebar(

  # Page header
  headerPanel('Employee Attrition Prediction'),

  # Input values
  sidebarPanel(
    HTML("<h3>Input parameters</h4>"),
    sliderInput("satisfaction_level", label = "Satisfaction Level", value = 0.5,
                min = min(TrainSet$satisfaction_level),
                max = max(TrainSet$satisfaction_level)
    ),
    sliderInput("last_evaluation", label = "Last Evaluation", value = 0.6,
                min = min(TrainSet$last_evaluation),
                max = max(TrainSet$last_evaluation)),
    sliderInput("number_project", label = "Number Project", value = 1,
                min = min(TrainSet$number_project),
                max = max(TrainSet$number_project)),
    sliderInput("time_spend_company", label = "Time Spend Company in Hrs", value = 3,
                min = min(TrainSet$time_spend_company),
                max = max(TrainSet$time_spend_company)),
    sliderInput("Work_accident", label = "Work_accident", value = 1,
                min = min(TrainSet$Work_accident),
                max = max(TrainSet$Work_accident)),
    sliderInput("promotion_last_5years", label = "promotion_last_5years", value = 0,
                min = min(TrainSet$promotion_last_5years),
                max = max(TrainSet$promotion_last_5years)),
    sliderInput("salary", label = "salary", value = 0,
                min = min(TrainSet$salary),
                max = max(TrainSet$salary)),

    actionButton("submitbutton", "Submit", class = "btn btn-primary")
  ),

  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table

  )
)
