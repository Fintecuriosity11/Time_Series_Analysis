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

dd3 = matrix(c(1142, 1242, 1252, 1343,   1225, 1562, 1356, 1572,
               1343, 1459, 1412, 1453,   1401, 1478, 1322, 1606,
               1554, 1589, 1597, 1408))

dd3.ts = ts(data=dd3, start=c(2006,1), frequency=4)

hb= HoltWinters(dd3.ts, gamma = F)

hb




graphics.off()                                                                                          # 그래프를 지워주는 함수.


#*************************************************************************************************************************************#


# 자료입력 및 단순 지수 평활법 분석

# R의 기본적인 패키지인 "stats"에 있는 "HoltWinters" 프로그램에서 (gamma = FALSE)를 적용할 경우, 추세변동
# "beta"는 고려하여 산정하지만, 계절변동 "gamma"를 고려하지 않는 형태의 지수 평활법이 적용됩니다.
# 이에 따른 분석결과, 다음과 같이 alpha=0.23, beta=1의 분석결과를 얻었습니다.

# 이때 coefficient값은 결과와 같이 a=1614.77, b=4.27로 산정되었습니다.


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


# > dd3 = matrix(c(1142, 1242, 1252, 1343,   1225, 1562, 1356, 1572,
#                  +                1343, 1459, 1412, 1453,   1401, 1478, 1322, 1606,
#                  +                1554, 1589, 1597, 1408))
# 
# 
# > dd3.ts = ts(data=dd3, start=c(2006,1), frequency=4)
# > hb= HoltWinters(dd3.ts, gamma = F)
# > hb
# Holt-Winters exponential smoothing with trend and without seasonal component.
# 
# Call:
#   HoltWinters(x = dd3.ts, gamma = F)
# 
# Smoothing parameters:
#   alpha: 0.2272783
# beta : 1
# gamma: FALSE
# 
# Coefficients:
#   [,1]
# a 1614.777636
# b    4.278506
# 
# 
