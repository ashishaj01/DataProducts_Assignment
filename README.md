DataProducts_Assignment
=======================
This is Shiny App Data Product deployed to share an App that display probablity of getting diabetes using logistic regression model.

 This app intakes patient information to calculate probablity of getting diabetes.
 It also shows predictive algorithm output and plots.


Below are the steps performed for developing data App.

There are two R script: ui.R and server.R

ui.R is used for developing web/user interface.
server.R is used to show how the app works to determine probablity of getting diabetes.

In server.R script following steps are executed. 
1. install and load packages
   faraway
   shiny 
   ROCR
2. load pima dataset from faraway package

3. Perform data cleaning to remove observations with zero glucose level,dialostic,triceps etc.
    
     pima$glucose[pima$glucose==0]<-NA
     pima$diastolic[pima$diastolic==0]<-NA
     pima$triceps[pima$triceps==0]<-NA
     pima$insulin[pima$insulin==0]<-NA
     pima$bmi[pima$bmi==0]<-NA

     In the dataset column test=1 shows patient has diabetes and test=0 shows patient donot have diabetes.
    
4. Formulate Model for logistic regression
   logitmod1 <- glm(test~., data=pima1,family=binomial) 

5. Develope shiny server function that capture patient information and uses above model algorithm to determine probablity 
   of getting diabetes.

     Below is snippet of server.R code that calculate probablity.

.     output$prediction <- renderText( {
      data <- constructData()  			
      score <- round(predict(logitmod1, newdata=data, type="response"),3)
      paste("Patient Likelihood of getting diabetes is :", score[1])  


6. The model summary and model diagnostic plots are also displayed.


In ui.R script,
we used sliders and textbox to let the user enter patient information and click on submit button.
the following snippets of ui.R code is used to develop input sliders and text to enter glucose level

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

The main panel is used to organize how the user interface looks.
We use the tabpanelset to create tabs thats shows different output.
    
    mainPanel(
      tabsetPanel(
        
        tabPanel("UserGuide",
                 h4('User Guide'),
                 verbatimTextOutput("UserGuide")),
        
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
 
 
