library(shiny)

shinyUI(fluidPage(
  titlePanel("BMI Calculator"),
  p('This application calculates your Body Mass Index according to 
    your weight in kilograms and height in meters and also indicates the World Health
    Organization category for the encountered BMI.'),  
  p('code at: http://github.com/rafalohn/PA_DataProducts'),
  hr(),
  fluidRow(
    column(3,offset=3,
           sliderInput('height', 'Enter your height in Meters:',value = 1.70, min = 1.5, max = 2.1, step = 0.01) 
    ),    
    column(3,offset=0,           
           sliderInput('weight', 'Enter your weight in Kilograms:',value = 70, min = 40, max = 150, step = 0.5)   
    )
  ),
  fluidRow(
    column(6,offset=3,
    h4(textOutput("category"))
    )
  ),
  plotOutput('plot')  
))