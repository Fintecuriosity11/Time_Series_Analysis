##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 추세변동을 고려한 지수 평활법의 분석 사례 : HoltWinters (Gamma=FALSE)

# 추세, 우연변동 시계열 자료 "dd3"에 대한 지수 평활법 분석 

library(forecast)
library(tsDyn)
library(tseries)
library(mice)
library(stats)

# dd3 = matrix(c(1142, 1242, 1252, 1343,   1225, 1562, 1356, 1572,
#                1343, 1459, 1412, 1453,   1401, 1478, 1322, 1606,
#                1554, 1589, 1597, 1408))
# 
# dd3.ts = ts(data=dd3, start=c(2006,1), frequency=4)
# 
# hb= HoltWinters(dd3.ts, gamma = F)
# 
# hb
# 
 
# names(hb)                                                                                               # 분석결과의 구분
# 
# hb$SSE                                                                                                  # 잔차의 제곱합
# 
# hb$fitted                                                                                               # 분석결과 추정값
# 

# plot(hb)                                                                                                # 분석결과 그래프

fb=forecast(hb)

names(fb)

tsdisplay(fb$residuals)

Box.test(fb$residuals, type = "Box-Pierce")

hist(fb$residuals, 10, probability = T, col = "light blue", xlab="Time", ylab = "Residuals", main = "Histogram of Residuals")

points(density(fb$residuals, bw=30), type = "i", col='red', lwd=2)

title("\n \n - Trend & Simple Exponential Smoothing -")


graphics.off()                                                                                          # 그래프를 지워주는 함수.


#*************************************************************************************************************************************#


# 예측결과에 대한 잔차의 분석


#  R 퍄키지의 "forecast" 프로그램에 따른 장래 예측값에 대한 결과와 관측값과의 잔차 "fb$residuals"으로 출력됩니다.

# 이러한 잔차에 대하여 "tsdisplay" 수행 결과, ACF(Autocorrelation Function), PACF(Partial Autocorrelation Function)는 95% 유의수준 이하

# 즉, 잔차의 자기상관은 없는 것으로 판단. 
# 또한 잔차의 Box test 결과, x^2=0.67, p=0.41 > 0.05로서 귀무가설을 기각할 수 없음

# 즉, 잔차의 자기상관은 없는 것으로 판단. 그리고 잔차에 대한 Histogram은 결과의 그래프와 같음.


############################################################결과값(print)#################################################################

# [Workspace loaded from ~/.RData]
# 
# > library(forecast)
# Registered S3 method overwritten by 'quantmod':
#   method            from
# as.zoo.data.frame zoo 
# > library(tsDyn)
# > library(tseries)
# 
# ‘tseries’ version: 0.10-47
# 
# ‘tseries’ is a package for time series analysis and computational finance.
# 
# See ‘library(help="tseries")’ for details.
# 
# > library(mice)
# 
# 다음의 패키지를 부착합니다: ‘mice’
# 
# The following objects are masked from ‘package:base’:
#   
#   cbind, rbind
# 
# > library(stats)
# 
# 
# > names(fb)
# [1] "method"    "model"     "level"     "mean"      "lower"     "upper"     "x"         "series"    "fitted"    "residuals"
# > 
#   > tsdisplay(fb$residuals)
# > 
#   > Box.test(fb$residuals, type = "Box-Pierce")
# 
# Box-Pierce test
# 
# data:  fb$residuals
# X-squared = 0.66947, df = 1, p-value = 0.4132
# 
# > 
#   > hist(fb$residuals, 10, probability = T, col = "light blue", xlab="Time", ylab = "Residuals", main = "Histogram of Residuals")
# > 
#   > points(density(fb$residuals, bw=30), type = "I", col='red', lwd=2)
# Error in density.default(fb$residuals, bw = 30) : 
#   'x' contains missing values
# > 
#   > title("\n \n - Trend & Simple Exponential Smoothing -")
# > fb=forecast(hb)
# > names(fb)
# [1] "method"    "model"     "level"     "mean"      "lower"     "upper"     "x"         "series"    "fitted"    "residuals"
# > tsdisplay(fb$residuals)
# > Box.test(fb$residuals, type = "Box-Pierce")
# 
# Box-Pierce test
# 
# data:  fb$residuals
# X-squared = 0.66947, df = 1, p-value = 0.4132
# 
# > hist(fb$residuals, 10, probability = T, col = "light blue", xlab="Time", ylab = "Residuals", main = "Histogram of Residuals")
# > points(density(fb$residuals, bw=30), type = "I", col='red', lwd=2)
# Error in density.default(fb$residuals, bw = 30) : 
#   'x' contains missing values
# > points(density(fb$residuals, bw=30), type = "1", col='red', lwd=2)
# Error in density.default(fb$residuals, bw = 30) : 
#   'x' contains missing values
# > points(density(fb$residuals, bw=30), type = "i", col='red', lwd=2)
# Error in density.default(fb$residuals, bw = 30) : 
#   'x' contains missing values
# > title("\n \n - Trend & Simple Exponential Smoothing -")


