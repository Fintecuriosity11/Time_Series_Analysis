##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


###  자료 및 잔차의 정규성 검정 : Jarque-Bera Test

# 시계열 자료의 정규성(normality) 검정을 위하여 Jarque-Bera test가 개발됨.
# Jarque-Berta Test는 시계열 자료의 정규성 및 예측에 따른 잔차의 정규성을 검정하기 위한 분석방법으로서,
# 분석사례로서 앞에서 시행한 우연변동 시계열 자료 (dd1)에 대해 Random Walk Forest 예측방법 적용.


library(forecast)
library(tsDyn)
library(tseries)

jarque.bera.test(dd1)

ff=rwf(dd1.ts)

re=matrix(c(ff$residuals[-1,]))

ff$residuals

re

jarque.bera.test(re)


graphics.off()                                                                                          # 그래프를 지워주는 함수.


# 분석결과

# 우연변동의 시계열 자료 "dd1"의 정규성 검정결과, 검정통계량이 x^2 = 1.29, p=0.52로서 시계열 자료는 정규성이라는 귀무가설 기각 불가능.
# 우연성 시계열 자료 dd1은 정규서이 존재한다고 판단.

# Random Walk Forest에 의한 예측 잔차 "Residuals"의 정규성 검정결과, 검정통계량 x^2=0.57, p=0.75로서 정규성이라는 귀무가설 기각 불가능.
# 즉 우연변동 예측자료의 잔차 "re"는 정규성이 존재한다고 판단.


############################################################결과값(print)#################################################################

# # # #>[Workspace loaded from ~/.RData]
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
# > jarque.bera.test(dd1)
# 
# Jarque Bera Test
# 
# data:  dd1
# X-squared = 1.2951, df = 2, p-value = 0.5233
# 
# > 
#   > ff=rwf(dd1.ts)
# > 
#   > re=matrix(c(ff$residuals[-1,]))
# > 
#   > ff$residuals
# Qtr1 Qtr2 Qtr3 Qtr4
# 2006   NA  100 -190   91
# 2007   82  -63   94 -184
# 2008  -29  116   53 -159
# 2009  -52  277 -156   84
# 2010 -152   35  208 -289
# > 
#   > re
# [,1]
# [1,]  100
# [2,] -190
# [3,]   91
# [4,]   82
# [5,]  -63
# [6,]   94
# [7,] -184
# [8,]  -29
# [9,]  116
# [10,]   53
# [11,] -159
# [12,]  -52
# [13,]  277
# [14,] -156
# [15,]   84
# [16,] -152
# [17,]   35
# [18,]  208
# [19,] -289
# > 
#   > jarque.bera.test(re)
# 
# Jarque Bera Test
# 
# data:  re
# X-squared = 0.57078, df = 2, p-value = 0.7517

# 



##########################################################################################################################################