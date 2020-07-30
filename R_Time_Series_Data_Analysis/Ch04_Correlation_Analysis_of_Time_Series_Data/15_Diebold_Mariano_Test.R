##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


###  예측결과와 우열에 대한 검정: Diebold-Mariano Test

# 시계열 자료의 예측결과에 대한 우열성의 검정을 수행.

# 분석자료

# 분석자료는 R의 데이터셋에 있는 "WWWusuage"로서, 이는 인터넷 서버에 100분간 접속한 User의 시계열 자료.
# 이를 uts 모형으로 적용한 것을 f1, arima 모형을 적용한 것을 f2로 하여, 시계열 분석을 수행한 것을 검정대상으로 함.


install.packages("tseries")

library(forecast)
library(tsDyn)
library(tseries)
library(MASS)

f1 <- ets(WWWusage)
f2 <- auto.arima(WWWusage)

accuracy(f1)

accuracy(f2)

dm.test(residuals(f1),residuals(f2))

dm.test(residuals(f1),residuals(f2),alternative="less")


graphics.off()                                                                                          # 그래프를 지워주는 함수.


# 검정 결과

# 검정대상의 두 분석모형에 대한 예측 결과를 요약.
#  ARIMA 모형이 ETS 모형보다 우수한 것으로 나타남.

# 이에 대한 검정결과, Diebold-Mariano Test에서 유의수준 0.035<0.05 로서 귀무가설 기각.

# 분석방법에는 차이가 있음 
#  ARIMA 모형의 분석결과가 ETS 모형보다 우수한 것으로 판단.

############################################################결과값(print)#################################################################

# 
# > library(forecast)
# > library(tsDyn)
# > library(tseries)
# > library(MASS)


# > f1 <- ets(WWWusage)

# > f2 <- auto.arima(WWWusage)

# > accuracy(f1)
# ME    RMSE      MAE       MPE     MAPE      MASE      ACF1
# Training set 0.2243266 3.40781 2.761668 0.2629465 2.162415 0.6102792 0.2308014

# > 

#   > accuracy(f2)
# ME     RMSE      MAE       MPE     MAPE      MASE        ACF1
# Training set 0.3035616 3.113754 2.405275 0.2805566 1.917463 0.5315228 -0.01715517

# > dm.test(residuals(f1),residuals(f2))
# 
# Diebold-Mariano Test
# 
# data:  residuals(f1)residuals(f2)
# DM = 1.9078, Forecast horizon = 1, Loss function power = 2, p-value = 0.05932
# alternative hypothesis: two.sided
# 
# > 
#   > dm.test(residuals(f1),residuals(f2),alternative="less")
# 
# Diebold-Mariano Test
# 
# data:  residuals(f1)residuals(f2)
# DM = 1.9078, Forecast horizon = 1, Loss function power = 2, p-value = 0.9703
# alternative hypothesis: less



##########################################################################################################################################