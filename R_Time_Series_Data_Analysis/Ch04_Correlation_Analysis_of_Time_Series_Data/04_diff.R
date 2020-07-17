##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 계절변동 요인 제거 분석사례 : diff.

# 계절변동이 있는 시계열 자료 dd2의 경우, 차분을 산정하는 프로그램 "diff"를 이용하여 계절변동을 제거.


library(forecast)
library(tsDyn)
library(tseries)


dd2 = matrix(c(1142, 1242, 1452, 1543,  1125, 1262, 1456,1572,                                          # 계절변동 시계열자료(dd2)
               1143, 1259, 1462, 1553,  1121, 1258, 1472, 1546,
               1154, 1249, 1477, 1548))


dd2.ts = ts(data=dd1, start=c(2006,1), frequency=4)                                                    # 4 분기 설정해서 display.
dd2.ts

plot(acf(dd2.ts))

plot(pacf(dd2.ts))

op = par(mai=rep(0.4,4), mfrow=c(4,1))
for(i in 1:4) {plot(diff(dd2.ts,lag = i),
                    main = paste("Difference Plot (Data : dd2)"))}

par(op)

graphics.off()                                                                                          # 그래프를 지워주는 함수.


#  분석결과:

# "dd2.ts" 시계열 자료의 경우, frequency = 4 이므로 Time lag = 4에서 주기성분이 제거.
# 프로그램에서 "op"는 그래프의 option. 
# acf, pacf에서 주기는 4로 판단.

############################################################결과값(print)#################################################################

# # [Workspace loaded from ~/.RData]

# > library(forecast)
# Registered S3 method overwritten by 'quantmod':
#   method            from
# as.zoo.data.frame zoo 
# This is forecast 8.12 
# Stackoverflow is a great place to get help on R issues:
#   http://stackoverflow.com/tags/forecasting+r.
# > library(tsDyn)
# > library(tseries)
# 
# ‘tseries’ version: 0.10-47
# 
# ‘tseries’ is a package for time series analysis and computational finance.
# 
# See ‘library(help="tseries")’ for details.
# 
# > dd2 = matrix(c(1142, 1242, 1452, 1543,  1125, 1262, 1456,1572,                                          # 계절변동 시계열자료(dd2)
#                  +                1143, 1259, 1462, 1553,  1121, 1258, 1472, 1546,
#                  +                1154, 1249, 1477, 1548))
# > dd2.ts = ts(data=dd1, start=c(2006,1), frequency=4)                                                    # 4 분기 설정해서 display.
# > dd2.ts
# Qtr1 Qtr2 Qtr3 Qtr4
# 2006 1342 1442 1252 1343
# 2007 1425 1362 1456 1272
# 2008 1243 1359 1412 1253
# 2009 1201 1478 1322 1406
# 2010 1254 1289 1497 1208
# > plot(acf(dd2.ts))
# > plot(pacf(dd2.ts))
# > op = par(mai=rep(0.4,4), mfrow=c(4.1))
# Error in par(mai = rep(0.4, 4), mfrow = c(4.1)) : 
#   그래픽 파라미터 "mfrow"는 잘못된 길이를 가지고 있습니다
# > op = par(mai=rep(0.4,4), mfrow=c(4,1))
# > for(i in 1:4) {plot(diff(dd2.ts,lag = i),
#                       +                     main = paste("Difference Plot (Data : dd2)"))}
# > par(op)



##########################################################################################################################################