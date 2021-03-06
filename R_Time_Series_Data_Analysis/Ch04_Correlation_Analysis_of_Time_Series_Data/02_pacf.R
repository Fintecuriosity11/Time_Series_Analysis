##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 부분 자기상관 (Partial Auto Correlation) 분석사례: pacf


# 1,2 절의 우연변동 시계열 자료(dd1)에 대하여 부분 자기상관 수행.

library(forecast)
library(tsDyn)
library(tseries)


dd1 = matrix(c(1342, 1442, 1252, 1343,  1425, 1362, 1456,1272,                                          # 우연변동 시계열자료(dd1)
              1243, 1359, 1412, 1253,  1201, 1478, 1322, 1406,
              1254, 1289, 1497, 1208))


dd1.ts = ts(data=dd1, start=c(2006,1), frequency=4)                                                    # 4 분기 설정해서 display.
dd1.ts

(a1= acf(dd1.ts, plot = F))

(a2=pacf(dd1.ts))

plot(a2, main = "Partial AutoCorrelation (95%): dd1.ts")

graphics.off()                                                                                          # 그래프를 지워주는 함수.


#  분석결과:

# 대부분의 시계열 자료가 신뢰구간 95%의 범위 내에 존재하여 2개의 시계열 자료 사이의 부분 자기상관은 존재하지 않는 것으로 판단.
# 자기상관 및 부분 자기상관 그래프는 직접 참조 요망.

############################################################결과값(print)#################################################################

# # 



##########################################################################################################################################