shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Predicting Diabetes in Pregnant women"),
    
    sidebarPanel(
      
      # Inputs for Patient Information 
      sliderInput("pregnant", "No. of times Pregnant:", min=0, max=10, value=1, step=1),
      numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 1),
      sliderInput("diastolic", "Diastolic Pressure:", min=20, max=130, value=45, step=1),
      sliderInput("triceps", "Triceps:", min=5, max=100, value=35, step=5),
      sliderInput("insulin", "Insulin Concentration:", min=10, max=900, value=79, step=50),
      sliderInput("bmi", "Body Mass Index:", min=10, max=90, value=45, step=5),
      sliderInput("diabetes", "Diabetes:", min=0.05, max=3.00, value=0.45, step=.05),
      sliderInput("age","Patient Age in years",min=20, max=85, value=30),
      submitButton('Submit')
    ),
    mainPanel(
      tabsetPanel(
      tabPanel("Prediction",
               h4('Probablity of getting diabetes '),
               verbatimTextOutput("prediction")),
      
      tabPanel("Model information",
               h4("Trained model information"),
               verbatimTextOutput("summary")),
      
      tabPanel("Model diagnostic plots",
               h4("Basic diagnostic plots"),
               plotOutput("plot1"),
               plotOutput("plot2"),
               plotOutput("plot3"),
               plotOutput("plot4"),
               plotOutput("plot5"),
               plotOutput("plot6")) 
      
       
      )            
    )
  )
)
