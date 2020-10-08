library(dplyr); library(plotly); library(anytime); library(lubridate)
library(dummy); library(lmtest); library(TTR); library(graphics)


install.packages("dplyr")
install.packages("dummy")
install.packages("TTR")
install.packages("lubridate")
install.packages("anytime")

################# SEASONAL VARIATION #################

dat = read.csv('ML.csv')
# dat %>% head(20)

head(dat, 20)

dat$time = as.Date(dat$time, format = '%Y-%m-%d')
plotly::plot_ly(x = ~dat$time,
                y = ~dat$x, mode='lines') %>% 
  plotly::layout(xaxis=list(title='Date'),
                 yaxis=list(title='Count of iphones'))
dat$seq_time = seq(1, dim(dat)[1])

# Train & Valid split
train_idx <- seq(1, round(dim(dat)[1]*0.9))
valid_idx <- seq(round(dim(dat)[1]*0.9)+1, dim(dat)[1])

# Durbin-Watson text
dwtest(lm(x~seq_time, dat)) # Has a autocorrelation


############# Binary Modeling #############
dat$M <- lubridate::month(dat$time)
dat %>% head()
dat$M <- as.factor(dat$M)

m_binary_data <- dat[,c('x','seq_time', 'M')]
m_binary_data %>% head()

binary_df = data.frame(
  time = m_binary_data$seq_time,
  dummy::dummy(m_binary_data, p='all')[c(1:11)],
  y=log(m_binary_data$x)
)
binary_df %>% head()

binary_train <- binary_df[train_idx,]
binary_valid <- binary_df[valid_idx,]

# Model Fitting
binary_model <- lm(formula = y ~ ., data = binary_train)
binary_model %>% summary()

# Prediction
binary_pred = exp(predict(binary_model, newdata = binary_valid[,c(1:12)]))

############# Trigometic Modeling #############
transform_trigo_data = function(n, L, type='1') {
  t <- seq(1,n)
  
  value <- (2 * pi * t) / L
  sin_1 <- sin(value)
  cos_1 <- cos(value)
  
  data = data.frame(t, sin_1, cos_1)
  
  if (type=='2') {
    sin_2 <- sin(value * 2)
    cos_2 <- cos(value * 2)
    data$sin_2 <- sin_2
    data$cos_2 <- cos_2
  }
  return(data)
}

trigo_data_1 <- data.frame(y=log(dat$x), transform_trigo_data(dim(dat)[1], L=12, '1'))
trigo_data_1 %>% head()

trigo_data_2 <- data.frame(y=log(dat$x), transform_trigo_data(dim(dat)[1], L=12, '2'))
trigo_data_2 %>% head()

trigo_train_1 <- trigo_data_1[train_idx,]
trigo_valid_1 <- trigo_data_1[valid_idx,]

trigo_model_1 <- lm(formula = y ~ ., data = trigo_train_1) 
trigo_model_1 %>% summary()

trigo_1_pred = exp(predict(trigo_model_1, 
                           newdata = trigo_valid_1[,c('t','sin_1', 'cos_1')]))

trigo_train_2 <- trigo_data_2[train_idx,]
trigo_valid_2 <- trigo_data_2[valid_idx,]

trigo_model_2 <- lm(formula = y ~ ., data = trigo_train_2)
trigo_model_2 %>% summary()

trigo_2_pred = exp(predict(trigo_model_2, 
                           newdata = trigo_valid_2[,c('t','sin_1', 'cos_1', 'sin_2', 'cos_2')]))


############# Moving Average #############
ma_data <- dat[train_idx,] %>% mutate(ma = runMean(x, 13))
ma_pred <- forecast::forecast(ma_data$ma, h=length(valid_idx))

############# Simple Exponential Smoothing #############
alpha_ses <- 0.3

n <- dat$x[train_idx]
li <- list()

for(i in 1:length(n)){
  if(i == 1){
    li[[i]] <- alpha_ses * n[i] + (1-alpha_ses) * mean(n)
  }else{
    li[[i]] <- alpha_ses * n[i] + (1-alpha_ses) * li[[i-1]]
  }
}

rbind(li) # 27.89914


tr_data <- ts(dat$x[train_idx], frequency = 12, start = c(2004,01))
val_data <- ts(dat$x[valid_idx], frequency = 12, start = c(2019,03))
ses_model <- stats::HoltWinters(tr_data, alpha = 0.3, beta = F, gamma = F) # 27.89914
ses_model

ses_pred <- forecast::forecast(ses_model, h=length(valid_idx))
ses_pred$mean

# Metrics
mae <- function(pred, true){
  e = abs(pred-true)
  return(mean(e))
}

mse <- function(pred, true){
  e = pred - true
  return(mean(e^2))
}

rmse <- function(pred, true){
  e <- pred-true
  return(sqrt(mean(e^2)))
}

mape <- function(pred, true){
  non_zero <- which(true != 0, arr.ind = T)
  return(mean(abs((true[non_zero]-pred[non_zero])/true[non_zero]))*100)
}

alphas <- seq(0.1, 0.9, 0.1)
betas <- seq(0.1, 0.9, 0.1)
gammas <- seq(0.1, 0.9, 0.1)

# Holt-Winters Additive model
model_e = list()

for(a in alphas){
  for(b in betas){
    for(g in gammas){
      parameters <- paste0("alpha:",a, " beta:",b, " gamma:",g)
      hw_add <- stats::HoltWinters(tr_data, alpha = a,
                                     beta = b, gamma = g, seasonal = 'additive')
      hw_predict <- forecast::forecast(hw_add, h=length(valid_idx))
      mae_val <- mae(pred = hw_predict$mean, true = val_data)
      mse_val <- mse(pred = hw_predict$mean, true = val_data)
      rmse_val <- rmse(pred = hw_predict$mean, true = val_data)
      mape_val <- mape(pred = hw_predict$mean, true = val_data)
      model_e[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
                                "MAPE"=mape_val)
    }
  }
}

hw_add_result = do.call('rbind', model_e)
which.min(hw_add_result) # 233
hw_add_result[which.min(hw_add_result),]

hw_add <- stats::HoltWinters(tr_data, alpha = 0.1,
                             beta = 0.2, gamma = 0.9, seasonal = 'additive')

hw_add_pred <- forecast::forecast(hw_add, h=length(valid_idx))

# Holt-Winter Multiplicative model
model_e_2 = list()

for(a in alphas){
  for(b in betas){
    for(g in gammas){
      parameters <- paste0("alpha:",a, " beta:",b, " gamma:",g)
      hw_mul <- stats::HoltWinters(tr_data, alpha = a,
                                   beta = b, gamma = g, seasonal = 'multiplicative')
      hw_predict <- forecast::forecast(hw_mul, h=length(valid_idx))
      mae_val <- mae(pred = hw_predict$mean, true = val_data)
      mse_val <- mse(pred = hw_predict$mean, true = val_data)
      rmse_val <- rmse(pred = hw_predict$mean, true = val_data)
      mape_val <- mape(pred = hw_predict$mean, true = val_data)
      model_e_2[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
                                    "MAPE"=mape_val)
    }
  }
}

hw_mul_result = do.call('rbind', model_e_2)
which.min(hw_mul_result) # 10
hw_mul_result[which.min(hw_mul_result),]

hw_mul <- stats::HoltWinters(tr_data, alpha = 0.1,
                             beta = 0.3, gamma = 0.9, seasonal = 'multiplicative')
hw_mul_pred <- forecast::forecast(hw_mul, h=length(valid_idx))

## All preds
all_preds <- data.frame(real=dat$x[valid_idx],
                        bin_pred = binary_pred,
                        tri_pred1 = trigo_1_pred,
                        tri_pred2 = trigo_2_pred,
                        ma_predict = ma_pred$mean,
                        hw_additive = hw_add_pred$mean,
                        hw_multiplicative = hw_mul_pred$mean)


all_preds %>% dplyr::summarise(
  # MAE
  MAE_bin = mae(bin_pred, real),
  MAE_tri1 = mae(tri_pred1, real),
  MAE_tri2 = mae(tri_pred2, real),
  MAE_ma = mae(ma_predict, real),
  MAE_hw_add = mae(hw_additive, real),
  MAE_hw_multiple = mae(hw_multiplicative, real),
  # MSE
  MSE_bin = mse(bin_pred, real),
  MSE_tri1 = mse(tri_pred1, real),
  MSE_tri2 = mse(tri_pred2, real),
  MSE_ma = mse(ma_predict, real),
  MSE_hw_add = mse(hw_additive, real),
  MSE_hw_multiple = mse(hw_multiplicative, real),
  # RMSE
  RMSE_bin = rmse(bin_pred, real),
  RMSE_tri1 = rmse(tri_pred1, real),
  RMSE_tri2 = rmse(tri_pred2, real),
  RMSE_ma = rmse(ma_predict, real),
  RMSE_hw_add = rmse(hw_additive, real),
  RMSE_hw_multiple = rmse(hw_multiplicative, real),
  # MAPE
  MAPE_bin = mape(bin_pred, real),
  MAPE_tri1 = mape(tri_pred1, real),
  MAPE_tri2 = mape(tri_pred2, real),
  MAPE_ma = mape(ma_predict, real),
  MAPE_hw_add = mape(hw_additive, real),
  MAPE_hw_multiple = mape(hw_multiplicative, real)
  )

## ---> MAE, MSE, RMSE, MAPE ëª¨ë‘ Holt-Winter Multiple?˜ ?˜ˆì¸¡ë ¥?´ ê°€?ž¥ ì¢‹ìŒ 

plotly::plot_ly(x = ~dat$time) %>% 
  plotly::layout(xaxis=list(title='Date'),
                 yaxis=list(title='Count of iphones')) %>% 
    plotly::add_lines(y = ~dat$x, name='Original') %>% 
    plotly::add_lines(x = ~dat[valid_idx,]$time,
                      y = ~c(hw_mul_pred$mean), name='Predicted') 
  

################# TREND #################
# Read data
dat = read.csv("ML.csv")
dat %>% head(20)
dat$time = as.Date(dat$time, format = '%Y-%m-%d')
plotly::plot_ly(x = ~dat$time,
                y = ~dat$x, mode='lines') %>% 
  plotly::layout(xaxis=list(title='Date'),
                 yaxis=list(title='Count of iphones'))
dat$seq_time = seq(1, dim(dat)[1])

# Train & Valid split
train_idx <- seq(1, round(dim(dat)[1]*0.9))
valid_idx <- seq(round(dim(dat)[1]*0.9)+1, dim(dat)[1])

tr_data <- ts(dat$x[train_idx], frequency = 12, start = c(2004,01))
val_data <- ts(dat$x[valid_idx], frequency = 12, start = c(2019,03))

# Durbin-Watson text
dwtest(lm(x~seq_time, dat)) # Has a autocorrelation

# Metrics
mae <- function(pred, true){
  e = abs(pred-true)
  return(mean(e))
}

mse <- function(pred, true){
  e = pred - true
  return(mean(e^2))
}

rmse <- function(pred, true){
  e <- pred-true
  return(sqrt(mean(e^2)))
}

mape <- function(pred, true){
  non_zero <- which(true != 0, arr.ind = T)
  return(mean(abs((true[non_zero]-pred[non_zero])/true[non_zero]))*100)
}

############ Moving Average ############
ma_data <- dat[train_idx,] %>% mutate(ma = runMean(x, 13))
ma_pred <- forecast::forecast(ma_data$ma, h=length(valid_idx))

############# Simple Exponential Smoothing #############
alphas <- seq(0.1, 0.9, 0.1)
betas <- seq(0.1, 0.9, 0.1)
#gammas <- seq(0.1, 0.9, 0.1)

model_ses = list()

for(a in alphas){
  parameters <- paste0("alpha:",a)
  ses <- stats::HoltWinters(tr_data, alpha = a,
                               beta = F, gamma = F)
  simple_exp_smth <- forecast::forecast(ses, h=length(valid_idx))
  mae_val <- mae(pred = simple_exp_smth$mean, true = val_data)
  mse_val <- mse(pred = simple_exp_smth$mean, true = val_data)
  rmse_val <- rmse(pred = simple_exp_smth$mean, true = val_data)
  mape_val <- mape(pred = simple_exp_smth$mean, true = val_data)
  model_ses[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
                                "MAPE"=mape_val)
  }

sem = do.call('rbind', model_ses)
which.min(sem) # 233
sem[which.min(sem),]

sem_fin <- stats::HoltWinters(tr_data, alpha = 0.9,
                             beta = F, gamma = F)

sem_pred <- forecast::forecast(sem_fin, h=length(valid_idx))

## Double exponential 
model_des = list()

for(a in alphas){
  for(b in betas){
    parameters <- paste0("alpha:",a, ' beta:',b)
    des <- stats::HoltWinters(tr_data, alpha = a,
                              beta = b, gamma = F)
    doub_exp_smth <- forecast::forecast(des, h=length(valid_idx))
    mae_val <- mae(pred = doub_exp_smth$mean, true = val_data)
    mse_val <- mse(pred = doub_exp_smth$mean, true = val_data)
    rmse_val <- rmse(pred = doub_exp_smth$mean, true = val_data)
    mape_val <- mape(pred = doub_exp_smth$mean, true = val_data)
    model_des[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
                                    "MAPE"=mape_val)
    
  }
}
dem = do.call('rbind', model_des)
which.min(dem) # 233
dem[which.min(dem),]

dem_fin <- stats::HoltWinters(tr_data, alpha = 0.1,
                              beta = 0.3, gamma = F)

dem_pred <- forecast::forecast(dem_fin, h=length(valid_idx))


## All preds
all_preds <- data.frame(real=dat$x[valid_idx],
                        ma_predict = ma_pred$mean,
                        simple = sem_pred$mean,
                        double = dem_pred$mean)

all_preds %>% dplyr::summarise(
  # MAE
  MAE_ma = mae(ma_predict, real),
  MAE_ses = mae(simple, real),
  MAE_des = mae(double, real),
  # MSE
  MSE_ma = mse(ma_predict, real),
  MSE_ses = mse(simple, real),
  MSE_des = mse(double, real),
  # RMSE
  RMSE_ma = rmse(ma_predict, real),
  RMSE_ses = rmse(simple, real),
  RMSE_des = rmse(double, real),
  # MAPE
  MAPE_ma = mape(ma_predict, real),
  MAPE_ses = mape(simple, real),
  MAPE_des = mape(double, real),
)

## ---> MAE, MSE, RMSE, MAPE ëª¨ë‘ Holt-Winter Multiple?˜ ?˜ˆì¸¡ë ¥?´ ê°€?ž¥ ì¢‹ìŒ 

plotly::plot_ly(x = ~dat$time) %>% 
  plotly::layout(xaxis=list(title='Date'),
                 yaxis=list(title='Count of iphones')) %>% 
  plotly::add_lines(y = ~dat$x, name='Original') %>% 
  plotly::add_lines(x = ~dat[valid_idx,]$time,
                    y = ~c(sem_pred$mean), name='Predicted') 

