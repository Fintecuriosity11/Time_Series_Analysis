##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 단순 지수 평활법의 분석 사례 : HoltWinters (beta=FALSE, Gamma=FALSE)

# Alpha 값은 지정되지 않음. 최적화된 값으로 분석
# 
# library(forecast)
# library(tsDyn)
# library(tseries)
# library(mice)
# library(stats)

# dd1.ts = ts(data=dd1, start=c(2006,1), frequency = 4)
# dd1.ts
# 
# ha=HoltWinters(dd1.ts, beta = F, gamma = F)
# 
# ha
# 
# ha$fitted

# 
# fa = forecast(ha)
# 
# names(fa)
# 
# tsdisplay(fa$residuals)
# 
# Box.test(fa$residuals, type = "Box-Pierce")
# 
# 
# hist(fa$residuals, 10, probability = T, col = "light blue",
#      xlab = "Time", ylab = "Residuals", main = "Histograms of Residuals")
# 
# points(density(fa$residuals, bw=30), type='i', col='red', lwd=2)
# 
# title("Simple exponential smoothing")

#*************************************************************************************************************************************#

library(forecast)
library(tsDyn)
library(tseries)
library(mice)
library(stats)

fa=forecast(ha, h=4)

fa

accuracy(fa)

plot(forecast(ha, h=4))

lines(fa$fitted, col="red", lty=2, lwd=2)

plot(forecast(ha, h=4, fan = T))

lines(fa$fitted, col="red", lty=2, lwd=2)


graphics.off()                                                                                          # 그래프를 지워주는 함수.


#*************************************************************************************************************************************#


# 예측결과: 관측자료는 2006년부터 2010년까지 분기별 자료로서, 예측자료는 2011년 4개 분기별 자료입니다.

# 단순 지수 평활법에 의한 예측결과는 다음에서 보는 바와 같이, 4개 분기 모두 1342로 예측되었습니다.

# 예측결과에 대한 MAPE 값은 6.09, MESE값은 0.76으로 산정되었습니다.

# 이러한 예측결과에 따른 그래프는 아래 결과에서 보는것과 같습니다.

# 일반적인 예측 그래프는 80%, 95% 유의수준, fan plot은 51-99% 의 유의수준을 표시시


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


# > fa=forecast(ha, h=4)
# > fa
# Point Forecast    Lo 80    Hi 80    Lo 95    Hi 95
# 2011 Q1       1341.998 1220.576 1463.421 1156.299 1527.698
# 2011 Q2       1341.998 1220.576 1463.421 1156.299 1527.698
# 2011 Q3       1341.998 1220.576 1463.421 1156.299 1527.698
# 2011 Q4       1341.998 1220.576 1463.421 1156.299 1527.698
# > accuracy(fa)
# ME     RMSE      MAE        MPE     MAPE      MASE       ACF1
# Training set -1.267407 92.22816 81.26555 -0.5680335 6.088734 0.7626093 -0.3305546
# > plot(forecast(ha, h=4))
# > lines(fa$fitted, col="red", lty=2, lwd=2)
# > plot(forecast(ha, h=4, fan = T))
# > lines(fa$fitted, col="red", lty=2, lwd=2)
# > graphics.off()                                                                                          # 그래프를 지워주는 함수.


