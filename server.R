library(shiny)

shinyServer(
  function(input, output) {
    
    heightPlot = seq(1.5,2.1, by=0.01)
    weightPlot = seq(40,150, by=0.5)
    bmi=function(weight,height){
      weight/height^2
    }
    grid = expand.grid(x=weightPlot,y=heightPlot)
    bmiMatrix = matrix(bmi(grid$x,grid$y),length(weightPlot),length(heightPlot))
    userCategory=function(userBmi){
      if(userBmi<=15)return('Very Severely Underweight')
      if(userBmi<=16)return('Severely Underweight')
      if(userBmi<=18.5)return('Underweight')
      if(userBmi<=25)return('Normal (Healthy Weight)')
      if(userBmi<=35)return('Obese Class I (Moderately Obese)')
      if(userBmi<=40)return('Obese Class II (Severely obese)')
      if(userBmi>40)return('Obese Class III (Very Severely obese)')
    }
    bmiColors=c("#2166AC","#4393C3","#92C5DE","#D1E5F0","#FDDBC7","#F4A582","#D6604D","#B2182B")
      
    output$plot <- renderPlot({
      weight <- input$weight
      height <- input$height      
      
      plot(NA,ylim=range(heightPlot),
           xlim=range(weightPlot),ylab="Height [meters]",xlab="Weight [kilograms]",
           frame=FALSE,axes=F,xaxs="i",yaxs="i")
      
      .filled.contour(x=weightPlot, y=heightPlot,z=bmiMatrix,
                      levels=c(0,15,16,18.5,25,30,35,40,90),
                      col=bmiColors
      )
      axis(2, seq(1.5,2.1, by=0.1))
      axis(1, seq(40,150, by=10),las=2)
      legend("topright", title="BMI Category",
             c('Very severely underweight','Severely underweight','Underweight',
               'Normal','Overweight','Obese Class I',
               'Obese Class II','Obese Class III'), fill=bmiColors,bg='transparent')
      
      points(weight,height,pch=19)    
    })
    
    output$category <- renderText({ 
      weight <- input$weight
      height <- input$height  
      userBmi=bmi(weight,height)   
      return (paste('Your BMI is ',round(userBmi,1),'kg/m2, considered ',userCategory(userBmi)))
    })
    
    })  