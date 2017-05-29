library(shiny)
library(DT)
library(psych)

data(airquality)
airquality.cc <- airquality[complete.cases(airquality),-6]
descr <- describe(airquality.cc[,-5])
tab1 <- descr[,c(-1,-2,-6,-7,-11,-12,-13)]
Variable <- c("Ozone", "Solar.R", "Wind", "Temp")
tab <- cbind(Variable,tab1)

options(warn = -1)

fitLinearModel <- function(predictors) {
  if ( !is.null(predictors) ) {
    formula <- paste(names(airquality)[1], '~', paste(predictors, collapse = ' + '))
    lm(formula = formula, data = airquality)
  } else {
    NA
  }
}

plotModel <- function(fit, n) {
  if ( !is.na(fit) ) {
    plot(fit, which = n)
  }
}

summarizeModel <- function(fit) {
  if( !is.na(fit) ) {
    summary(fit)$coef
  }
}

shinyServer(
  function(input, output) {
    output$data <- DT::renderDataTable(airquality)
    output$data2 <- renderTable(tab)
    output$pairs <- renderPlot(pairs(airquality.cc,panel = panel.smooth, col = as.factor(airquality.cc$Month)))
    fit <- reactive(fitLinearModel(input$predictors))
    output$fit <- renderPrint(summarizeModel(fit()))
    output$plot1 <- renderPlot(plotModel(fit(), 1))
    output$plot2 <- renderPlot(plotModel(fit(), 2))
    output$plot3 <- renderPlot(plotModel(fit(), 3))
    output$plot4 <- renderPlot(plotModel(fit(), 4))
  }
)