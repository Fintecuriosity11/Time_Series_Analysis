##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 정상성 검정: kWiatkowski-Phillips-Schmidt Test(Shin Test)

# 시계열 자료의 정상성 검정(Stationary Test) 분석방법으로 KPSS Test(Kwiatkowski- Phillips Schmidt-shin Test)가 개발됨.
# KPSS Test는 시계열 자료의 정상성 수준과 추세를 검정하기 위한 분석방법으로서(level of trend stationary) package가 있음.


library(forecast)
library(tsDyn)
library(tseries)

kpss.test(dd1)

kpss.test(dd4)


kpss.test(dd1,"Trend")

kpss.test(dd4,"Trend")


graphics.off()                                                                                          # 그래프를 지워주는 함수.


# 정상성 수준 검정결과

# 시계열 자료 "dd1"의 정상성 수준 검정결과, 검정통계량 확인.

# 추세 검정 결과

# 시계열 자료 추세를 고려한 정상성 검정결과, 검정통계량과 추세를 고려한 정상성의 귀무가설 채택.


############################################################결과값(print)#################################################################

# # > kpss.test(dd1)

# KPSS Test for Level Stationarity
# 
# data:  dd1
# KPSS Level = 0.16027, Truncation lag parameter = 2, p-value = 0.1
# 
# 경고메시지(들): 
#   In kpss.test(dd1) : p-value greater than printed p-value
# > kpss.test(dd4)
# 
# KPSS Test for Level Stationarity
# 
# data:  dd4
# KPSS Level = 0.74516, Truncation lag parameter = 2, p-value = 0.01
# 
# 경고메시지(들): 
#   In kpss.test(dd4) : p-value smaller than printed p-value
# > kpss.test(dd1,"Trend")
# 
# KPSS Test for Trend Stationarity
# 
# data:  dd1
# KPSS Trend = 0.07389, Truncation lag parameter = 2, p-value = 0.1
# 
# 경고메시지(들): 
#   In kpss.test(dd1, "Trend") : p-value greater than printed p-value
# > 
#   > kpss.test(dd4,"Trend")
# 
# KPSS Test for Trend Stationarity
# 
# data:  dd4
# KPSS Trend = 0.075148, Truncation lag parameter = 2, p-value = 0.1
# 
# 경고메시지(들): 
#   In kpss.test(dd4, "Trend") : p-value greater than printed p-value

# 

##########################################################################################################################################