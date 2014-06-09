# Predicting Diabetes among Pregnant women using pima dataset

#=====load packages===================================
library(faraway)
library(shiny)
library(ROCR)

#====Dataset load========================================
data(pima)

pima$glucose[pima$glucose==0]<-NA
pima$diastolic[pima$diastolic==0]<-NA
pima$triceps[pima$triceps==0]<-NA
pima$insulin[pima$insulin==0]<-NA
pima$bmi[pima$bmi==0]<-NA
pima$test <-as.factor(pima$test)
pima1<-pima[complete.cases(pima),]

#========Model Formulate================================
logitmod1 <- glm(test~., data=pima1,family=binomial) 


#========Server Side Prgram=============================
shinyServer(
  function(input, output) {
    
    # Patient data capture
    constructData <- reactive({
      
      data <- data.frame(matrix(rep(NA, 2*8), nrow=2))
      colnames(data) <- c("pregnant", "glucose", "diastolic", "triceps", "insulin", "bmi", "diabetes", "age")
      data$pregnant <- input$pregnant
      data$glucose <- input$glucose
      data$diastolic <- input$diastolic
      data$triceps <- input$triceps
      data$insulin <- input$insulin
      data$bmi <- input$bmi
      data$diabetes <- input$diabetes
      data$age <- input$age    
      return(data)
    })
    
    # Predict probablity of getting diabetes
    output$prediction <- renderText( {
    data <- constructData()  			
    score <- round(predict(logitmod1, newdata=data, type="response"),3)
    paste("Patient Likelihood of getting diabetes is :", score[1])    
    
    
    })
    
    # Summarize Model output
    output$summary <- renderPrint({
      summary(logitmod1)
    })
    
    # Plot Model Output
    output$plot1 <- renderPlot({
      plot(logitmod1, which=1)
    })
    
    output$plot2 <- renderPlot({
      plot(logitmod1, which=2)
    })
    
    
    output$plot3 <- renderPlot({
      plot(logitmod1, which=3)
    })
    
    
    output$plot4 <- renderPlot({
      plot(logitmod1, which=4)
    })
    
    
    output$plot5 <- renderPlot({
      plot(logitmod1, which=5)
    })
    
    output$plot6 <- renderPlot({
      plot(logitmod1, which=6)
    })    
   
  }
)
