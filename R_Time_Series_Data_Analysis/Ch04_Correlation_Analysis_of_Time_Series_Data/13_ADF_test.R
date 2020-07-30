##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


###  정상근(단위근) 검저: Unit Root Test(ADF.test)

# 시계열 자료가 다음 수식으로 구성될때, 단위근, |α|=1 존재어부,
# 즉  시계열이 차분을 가지는지 여부를 파악하여, 시계열 자료의 정상성 여부를 파악.

#  만일 단위근 존재의 귀무가설이 채택되면, 시계열 자료는 차분이 필요하며, 비정상 시계열로 판단.




library(forecast)
library(tsDyn)
library(tseries)

adf.test(dd1)                                                                                           # no unit-root  


ddd1 <- diff(dd1)                                                                                       # contains a unit root

adf.test(ddd1)                                                                                          #  ddd1


graphics.off()                                                                                          # 그래프를 지워주는 함수.


# 분석결과

# 우연변동의 시계열 자료 "dd1"의 adf.test 검정결과, 검정통계량 Dickey-Fuller 검정통계량=-3.48, p=0.065로서
# 시계열 자료의 단위근이 존재한다는 귀무가설을 채택

# 시계열 자료 "dd1"은 단위근이 존재하며, 차분이 필요하다고 판단.

# 따라서 이를 차분한 시계열 자료 ddd1 분석결과, Dickey-Fuller 검정 통계량=-4.09, p=0.02 < α=0.05로서, 
# 시계열 자료가 단위근을 갖는다는 귀무가설을 기각. 

#즉 차분한 시계열 자료 ddd1은 더 이상 차분이 필요없는 정상 시계열로 판단.


############################################################결과값(print)#################################################################

# # # [Workspace loaded from ~/.RData]

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
# > 
#   > adf.test(dd1)                                                                                           # no unit-root  
# 
# Augmented Dickey-Fuller Test
# 
# data:  dd1
# Dickey-Fuller = -3.4858, Lag order = 2, p-value = 0.06586
# alternative hypothesis: stationary
# 
# > 
#   > 
#   > ddd1 <- diff(dd1)                                                                                       # contains a unit root
# > 
#   > adf.test(ddd1)                                                                                          #  ddd1
# 
# Augmented Dickey-Fuller Test
# 
# data:  ddd1
# Dickey-Fuller = -4.0933, Lag order = 2, p-value = 0.02
# alternative hypothesis: stationary



##########################################################################################################################################