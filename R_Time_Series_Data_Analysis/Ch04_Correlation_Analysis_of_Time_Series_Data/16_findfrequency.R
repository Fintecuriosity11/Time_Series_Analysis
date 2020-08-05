##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


###  Frequency 탐색, findfrequency

# 시계열 자료는 다양한 변동이 중첩되어 있는데, 이러한 시계열 자료에서  frequency를 파악하는 석이 시계열 분석에서 중요한 과제.
# R에서는 ACF, PACF 등을 참조해서 수행.




library(forecast)
library(tsDyn)
library(tseries)

tsdisplay(lynx, main = "Lynx / Year (1821-1934)" )
findfrequency(lynx)


graphics.off()                                                                                          # 그래프를 지워주는 함수.



# 분석자료

# lynx 자료에서 1821~1934까지의 자료
# 자료의 분포는 "tsdisplay"보는 바와 같이 ACF 및 PACF에서 주기성을 보이는데 증감을 반복.


#----------------------------------------------------------------------------------------------------------------------------------------#

# 분석결과

# 분석자료에 대한 "tsdisplay"를 수행한 결과, ACF 및 PACF의 그래프를 보면 다음과 같음
# ACF 그래프에서 주기는 9년, 10년으로 판단
# PACF 그래프에서 1년, 2년에 밀도 변화가 크게 나타나고, 8년 간격으로 양수의 피드백이 나타나는 것으로 판단.
# 1821년부터 1934년까지 113년간의 자료를 전체적으로 보면, 주기는 "10년"으로 산정.


############################################################결과값(print)#################################################################

# [Workspace loaded from ~/.RData]

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

# > tsdisplay(lynx, main = "Lynx / Year (1821-1934)" )
# > findfrequency(lynx)
# [1] 10




##########################################################################################################################################