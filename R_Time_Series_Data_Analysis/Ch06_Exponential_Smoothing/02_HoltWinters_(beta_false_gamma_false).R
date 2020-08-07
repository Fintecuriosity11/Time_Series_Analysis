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

dd1.ts = ts(data=dd1, start=c(2006,1), frequency = 4)
dd1.ts

ha=HoltWinters(dd1.ts, beta = F, gamma = F)

ha

ha$fitted


graphics.off()                                                                                          # 그래프를 지워주는 함수.



# HoltWinters 프로그램에서 (beta=FALSE, gamma=FALSE)를 적용하면, 추세변동 "beta", 계절변동 "gamma"를 고려하지 않은 단순지수 평활 적용.
# 분석 결과, 다음과 같이 Alpha=0에 가까운 분석결과를 얻음.
# alpha 값이 zero에 가깝다는 것은 m_t = m_t - 1이 되는 것을 의미.

names(ha)                                                                                             # 분석결과의 구분

ha$SSE                                                                                                # 잔차의 제곱합

ha$fitted                                                                                             # 분석결과 추정값

#*************************************************************************************************************************************#

# 단순지수 평활법의 추정결과 "ha"는 총 9개의 종류가 출력
# "ha$SSE"는 잔차제곱합

# "ha$fitted"는 추정값으로서, 이를 그래프로 나타냄.

# 가로의 직선이 추정값


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
# > library(mice)
# 
# 다음의 패키지를 부착합니다: ‘mice’
# 
# The following objects are masked from ‘package:base’:
#   
#   cbind, rbind
# 
# > library(stats)
# > dd1.ts = ts(data=dd1, start=c(2006,1), frequency = 4)
# > dd1.ts
# Qtr1 Qtr2 Qtr3 Qtr4
# 2006 1342 1442 1252 1343
# 2007 1425 1362 1456 1272
# 2008 1243 1359 1412 1253
# 2009 1201 1478 1322 1406
# 2010 1254 1289 1497 1208
# > ha=HoltWinters(dd1.ts, beta = F, gamma = F)
# > ha
# Holt-Winters exponential smoothing without trend and without seasonal component.
# 
# Call:
#   HoltWinters(x = dd1.ts, beta = F, gamma = F)
# 
# Smoothing parameters:
#   alpha: 6.610696e-05
# beta : FALSE
# gamma: FALSE
# 
# Coefficients:
#   [,1]
# a 1341.998
# > ha$fitted
# xhat    level
# 2006 Q2 1342.000 1342.000
# 2006 Q3 1342.007 1342.007
# 2006 Q4 1342.001 1342.001
# 2007 Q1 1342.001 1342.001
# 2007 Q2 1342.006 1342.006
# 2007 Q3 1342.008 1342.008
# 2007 Q4 1342.015 1342.015
# 2008 Q1 1342.010 1342.010
# 2008 Q2 1342.004 1342.004
# 2008 Q3 1342.005 1342.005
# 2008 Q4 1342.010 1342.010
# 2009 Q1 1342.004 1342.004
# 2009 Q2 1341.994 1341.994
# 2009 Q3 1342.003 1342.003
# 2009 Q4 1342.002 1342.002
# 2010 Q1 1342.006 1342.006
# 2010 Q2 1342.001 1342.001
# 2010 Q3 1341.997 1341.997
# 2010 Q4 1342.007 1342.007


##########################################################################################################################################



#  분석결과의 추정.

# > names(ha)                                                                                             # 분석결과의 구분
# [1] "fitted"       "x"            "alpha"        "beta"         "gamma"        "coefficients" "seasonal"     "SSE"          "call"        

# > ha$SSE                                                                                                # 잔차의 제곱합
# [1] 161614.6

# > ha$fitted                                                                                             # 분석결과 추정값
# xhat    level
# 2006 Q2 1342.000 1342.000
# 2006 Q3 1342.007 1342.007
# 2006 Q4 1342.001 1342.001
# 2007 Q1 1342.001 1342.001
# 2007 Q2 1342.006 1342.006
# 2007 Q3 1342.008 1342.008
# 2007 Q4 1342.015 1342.015
# 2008 Q1 1342.010 1342.010
# 2008 Q2 1342.004 1342.004
# 2008 Q3 1342.005 1342.005
# 2008 Q4 1342.010 1342.010
# 2009 Q1 1342.004 1342.004
# 2009 Q2 1341.994 1341.994
# 2009 Q3 1342.003 1342.003
# 2009 Q4 1342.002 1342.002
# 2010 Q1 1342.006 1342.006
# 2010 Q2 1342.001 1342.001
# 2010 Q3 1341.997 1341.997
# 2010 Q4 1342.007 1342.007