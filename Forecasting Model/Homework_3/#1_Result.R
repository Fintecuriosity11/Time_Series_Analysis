# 
# > dat = read.csv('sunscreen.csv')
# > dat %>% head(20)
# time  x
# 1  2015-10-11 20
# 2  2015-10-18 22
# 3  2015-10-25 19
# 4  2015-11-01 27
# 5  2015-11-08 21
# 6  2015-11-15 23
# 7  2015-11-22 12
# 8  2015-11-29 16
# 9  2015-12-06 15
# 10 2015-12-13 21
# 11 2015-12-20 20
# 12 2015-12-27 21
# 13 2016-01-03 16
# 14 2016-01-10 23
# 15 2016-01-17 18
# 16 2016-01-24 16
# 17 2016-01-31 19
# 18 2016-02-07 24
# 19 2016-02-14 19
# 20 2016-02-21 33
# > head(dat, 20)
# time  x
# 1  2015-10-11 20
# 2  2015-10-18 22
# 3  2015-10-25 19
# 4  2015-11-01 27
# 5  2015-11-08 21
# 6  2015-11-15 23
# 7  2015-11-22 12
# 8  2015-11-29 16
# 9  2015-12-06 15
# 10 2015-12-13 21
# 11 2015-12-20 20
# 12 2015-12-27 21
# 13 2016-01-03 16
# 14 2016-01-10 23
# 15 2016-01-17 18
# 16 2016-01-24 16
# 17 2016-01-31 19
# 18 2016-02-07 24
# 19 2016-02-14 19
# 20 2016-02-21 33
# > dat$time = as.Date(dat$time, format = '%Y-%m-%d')
# > plotly::plot_ly(x = ~dat$time,
#                   +                 y = ~dat$x, mode='lines') %>% 
#   +   plotly::layout(xaxis=list(title='Date'),
#                      +                  yaxis=list(title='Count of iphones'))
# No trace type specified:
#   Based on info supplied, a 'scatter' trace seems appropriate.
# Read more about this trace type -> https://plot.ly/r/reference/#scatter
#   경고메시지(들): 
#   `arrange_()` is deprecated as of dplyr 0.7.0.
# Please use `arrange()` instead.
# See vignette('programming') for more help
# This warning is displayed once every 8 hours.
# Call `lifecycle::last_warnings()` to see where this warning was generated. 
# > dat$seq_time = seq(1, dim(dat)[1])
# > train_idx <- seq(1, round(dim(dat)[1]*0.9))
# > valid_idx <- seq(round(dim(dat)[1]*0.9)+1, dim(dat)[1])
# > dwtest(lm(x~seq_time, dat)) # Has a autocorrelation
# 
# Durbin-Watson test
# 
# data:  lm(x ~ seq_time, dat)
# DW = 0.21662, p-value < 2.2e-16
# alternative hypothesis: true autocorrelation is greater than 0
# 
# > dat$M <- lubridate::month(dat$time)
# > dat %>% head()
# time  x seq_time  M
# 1 2015-10-11 20        1 10
# 2 2015-10-18 22        2 10
# 3 2015-10-25 19        3 10
# 4 2015-11-01 27        4 11
# 5 2015-11-08 21        5 11
# 6 2015-11-15 23        6 11
# > dat$M <- as.factor(dat$M)
# > 
#   > m_binary_data <- dat[,c('x','seq_time', 'M')]
# > m_binary_data %>% head()
# x seq_time  M
# 1 20        1 10
# 2 22        2 10
# 3 19        3 10
# 4 27        4 11
# 5 21        5 11
# 6 23        6 11
# > 
#   > binary_df = data.frame(
#     +   time = m_binary_data$seq_time,
#     +   dummy::dummy(m_binary_data, p='all')[c(1:11)],
#     +   y=log(m_binary_data$x)
#     + )
# > binary_df %>% head()
# time M_1 M_2 M_3 M_4 M_5 M_6 M_7 M_8 M_9 M_10 M_11        y
# 1    1   0   0   0   0   0   0   0   0   0    1    0 2.995732
# 2    2   0   0   0   0   0   0   0   0   0    1    0 3.091042
# 3    3   0   0   0   0   0   0   0   0   0    1    0 2.944439
# 4    4   0   0   0   0   0   0   0   0   0    0    1 3.295837
# 5    5   0   0   0   0   0   0   0   0   0    0    1 3.044522
# 6    6   0   0   0   0   0   0   0   0   0    0    1 3.135494
# > 
#   > binary_train <- binary_df[train_idx,]
# > binary_valid <- binary_df[valid_idx,]
# > binary_model <- lm(formula = y ~ ., data = binary_train)
# > binary_model %>% summary()
# 
# Call:
#   lm(formula = y ~ ., data = binary_train)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.55755 -0.12694  0.00252  0.14124  0.50548 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept) 3.012e+00  4.931e-02  61.084  < 2e-16 ***
#   time        8.057e-05  2.010e-04   0.401    0.689    
# M_11        4.511e-02  6.129e-02   0.736    0.462    
# M_21        2.831e-01  6.280e-02   4.509 1.06e-05 ***
#   M_31        5.319e-01  6.131e-02   8.674 9.10e-16 ***
#   M_41        8.755e-01  6.472e-02  13.528  < 2e-16 ***
#   M_51        1.216e+00  6.578e-02  18.482  < 2e-16 ***
#   M_61        1.313e+00  6.570e-02  19.989  < 2e-16 ***
#   M_71        1.059e+00  6.369e-02  16.630  < 2e-16 ***
#   M_81        5.960e-01  6.687e-02   8.913  < 2e-16 ***
#   M_91        2.955e-01  6.469e-02   4.568 8.17e-06 ***
#   M_101       8.721e-02  6.205e-02   1.406    0.161    
# M_111       2.965e-02  6.208e-02   0.478    0.633    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.2054 on 221 degrees of freedom
# Multiple R-squared:  0.8395,	Adjusted R-squared:  0.8308 
# F-statistic: 96.36 on 12 and 221 DF,  p-value: < 2.2e-16
# 
# > binary_pred = exp(predict(binary_model, newdata = binary_valid[,c(1:12)]))
# > transform_trigo_data = function(n, L, type='1') {
#   +   t <- seq(1,n)
#   +   
#     +   value <- (2 * pi * t) / L
#     +   sin_1 <- sin(value)
#     +   cos_1 <- cos(value)
#     +   
#       +   data = data.frame(t, sin_1, cos_1)
#       +   
#         +   if (type=='2') {
#           +     sin_2 <- sin(value * 2)
#           +     cos_2 <- cos(value * 2)
#           +     data$sin_2 <- sin_2
#           +     data$cos_2 <- cos_2
#           +   }
#       +   return(data)
#       + }
# > 
#   > trigo_data_1 <- data.frame(y=log(dat$x), transform_trigo_data(dim(dat)[1], L=12, '1'))
# > trigo_data_1 %>% head()
# y t        sin_1         cos_1
# 1 2.995732 1 5.000000e-01  8.660254e-01
# 2 3.091042 2 8.660254e-01  5.000000e-01
# 3 2.944439 3 1.000000e+00  6.123032e-17
# 4 3.295837 4 8.660254e-01 -5.000000e-01
# 5 3.044522 5 5.000000e-01 -8.660254e-01
# 6 3.135494 6 1.224606e-16 -1.000000e+00
# > 
#   > trigo_data_2 <- data.frame(y=log(dat$x), transform_trigo_data(dim(dat)[1], L=12, '2'))
# > trigo_data_2 %>% head()
# y t        sin_1         cos_1         sin_2 cos_2
# 1 2.995732 1 5.000000e-01  8.660254e-01  8.660254e-01   0.5
# 2 3.091042 2 8.660254e-01  5.000000e-01  8.660254e-01  -0.5
# 3 2.944439 3 1.000000e+00  6.123032e-17  1.224606e-16  -1.0
# 4 3.295837 4 8.660254e-01 -5.000000e-01 -8.660254e-01  -0.5
# 5 3.044522 5 5.000000e-01 -8.660254e-01 -8.660254e-01   0.5
# 6 3.135494 6 1.224606e-16 -1.000000e+00 -2.449213e-16   1.0
# > 
#   > trigo_train_1 <- trigo_data_1[train_idx,]
# > trigo_valid_1 <- trigo_data_1[valid_idx,]
# > 
#   > trigo_model_1 <- lm(formula = y ~ ., data = trigo_train_1) 
# > trigo_model_1 %>% summary()
# 
# Call:
#   lm(formula = y ~ ., data = trigo_train_1)
# 
# Residuals:
#   Min       1Q   Median       3Q      Max 
# -0.99736 -0.39647 -0.09804  0.39579  1.07150 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  3.511e+00  6.585e-02  53.326   <2e-16 ***
#   t            1.118e-06  4.858e-04   0.002    0.998    
# sin_1       -4.817e-03  4.642e-02  -0.104    0.917    
# cos_1        3.632e-02  4.641e-02   0.783    0.435    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.502 on 230 degrees of freedom
# Multiple R-squared:  0.002702,	Adjusted R-squared:  -0.01031 
# F-statistic: 0.2077 on 3 and 230 DF,  p-value: 0.891
# 
# > 
#   > trigo_1_pred = exp(predict(trigo_model_1, 
#                                +                            newdata = trigo_valid_1[,c('t','sin_1', 'cos_1')]))
# > 
#   > trigo_train_2 <- trigo_data_2[train_idx,]
# > trigo_valid_2 <- trigo_data_2[valid_idx,]
# > 
#   > trigo_model_2 <- lm(formula = y ~ ., data = trigo_train_2)
# > trigo_model_2 %>% summary()
# 
# Call:
#   lm(formula = y ~ ., data = trigo_train_2)
# 
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -0.9880 -0.3949 -0.1004  0.3958  1.0621 
# 
# Coefficients:
#   Estimate Std. Error t value Pr(>|t|)    
# (Intercept)  3.511e+00  6.613e-02  53.092   <2e-16 ***
#   t            1.690e-06  4.880e-04   0.003    0.997    
# sin_1       -4.957e-03  4.662e-02  -0.106    0.915    
# cos_1        3.630e-02  4.662e-02   0.779    0.437    
# sin_2       -3.883e-03  4.662e-02  -0.083    0.934    
# cos_2       -1.195e-02  4.661e-02  -0.256    0.798    
# ---
#   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 0.5041 on 228 degrees of freedom
# Multiple R-squared:  0.00302,	Adjusted R-squared:  -0.01884 
# F-statistic: 0.1381 on 5 and 228 DF,  p-value: 0.9833
# 
# > 
#   > trigo_2_pred = exp(predict(trigo_model_2, 
#                                +                            newdata = trigo_valid_2[,c('t','sin_1', 'cos_1', 'sin_2', 'cos_2')]))
# > ma_data <- dat[train_idx,] %>% mutate(ma = runMean(x, 13))
# > ma_pred <- forecast::forecast(ma_data$ma, h=length(valid_idx))
# 경고메시지(들): 
#   In ets(object, lambda = lambda, biasadj = biasadj, allow.multiplicative.trend = allow.multiplicative.trend,  :
#            Missing values encountered. Using longest contiguous portion of time series
#          > alpha_ses <- 0.3
#          > 
#            > n <- dat$x[train_idx]
#          > li <- list()
#          > 
#            > for(i in 1:length(n)){
#              +   if(i == 1){
#                +     li[[i]] <- alpha_ses * n[i] + (1-alpha_ses) * mean(n)
#                +   }else{
#                  +     li[[i]] <- alpha_ses * n[i] + (1-alpha_ses) * li[[i-1]]
#                  +   }
#              + }
#          > 
#            > rbind(li) # 27.89914
#          [,1]     [,2]     [,3]     [,4]     [,5]    [,6]     [,7]     [,8]     [,9]    [,10]    [,11]    [,12]    [,13]    [,14]    [,15]   
#          li 32.67179 29.47026 26.32918 26.53043 24.8713 24.30991 20.61694 19.23186 17.9623 18.87361 19.21153 19.74807 18.62365 19.93655 19.35559
#          [,16]    [,17]    [,18]    [,19]    [,20]    [,21]    [,22]    [,23]    [,24]    [,25]    [,26]    [,27]    [,28]    [,29]    [,30]  
#          li 18.34891 18.54424 20.18097 19.82668 23.77867 26.54507 26.38155 29.26709 30.68696 34.38087 35.16661 36.01663 43.51164 44.55815 46.1907
#          [,31]    [,32]    [,33]    [,34]    [,35]    [,36]   [,37]    [,38]    [,39]    [,40]    [,41]    [,42]   [,43]    [,44]    [,45]   
#          li 47.33349 51.73344 57.51341 70.25939 70.78157 67.8471 72.09297 74.76508 74.83556 68.88489 64.11942 59.8836 56.31852 52.92296 47.24607
#          [,46]    [,47]    [,48]   [,49]    [,50]    [,51]    [,52]   [,53]    [,54]    [,55]    [,56]    [,57]    [,58]    [,59]    [,60] [,61] 
#          li 43.87225 38.51058 36.2574 33.78018 33.54613 30.98229 29.1876 24.93132 25.85193 26.49635 25.14744 23.30321 25.61225 28.12857 27.19 28.033
#          [,62]   [,63]    [,64]    [,65]    [,66]    [,67]   [,68]    [,69]    [,70]    [,71]    [,72]    [,73]   [,74]    [,75]    [,76]   
#          li 25.6231 27.23617 24.46532 22.82572 24.07801 22.5546 24.48822 23.74176 22.01923 26.21346 31.84942 33.6946 36.48622 36.34035 38.33825
#          [,77]    [,78]    [,79]    [,80]    [,81]    [,82]    [,83]    [,84]    [,85]    [,86]    [,87]    [,88]    [,89]    [,90]    [,91]   
#          li 38.53677 39.57574 45.40302 45.28211 50.29748 49.30824 49.21576 55.15104 60.50572 63.95401 64.56781 70.09746 72.76822 69.23776 71.26643
#          [,92]   [,93]    [,94]    [,95]    [,96]    [,97]    [,98]    [,99]    [,100]   [,101]   [,102]   [,103]  [,104]   [,105]   [,106]  
#          li 71.7865 71.25055 65.17539 62.12277 53.38594 49.97016 50.57911 44.10538 38.37376 36.76163 33.83314 30.2832 28.69824 29.08877 28.46214
#          [,107]  [,108]   [,109]   [,110]   [,111]   [,112]   [,113]  [,114]   [,115]   [,116]  [,117]   [,118]   [,119]   [,120]   [,121]  
#          li 28.0235 25.01645 24.41151 22.18806 22.13164 23.89215 23.0245 23.31715 21.42201 20.6954 19.88678 21.72075 21.80452 20.66317 21.06422
#          [,122]   [,123]   [,124]   [,125]   [,126]   [,127]   [,128] [,129]  [,130]   [,131]   [,132]   [,133]   [,134]   [,135]   [,136]  
#          li 22.54495 23.28147 24.09703 24.96792 26.77754 28.64428 30.551 34.5857 36.20999 39.14699 39.70289 47.89203 53.62442 62.43709 63.80596
#          [,137]   [,138]   [,139]   [,140]   [,141]   [,142]   [,143]   [,144]   [,145]   [,146]   [,147]   [,148]  [,149]   [,150]   [,151]  
#          li 66.56418 69.69492 71.28645 76.30051 78.61036 82.02725 85.31908 78.92335 75.04635 63.63244 57.74271 54.8199 47.37393 42.46175 40.22322
#          [,152]   [,153]   [,154]   [,155]  [,156]   [,157]   [,158]   [,159]   [,160]   [,161]   [,162]   [,163]   [,164]  [,165]   [,166]  
#          li 37.15626 32.90938 30.83657 29.0856 26.65992 26.16194 25.51336 23.25935 22.28155 22.49708 22.34796 21.34357 19.7405 19.81835 20.77284
#          [,167]   [,168]   [,169]   [,170]   [,171]   [,172]   [,173]   [,174]   [,175]   [,176]   [,177]   [,178]   [,179]   [,180]   [,181]  
#          li 20.84099 21.18869 21.43209 22.80246 21.66172 22.06321 22.94424 22.96097 21.77268 23.04088 25.12861 26.29003 29.20302 32.44211 37.40948
#          [,182]   [,183]   [,184]   [,185]   [,186]   [,187]   [,188]   [,189]   [,190]   [,191]  [,192]   [,193]   [,194]   [,195]   [,196]  
#          li 41.48664 41.04065 46.12845 49.38992 49.27294 55.49106 57.74374 64.12062 71.58443 73.5091 74.55637 69.88946 76.52262 77.86584 71.60608
#          [,197]   [,198]   [,199]   [,200]   [,201]   [,202]   [,203]   [,204]   [,205]  [,206]   [,207]   [,208]   [,209]   [,210]   [,211]  
#          li 69.62426 67.33698 63.93589 58.25512 53.37858 52.06501 46.04551 41.83185 38.8823 35.31761 34.62233 32.93563 29.65494 27.35846 25.15092
#          [,212]   [,213]   [,214]   [,215]   [,216]   [,217]   [,218]   [,219]   [,220]   [,221]   [,222]   [,223]   [,224]   [,225]   [,226]  
#          li 23.60564 23.72395 22.30677 22.81474 19.87032 18.40922 17.38645 17.57052 19.79936 21.35955 20.05169 20.93618 23.65533 22.85873 22.30111
#          [,227]   [,228]   [,229]   [,230]  [,231]   [,232]   [,233]   [,234]  
#          li 22.51078 25.05754 29.54028 30.2782 29.89474 27.52632 26.76842 28.03789
#          > 
#            > 
#            > tr_data <- ts(dat$x[train_idx], frequency = 12, start = c(2004,01))
#          > val_data <- ts(dat$x[valid_idx], frequency = 12, start = c(2019,03))
#          > ses_model <- stats::HoltWinters(tr_data, alpha = 0.3, beta = F, gamma = F) # 27.89914
#          > ses_model
#          Holt-Winters exponential smoothing without trend and without seasonal component.
#          
#          Call:
#            stats::HoltWinters(x = tr_data, alpha = 0.3, beta = F, gamma = F)
#          
#          Smoothing parameters:
#            alpha: 0.3
#          beta : FALSE
#          gamma: FALSE
#          
#          Coefficients:
#            [,1]
#          a 28.03789
#          > 
#            > ses_pred <- forecast::forecast(ses_model, h=length(valid_idx))
#          > ses_pred$mean
#          Jan      Feb      Mar      Apr      May      Jun      Jul      Aug      Sep      Oct      Nov      Dec
#          2023                                                       28.03789 28.03789 28.03789 28.03789 28.03789 28.03789
#          2024 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789
#          2025 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789 28.03789                                    
#          > mae <- function(pred, true){
#            +   e = abs(pred-true)
#            +   return(mean(e))
#            + mse <- function(pred, true){
#              +   e = pred - true
#              +   return(mean(e^2))
#              + }
#            + 
#              + rmse <- function(pred, true){
#                +   e <- pred-true
#                +   return(sqrt(mean(e^2)))
#                + }
#              + 
#                + mape <- function(pred, true){
#                  +   non_zero <- which(true != 0, arr.ind = T)
#                  +   return(mean(abs((true[non_zero]-pred[non_zero])/true[non_zero]))*100)
#                  + }
#                + 
#                  + alphas <- seq(0.1, 0.9, 0.1)
#                  + betas <- seq(0.1, 0.9, 0.1)
#                  + gammas <- seq(0.1, 0.9, 0.1)
#                  + model_e = list()
#                  + 
#                    + for(a in alphas){
#                      +   for(b in betas){
#                        +     for(g in gammas){
#                          +       parameters <- paste0("alpha:",a, " beta:",b, " gamma:",g)
#                          +       hw_add <- stats::HoltWinters(tr_data, alpha = a,
#                                                               +                                      beta = b, gamma = g, seasonal = 'additive')
#                          +       hw_predict <- forecast::forecast(hw_add, h=length(valid_idx))
#                          +       mae_val <- mae(pred = hw_predict$mean, true = val_data)
#                          +       mse_val <- mse(pred = hw_predict$mean, true = val_data)
#                          +       rmse_val <- rmse(pred = hw_predict$mean, true = val_data)
#                          +       mape_val <- mape(pred = hw_predict$mean, true = val_data)
#                          +       model_e[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
#                                                                +                                 "MAPE"=mape_val)
#                          +     }
#                        +   }
#                      + }
#                  + 
#                    + hw_add_result = do.call('rbind', model_e)
#                    + which.min(hw_add_result) # 233
#                    + hw_add_result[which.min(hw_add_result),]
#                    + 
#                      + hw_add <- stats::HoltWinters(tr_data, alpha = 0.1,
#                                                     +                              beta = 0.2, gamma = 0.9, seasonal = 'additive')
#                      + 
#                        + hw_add_pred <- forecast::forecast(hw_add, h=length(valid_idx))
#                        + model_e_2 = list()
#                        + 
#                          + for(a in alphas){
#                            +   for(b in betas){
#                              +     for(g in gammas){
#                                +       parameters <- paste0("alpha:",a, " beta:",b, " gamma:",g)
#                                +       hw_mul <- stats::HoltWinters(tr_data, alpha = a,
#                                                                     +                                    beta = b, gamma = g, seasonal = 'multiplicative')
#                                +       hw_predict <- forecast::forecast(hw_mul, h=length(valid_idx))
#                                +       mae_val <- mae(pred = hw_predict$mean, true = val_data)
#                                +       mse_val <- mse(pred = hw_predict$mean, true = val_data)
#                                +       rmse_val <- rmse(pred = hw_predict$mean, true = val_data)
#                                +       mape_val <- mape(pred = hw_predict$mean, true = val_data)
#                                +       model_e_2[[parameters]] <- list("MAE"=mae_val, "MSE"=mse_val, "RMSE"=rmse_val,
#                                                                        +                                     "MAPE"=mape_val)
#                                +     }
#                              +   }
#                            + }
#                        + 
#                          + hw_mul_result = do.call('rbind', model_e_2)
#                          + which.min(hw_mul_result) # 10
#                          + hw_mul_result[which.min(hw_mul_result),]
#                          + 
#                            + hw_mul <- stats::HoltWinters(tr_data, alpha = 0.1,
#                                                           +                              beta = 0.3, gamma = 0.9, seasonal = 'multiplicative')
#                            + hw_mul_pred <- forecast::forecast(hw_mul, h=length(valid_idx))
#                            + all_preds <- data.frame(real=dat$x[valid_idx],
#                                                      +                         bin_pred = binary_pred,
#                                                      +                         tri_pred1 = trigo_1_pred,
#                                                      +                         tri_pred2 = trigo_2_pred,
#                                                      +                         ma_predict = ma_pred$mean,
#                                                      +                         hw_additive = hw_add_pred$mean,
#                                                      +                         hw_multiplicative = hw_mul_pred$mean)
#                            + 
#                              + 
#                              + all_preds %>% dplyr::summarise(
#                                +   MAE_bin = mae(bin_pred, real),
#                                +   MAE_tri1 = mae(tri_pred1, real),
#                                +   MAE_tri2 = mae(tri_pred2, real),
#                                +   MAE_ma = mae(ma_predict, real),
#                                +   MAE_hw_add = mae(hw_additive, real),
#                                +   MAE_hw_multiple = mae(hw_multiplicative, real),
#                                +   MSE_bin = mse(bin_pred, real),
#                                +   MSE_tri1 = mse(tri_pred1, real),
#                                +   MSE_tri2 = mse(tri_pred2, real),
#                                +   MSE_ma = mse(ma_predict, real),
#                                +   MSE_hw_add = mse(hw_additive, real),
#                                +   MSE_hw_multiple = mse(hw_multiplicative, real),
#                                +   RMSE_bin = rmse(bin_pred, real),
#                                +   RMSE_tri1 = rmse(tri_pred1, real),
#                                +   RMSE_tri2 = rmse(tri_pred2, real),
#                                +   RMSE_ma = rmse(ma_predict, real),
#                                +   RMSE_hw_add = rmse(hw_additive, real),
#                                +   RMSE_hw_multiple = rmse(hw_multiplicative, real),
#                                +   MAPE_bin = mape(bin_pred, real),
#                                +   MAPE_tri1 = mape(tri_pred1, real),
#                                +   MAPE_tri2 = mape(tri_pred2, real),
#                                +   MAPE_ma = mape(ma_predict, real),
#                                +   MAPE_hw_add = mape(hw_additive, real),
#                                +   MAPE_hw_multiple = mape(hw_multiplicative, real)
#                                +   )
#                            + plotly::plot_ly(x = ~dat$time) %>% 
#                              +   plotly::layout(xaxis=list(title='Date'),
#                                                 +                  yaxis=list(title='Count of iphones')) %>% 
#                              +     plotly::add_lines(y = ~dat$x, name='Original') %>% 
#                              +     plotly::add_lines(x = ~dat[valid_idx,]$time,
#                                                      +                       y = ~c(hw_mul_pred$mean), name='Predicted') 
#                            + dim(dat)
#                            경고메시지(들): 
#                              1: Unknown or uninitialised column: `Counts`. 
#                            2: Unknown or uninitialised column: `Counts`. 
#                            3: Unknown or uninitialised column: `x`. 