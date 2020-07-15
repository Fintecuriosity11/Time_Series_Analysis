##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 시계열 자료의 상관분석 및 검정.

# 통계분석에서 분석모형 구축의 사전단계로서, 분석대상 자료의 평균, 분산, 상관계수 등
# 기초통계량을 산정하여 자료속성을 파악
# 시계열 분석에서도 시계열 자료의 특성을 파악하는 기초분석을 수행.

# 일반적으로 공분산 또는 상관관계는 서로 다른 두 변량 사이의 연관관계를 의미하며, yt를 하나의 임의 프로세스로 정의

# 시간의 변화에도 불구하고 시계열 자료의 평균과 공분산이 변화하지 않고 균형적으로 변동하는 경우, 정상 시계열 자료.

# 그렇지 않은 경우를 비정상 시계열 자료라 칭함.




dd1.ts = ts(data=dd1, start=c(2006,1), frequency=4)
dd2.ts = ts(data=dd2, start=c(2006,1), frequency=4)

plot(acf(dd1.ts), main="Autocorrelation (95%) : dd1.ts")
plot(acf(dd2.ts), main="Autocorrelation plot : dd2.ts")

plot(acf(dd2.ts), type = "covariance" , main="Autocovariance plot : dd2.ts")


(al=acf(dd1.ts))                                                                                        # 자기상관 산정결과 

(a2=acf(dd1.ts, type = "covariance"))                                                                   # 자기공분산 산정결과

graphics.off()                                                                                          # 그래프를 지워주는 함수.


############################################################결과값(print)#################################################################

# # > dd1.ts = ts(data=dd1, start=c(2006,1), frequency=4)
# > dd2.ts = ts(data=dd2, start=c(2006,1), frequency=4)
# > plot(acf(dd1.ts), main="Autocorrelation (95%) : dd1.ts")
# > plot(acf(dd2.ts), main="Autocorrelation plot : dd2.ts")
# > plot(acf(dd1.ts), type = "covariance" , main="Autocorrelation plot : dd2.ts")
# Warning message:
#   In plot.xy(xy, type, ...) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# > plot(acf(dd2.ts), type = "covariance" , main="Autocorrelation plot : dd2.ts")
# Warning messages:
#   1: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# 2: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# 3: In plot.xy(xy, type, ...) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# > dd1.ts = ts(data=dd1, start=c(2006,1), frequency=4)
# Warning messages:
#   1: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# 2: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# > dd2.ts = ts(data=dd2, start=c(2006,1), frequency=4)
# > plot(acf(dd1.ts), main="Autocorrelation (95%) : dd1.ts")
# > plot(acf(dd2.ts), main="Autocorrelation plot : dd2.ts")
# > plot(acf(dd2.ts), type = "covariance" , main="Autocovariance plot : dd2.ts")
# Warning message:
#   In plot.xy(xy, type, ...) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# > (al=acf(dd1.ts))
# 
# Autocorrelations of series ‘dd1.ts’, by lag
# 
# 0.00   0.25   0.50   0.75   1.00   1.25   1.50   1.75   2.00   2.25   2.50   2.75   3.00   3.25 
# 1.000 -0.330 -0.241  0.095  0.005  0.308 -0.360 -0.071  0.062  0.234 -0.126 -0.164  0.212 -0.149 
# Warning messages:
#   1: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# 2: In doTryCatch(return(expr), name, parentenv, handler) :
#   플랏 타입 'covariance'은 첫번째 문자에서 잘려질 것입니다
# > (a2=acf(dd1.ts, type = "covariance"))
# 
# Autocovariances of series ‘dd1.ts’, by lag
# 
# 0.00    0.25    0.50    0.75    1.00    1.25    1.50    1.75    2.00    2.25    2.50    2.75    3.00    3.25 
# 8078.8 -2664.5 -1950.2   767.5    39.9  2489.8 -2908.7  -574.5   501.1  1890.3 -1020.7 -1327.7  1712.7 -1203.4 

##########################################################################################################################################