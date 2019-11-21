require(shiny)
#source("../Documents/R_Test/Random_Forest.R")

#NOTE: MUST RUN Random_Forest.R TO PUT RF IN GLOBAL ENVIRONMENT

#globals
slidebarWidth = 12

#define UI
ui = navbarPage("Patent Grants Predictor",
                
                tabPanel("Baseline Inputs",
                         sidebarLayout(
                           sidebarPanel(
                             
                             titlePanel("Input Features"),
                             
                             fluidRow(
                               column(2,br(),
                                      selectInput("Affected.by.Katrina", label = "Affected by Katrina",
                                                  choices = list("False" = 0, "True" =1), selected = 1)),
                               column(2,
                                      selectInput("Rural.urban.Continuum.Code", label = "Rural Urban Continuum Code",
                                                  choices = list(
                                                    "1" = 1,
                                                    "2" = 2,
                                                    "3" = 3,
                                                    "4" = 4,
                                                    "5" = 5,
                                                    "6" = 6,
                                                    "7" = 7,
                                                    "8" = 8,
                                                    "9" = 9
                                                  ), selected = 1)),
                               column(2,
                                      selectInput("Urban.Influence.Code", label = "Urban Influence Code",
                                                  choices = list(
                                                    "1" = 1,
                                                    "2" = 2,
                                                    "3" = 3,
                                                    "4" = 4,
                                                    "5" = 5,
                                                    "6" = 6,
                                                    "7" = 7,
                                                    "8" = 8,
                                                    "9" = 9
                                                  ), selected = 1)),
                               column(2,
                                      numericInput("Percent.of.adults.with.less.than.a.high.school.diploma", label = "% adults w/ < H.S. diploma", value = 19)),
                               column(2,
                                      numericInput("Percent.of.adults.with.a.high.school.diploma.only", label = "%  adults only H.S diploma", value = 28.2)),
                               column(2,
                                      numericInput("Percent.of.adults.completing.some.college.or.associate.s.degree", label = "% adults associates degree", value = 25))
                             ),
                             
                             fluidRow(
                               column(2,
                                      numericInput("Percent.of.adults.with.a.bachelor.s.degree.or.higher", label = "% adults bachelors or higher", value = 27.8)),
                               column(2,
                                      numericInput("Personal.income..thousands.of.dollars.", label = "Personal income (thousand dollars)", value = 103429133)),
                               column(2,
                                      numericInput("Net.earnings.by.place.of.residence", label = "Net earnings by place of residence", value = 59304606)),
                               column(2,
                                      numericInput("Personal.current.transfer.receipts", label = "Personal Current Transfer Receipts", value = 21352036)),
                               column(2,
                                      numericInput("Income.maintenance.benefits", label = "Income Maintenance Benefits", value = 3447246)),
                               column(2,
                                      numericInput("Unemployment.insurance.compensation", label = "Unemployment Insurance Compensation", value = 336030))
                             ),
                             
                             fluidRow(
                               column(2,
                                      numericInput("Retirement.and.other", label = "Retirement and other", value = 17568760)),
                               column(2,
                                      numericInput("X.Dividends..interest..and.rent", label = "Dividends, interests, and rent", value = 22772491)),
                               column(2,
                                      numericInput("Population..persons.", label = "Population (persons)", value = 2643934)),
                               column(2,
                                      numericInput("Per.capita.personal.income", label = "Per capita personal income", value = 39119)),
                               column(2,
                                      numericInput("Per.capita.net.earnings", label = "Per capita net earnings", value = 22430)),
                               column(2,
                                      numericInput("Per.capita.personal.current.transfer.receipts", label = "Per capita personal current transfer receipts", value = 8076))
                             ), 
                             fluidRow(
                               column(2,
                                      numericInput("Per.capita.income.maintenance.benefits", label = "Per capita income maintenance benefits", value = 1304)),
                               column(2,
                                      numericInput("Per.capita.unemployment.insurance.compensation", label = "Per capita unemployment insurance compensation", value = 127)),
                               column(2,
                                      numericInput("Per.capita.retirement.and.other", label = "Per capita retirement and other", value = 6645)),
                               column(2,
                                      numericInput("X.Per.capita.dividends..interest..and.rent", label = "Per capita Dividends, interest, and rent", value = 8613)),
                               column(2,
                                      numericInput("Earnings.by.place.of.work", label = "Earnings by place of work", value = 75174928)),
                               column(2,
                                      numericInput("Wages.and.salaries", label = "Wages and salaries", value = 54584695))
                             ),
                             fluidRow(
                               column(2,
                                      numericInput("Supplements.to.wages.and.salaries", label = "Supplements to wages and salaries", value = 11841281)),
                               column(2,
                                      numericInput("Employer.contributions.for.employee.pension.and.insurance.funds", label = "Employer cont for employee pension & insurance funds", value = 7953822)),
                               column(2,
                                      numericInput("Employer.contributions.for.government.social.insurance", label = "Employer cont for gov social insurance", value = 3887459)),
                               column(2,
                                      numericInput("Proprietors..income", label = "Proprietors income", value = 8748952)),
                               column(2,
                                      numericInput("Farm.proprietors..income", label = "Farm proprietors' income", value = 190130)),
                               column(2,
                                      numericInput("Nonfarm.proprietors..income", label = "Nonfarm proprietors' income", value = 8558822))
                             ),
                             fluidRow(
                               column(2,
                                      numericInput("Total.employment..number.of.jobs.", label = "Total employment (# of jobs)", value = 1564249)),
                               column(2,
                                      numericInput("Wage.and.salary.employment", label = 'Wage/salary employment', value = 1105174)),
                               column(2,
                                      numericInput("Proprietors.employment", label = "Proprietors employment", value = 459075)),
                               column(2,
                                      numericInput("Farm.proprietors.employment", label = "Farm proprietors' employment", value = 2107)),
                               column(2,
                                      numericInput("Nonfarm.proprietors.employment", label = "Nonfarm proprietors' emloyment", value = 456968)),
                               column(2,
                                      numericInput("Average.earnings.per.job..dollars.", label = "Avg earnings per job ($)", value = 48058))
                             ),
                             fluidRow(
                               column(2,
                                      numericInput("Average.wages.and.salaries", label = "Avg wages/salaries", value = 49390)),
                               column(2,
                                      numericInput("Average.nonfarm.proprietors..income", label = "Avg nonfarm proprietors' income", value = 18730)),
                               column(2, br()),
                               column(2,
                                      numericInput("starting.year", label = "Starting Year", value = 2005)),
                               column(2,
                                      numericInput("number.years", label = "Number of Years", value = 10)),
                               column(2, strong("Plot Projections"), actionButton("plotButton", label="Plot"))
                               
                             ),
                             
                             width = slidebarWidth
                             
                           ),
                           
                           mainPanel(
                             
                             width = 12 - slidebarWidth #it's divided into 12 units
                           )
                         )
                ),
                
      
                
                tabPanel("Patent Projections",
                         plotOutput("patent_projections")
                         )
                )
#define server logic
server = function(input, output) {
  
  output$patent_projections = renderPlot({
    input$plotButton
    
    isolate({
      repTimes = input$number.years+1
      x = seq(input$starting.year, input$starting.year+input$number.years, 1)
      
      #print(x)
      
      # need a prediction
      Year.since.Katrina = x-2005
      Affected.by.Katrina = rep(strtoi(input$Affected.by.Katrina), repTimes)
      Rural.urban.Continuum.Code = rep(strtoi(input$Rural.urban.Continuum.Code), repTimes)
      Urban.Influence.Code = rep(strtoi(input$Urban.Influence.Code), repTimes)
      Percent.of.adults.with.less.than.a.high.school.diploma = rep(input$Percent.of.adults.with.less.than.a.high.school.diploma, repTimes)
      Percent.of.adults.with.a.high.school.diploma.only = rep(input$Percent.of.adults.with.a.high.school.diploma.only, repTimes)
      Percent.of.adults.completing.some.college.or.associate.s.degree = rep(input$Percent.of.adults.completing.some.college.or.associate.s.degree, repTimes)
      Percent.of.adults.with.a.bachelor.s.degree.or.higher = rep(input$Percent.of.adults.with.a.bachelor.s.degree.or.higher, repTimes)
      Personal.income..thousands.of.dollars. = rep(input$Personal.income..thousands.of.dollars., repTimes)
      Net.earnings.by.place.of.residence = rep(input$Net.earnings.by.place.of.residence, repTimes)
      Personal.current.transfer.receipts = rep(input$Personal.current.transfer.receipts, repTimes)
      Income.maintenance.benefits = rep(input$Income.maintenance.benefits, repTimes)
      Unemployment.insurance.compensation = rep(input$Unemployment.insurance.compensation, repTimes)
      Retirement.and.other = rep(input$Retirement.and.other, repTimes)
      X.Dividends..interest..and.rent = rep(input$X.Dividends..interest..and.rent, repTimes)
      Population..persons. = rep(input$Population..persons., repTimes)
      Per.capita.personal.income = rep(input$Per.capita.personal.income, repTimes)
      Per.capita.net.earnings = rep(input$Per.capita.net.earnings, repTimes)
      Per.capita.personal.current.transfer.receipts = rep(input$Per.capita.personal.current.transfer.receipts, repTimes)
      Per.capita.income.maintenance.benefits = rep(input$Per.capita.income.maintenance.benefits, repTimes)
      Per.capita.unemployment.insurance.compensation = rep(input$Per.capita.unemployment.insurance.compensation, repTimes)
      Per.capita.retirement.and.other = rep(input$Per.capita.retirement.and.other, repTimes)
      X.Per.capita.dividends..interest..and.rent = rep(input$X.Per.capita.dividends..interest..and.rent, repTimes)
      Earnings.by.place.of.work = rep(input$Earnings.by.place.of.work, repTimes)
      Wages.and.salaries = rep(input$Wages.and.salaries, repTimes)
      Supplements.to.wages.and.salaries = rep(input$Supplements.to.wages.and.salaries, repTimes)
      Employer.contributions.for.employee.pension.and.insurance.funds = rep(input$Employer.contributions.for.employee.pension.and.insurance.funds, repTimes)
      Employer.contributions.for.government.social.insurance = rep(input$Employer.contributions.for.government.social.insurance, repTimes)
      Proprietors..income = rep(input$Proprietors..income, repTimes)
      Farm.proprietors..income= rep(input$Farm.proprietors..income, repTimes)
      Nonfarm.proprietors..income = rep(input$Nonfarm.proprietors..income, repTimes)
      Total.employment..number.of.jobs. = rep(input$Total.employment..number.of.jobs., repTimes)
      Total.employment..number.of.jobs. = rep(input$Total.employment..number.of.jobs., repTimes)
      Wage.and.salary.employment = rep(input$Wage.and.salary.employment, repTimes)
      Proprietors.employment = rep(input$Proprietors.employment, repTimes)
      Farm.proprietors.employment = rep(input$Farm.proprietors.employment, repTimes)
      Nonfarm.proprietors.employment = rep(input$Nonfarm.proprietors.employment, repTimes)
      Average.earnings.per.job..dollars. = rep(input$Average.earnings.per.job..dollars., repTimes)
      Average.wages.and.salaries = rep(input$Average.wages.and.salaries, repTimes)
      Average.nonfarm.proprietors..income = rep(input$Average.nonfarm.proprietors..income, repTimes)
      
      #print(Affected.by.Katrina)
      
      #print("before df")
      df = data.frame(Year.since.Katrina,
                      Affected.by.Katrina,
                      Rural.urban.Continuum.Code,
                      Urban.Influence.Code,
                      Percent.of.adults.with.less.than.a.high.school.diploma,
                      Percent.of.adults.with.a.high.school.diploma.only,
                      Percent.of.adults.completing.some.college.or.associate.s.degree,
                      Percent.of.adults.with.a.bachelor.s.degree.or.higher,
                      Personal.income..thousands.of.dollars.,
                      Net.earnings.by.place.of.residence,
                      Personal.current.transfer.receipts,
                      Income.maintenance.benefits,
                      Unemployment.insurance.compensation,
                      Retirement.and.other,
                      X.Dividends..interest..and.rent,
                      Population..persons.,
                      Per.capita.personal.income,
                      Per.capita.net.earnings,
                      Per.capita.personal.current.transfer.receipts,
                      Per.capita.income.maintenance.benefits,
                      Per.capita.unemployment.insurance.compensation,
                      Per.capita.retirement.and.other,
                      X.Per.capita.dividends..interest..and.rent,
                      Earnings.by.place.of.work,
                      Wages.and.salaries,
                      Supplements.to.wages.and.salaries,
                      Employer.contributions.for.employee.pension.and.insurance.funds,
                      Employer.contributions.for.government.social.insurance,
                      Proprietors..income,
                      Farm.proprietors..income,
                      Nonfarm.proprietors..income,
                      Total.employment..number.of.jobs.,
                      Wage.and.salary.employment,
                      Proprietors.employment,
                      Farm.proprietors.employment,
                      Nonfarm.proprietors.employment,
                      Average.earnings.per.job..dollars.,
                      Average.wages.and.salaries,
                      Average.nonfarm.proprietors..income)
      #print("after df")
      y = predict(rf, df)
        
      plot(x, y, main = "Patent Grant Predictions", ylab = "patent grants per year", xlab = "year",
           type = "b", col = "blue")
    })
    })
  
}

#Run the app
shinyApp(ui = ui, server = server)