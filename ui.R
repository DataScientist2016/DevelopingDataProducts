library(shiny)
library(DT)
library(psych)

data("airquality")
airquality$Month  <- factor(airquality$Month  , labels = c("May", "June", "July", "August", "September"))

shinyUI (sidebarLayout(
    
    sidebarPanel(
  
  fluidPage (
    title = "Linear Regression",
    h1("Linear Regression"),
    h3 ("Dataset: Airquality"),
    
    fluidRow (
      column (12,
        h4('Dataset Airquality contains daily air quality measurements in New York, May to September 1973.'),
        p ( paste ('Daily readings of the following air quality values are presented in the dataset:')),
        p ( paste ('- Ozone: Mean ozone in parts per billion from 1300 to 1500 hours at Roosevelt Island')),
        p ( paste ('- Solar.R: Solar radiation in Langleys in the frequency band 4000-7700 Angstroms',
          'from 0800 to 1200 hours at Central Park')),
        p ( paste (   '- Wind: Average wind speed in miles per hour at 0700 and 1000 hours at LaGuardia Airport')),
        p ( paste (   '- Temp: Maximum daily temperature in degrees Fahrenheit at La Guardia Airport')),
        
        
        h3 ('Choose predictor(s) to predict the OZONE MEAN.')
               )
      ),
    
    fluidRow (
      column (2,
              checkboxGroupInput ("predictors", "Choose predictor(s):", names(airquality)[c(-1,-6)])
      )  
              )
    
    )
             ),
mainPanel(
  
  h3 ("Explore the dataset"),
  tabsetPanel(
    tabPanel("Dataset Airquality", DT::dataTableOutput('data')),
    tabPanel("Descriptive statistics", tableOutput('data2')),
    tabPanel("Plot pairs", plotOutput('pairs'))
  ),
 
   h3 ("Linear regression results"),
  p("(Results appear after you choose predictor(s) on the left side)"),
  tabsetPanel (
    tabPanel ("Residuals vs Fitted", p("Residuals vs Fitted plot shows if residuals have non-linear patterns.",
                                       "There is an indication for linear relationships if residuals are equally spread", 
                                       "around a horizontal line without distinct patterns."), plotOutput('plot1')),
    tabPanel ("Normal Q-Q", p("Normal Q-Q plot shows if residuals are normally distributed.", 
                              "The residuals are normally distributed if they are lined well on the straight", 
                              "dashed line."), plotOutput('plot2')),
    tabPanel ("Scale-Location", p("Scale-Location plot shows if residuals are spread equally along the ranges of", 
                                  "predictors.A god sign for the assumption of equal variance is a horizontal line", 
                                  "with equally spread points."), plotOutput('plot3')),
    tabPanel ("Residuals vs Leverage", p("Residuals vs Leverage plot helps to find influential values.", 
                                         "Exclusion of these values will change the regression results."), 
                                       plotOutput('plot4')) 
  ),
  fluidRow(
    column (10, offset = 1, verbatimTextOutput('fit'))
  )
)

))
