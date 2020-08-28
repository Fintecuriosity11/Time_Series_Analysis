##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 단순 지수 평활법의 분석 사례 : HoltWinters (beta=FALSE, Gamma=FALSE)

# Alpha 값은 지정되지 않음. 최적화된 값으로 분석

library(forecast)
library(tsDyn)
library(tseries)
library(mice)
library(stats)

# dd1.ts = ts(data=dd1, start=c(2006,1), frequency = 4)
# dd1.ts
# 
# ha=HoltWinters(dd1.ts, beta = F, gamma = F)
# 
# ha
# 
# ha$fitted


fa = forecast(ha)

names(fa)

tsdisplay(fa$residuals)

Box.test(fa$residuals, type = "Box-Pierce")


hist(fa$residuals, 10, probability = T, col = "light blue",
     xlab = "Time", ylab = "Residuals", main = "Histograms of Residuals")

points(density(fa$residuals, bw=30), type='i', col='red', lwd=2)

title("Simple exponential smoothing")

graphics.off()                                                                                          # 그래프를 지워주는 함수.


#*************************************************************************************************************************************#


# 예측결과에 대한 잔차의 분석 : 

# 잔차에 대하여 "tsdisplay" 수행 결과, ACF, PACF는 95% 유의수준 이하로 나타났습니다.

# 즉, 잔차의 자기상관은 없는 것으로 판단되었습니다.

# 또한 잔차의 Box test 결과, x^2 =2.07, p=0.14>0.05로서, 귀무가설을 기각할 수 없습니다.

# 즉, 잔차의 자기상관은 없는 것으로 판단됩니다. 그리고 잔차에 대한 Histogram은 아래와 같습니다.



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



# > fa = forecast(ha)
# > names(fa)
# [1] "method"    "model"     "level"     "mean"      "lower"     "upper"     "x"         "series"    "fitted"    "residuals"

# 
# > tsdisplay(fa$residuals)
# > Box.test(fa$residuals, type = "Box-Pierce")
# 
# Box-Pierce test
# 
# data:  fa$residuals
# X-squared = 2.0761, df = 1, p-value = 0.1496
# 
# > hist(fa$residuals, 10, probability = T, col = "light blue",
#        +      xlab = "Time", ylab = "Residuals", main = "Histograms of Residuals")
# > points(density(fa$residuals, bw=30), type='i', col='red', lwd=2)
# Error in density.default(fa$residuals, bw = 30) : 
#   'x' contains missing values
# > title("Simple exponential smoothing")
# > points(density(fa$residuals, bw=30), type='i', col='red', lwd=2)
# Error in density.default(fa$residuals, bw = 30) : 
#   'x' contains missing values



