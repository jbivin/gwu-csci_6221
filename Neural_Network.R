# Libraries
library(keras)
install.packages('mlbench')
library(mlbench) 
library(dplyr)
library(magrittr)
library(neuralnet)

# Data
data <- read.csv("//Users/mac/Downloads/B-1.csv")

str(data)

data %<>% mutate_if(is.factor, as.numeric)

# Neural Network Visualization
n <- neuralnet(Patent.Grants ~ Average.earnings.per.job..dollars.+Average.nonfarm.proprietors..income + Average.wages.and.salaries + Nonfarm.proprietors..income + Nonfarm.proprietors.employment + Proprietors.employment + Proprietors..income + Farm.proprietors..income + Farm.proprietors.employment + Wage.and.salary.employment + Wages.and.salaries + Total.employment..number.of.jobs. + Employer.contributions.for.employee.pension.and.insurance.funds + Employer.contributions.for.government.social.insurance + Supplements.to.wages.and.salaries + Earnings.by.place.of.work + X.Per.capita.dividends..interest..and.rent + Per.capita.income.maintenance.benefits + Per.capita.net.earnings + Per.capita.personal.current.transfer.receipts + Per.capita.personal.income + Per.capita.personal.income + Per.capita.retirement.and.other + Per.capita.unemployment.insurance.compensation + Percent.of.adults.completing.some.college.or.associate.s.degree + Percent.of.adults.with.a.bachelor.s.degree.or.higher + Percent.of.adults.with.a.high.school.diploma.only + Percent.of.adults.with.less.than.a.high.school.diploma 
               + Rural.urban.Continuum.Code,
               data = data,
               hidden = c(10,5),
               linear.output = FALSE,
               lifesign = 'full',
               rep=1)
plot(n,
     col.hidden = 'darkgreen',
     col.hidden.synapse = 'darkgreen',
     show.weights = F,
     information = F,
     fill = 'lightblue')

# Matrix
data <- as.matrix(data)
dimnames(data) <- NULL

# Partition
set.seed(1234)
ind <- sample(2, nrow(data), replace = T, prob = c(.7, .3))
training <- data[ind==1,1:39]
test <- data[ind==2, 1:39]
trainingtarget <- data[ind==1, 40]
testtarget <- data[ind==2, 40]

# Normalize
m <- colMeans(training)
s <- apply(training, 2, sd)
training <- scale(training, center = m, scale = s)
test <- scale(test, center = m, scale = s)

# Create Model
model <- keras_model_sequential()
model %>% 
         layer_dense(units = 5, activation = 'relu', input_shape = c(39)) %>%
         layer_dense(units = 1)

# Compile
model %>% compile(loss = 'mse',
                  optimizer = 'rmsprop',
                  metrics = 'mae')

# Fit Model
mymodel <- model %>%
         fit(training,
             trainingtarget,
             epochs = 100,
             batch_size = 32,
             validation_split = 0.2)

# Evaluate
model %>% evaluate(test, testtarget)
pred <- model %>% predict(test)
mean((testtarget-pred)^2)
plot(testtarget, pred)

#Further Fine Tuning of Model

# Create Model
model %>% 
            layer_dense(units = 200, activation = 'relu', input_shape = c(39)) %>%
            layer_dropout(rate= 0.4) %>%
            layer_dense(units = 150, activation = 'relu') %>% 
            layer_dropout(rate= 0.3) %>%
            layer_dense(units = 100, activation = 'relu') %>%
            layer_dropout(rate= 0.2) %>%
            layer_dense(units = 50, activation = 'relu') %>%
            layer_dropout(rate= 0.1) %>%
            layer_dense(units = 5, activation = 'relu') %>%
            layer_dense(units = 1)

model %>% compile(loss = 'mse',
                  optimizer = optimizer_rmsprop(lr= 0.01),
                  metrics = 'mae')

# Compile
model %>% compile(loss = 'mse',
                  optimizer = 'rmsprop',
                  metrics = 'mae')

# Fit Model
mymodel <- model %>%
        fit(training,
            trainingtarget,
            epochs = 100,
            batch_size = 32,
            validation_split = 0.2)

# Evaluate
model %>% evaluate(test, testtarget)
pred <- model %>% predict(test)
mean((testtarget-pred)^2)
plot(testtarget, pred)
        
        