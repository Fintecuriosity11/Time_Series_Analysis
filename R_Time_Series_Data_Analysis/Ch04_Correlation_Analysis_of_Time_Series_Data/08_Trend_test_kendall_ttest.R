##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 추세검정에 관한 분석 사례: Trend Test-Kendall t Tes

# 시계열 자료의 추세여부에 대한 정상성 검정을 위한 분석방법의 하나로, 비모수 통계분석 기법인 Kendall의 상관계수 t test 적용.
# kendall의 상관계수 t test는 시간과 조사자료의 순위에 대한 상관관계를 토대로 추세를 파악하는 데 적용.
# 분석 사례로는 앞에서 수행한 우연 변동 시계열 자료(dd1)와 계절변동 시계열 자료(dd4)를 대상으로 수행.

# 자료의 조정은 정상적인 자료의 순위가 아니라, 해당 자료보다 큰 조사자료의 수를 산정하여 설정.
# 하향추세인 경우 해당 자료보다 작은 조사자료 수를 산정.



library(forecast)
library(tsDyn)
library(tseries)

ddd1=rep(0,20)

for(i in 1:20) {pp=qq=0
  kk=dd1[i]
  for (j in i+1:20){
    ifelse (kk<=dd1[j], pp<-pp+1, qq<-qq+1)}
  ddd1[i]=pp }


ddd1

ddd4=rep(0,20)

for(i in 1:20) {pp=qq=0
kk=dd4[i]
for (j in i+1:20){
  ifelse (kk<=dd4[j], pp<-pp+1, qq<-qq+1)}
ddd4[i]=pp }

ddd4


tt = seq(1:20)

cor.test(tt, ddd1, method = c("kendall"), exact = F)

cor.test(tt, ddd4, method = c("kendall"), exact = F)



graphics.off()                                                                                          # 그래프를 지워주는 함수.


# trend test 검정 결과

# 입력 자료는 시간 "tt"와 조사자료의 순위 "ddd1", "ddd4"로 구성
# 순위는 반복작업을 수행하는 "for" 명령어를 이용하여 구성.
# 시간과 조사자료 순위에 대한 상관분석 결과, 우연변동의 시계열 자료는 t=-0.59, p=0.00로서 시간과 순위가 독립이라는 귀무가설 기각.
# 이에 따라서 시계열 자료에 추세가 없다고 말할 수 있음.
# 계절, 추세변동자료는 t=-0.86, p=0.0로서 시간과 순위가 독립이라는 귀무가설을 기각하며, 시계열 자료에 추세가 없다고 말할 수 있음.

# 이는 계절적 변동이 추세변동보다 크기 때문이며, 계절변동을 제거하면 추세변동은 존재하는 것으로 분석석


############################################################결과값(print)#################################################################

# # #>

# library(forecast)

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
# > ddd1=rep(0,20)
# > 
#   > for(i in 1:20) {pp=qq=0
#   +   kk=dd1[i]
#   +   for (j in i+1:20){
#     +     ifelse (kk<=dd1[j], pp<-pp+1, qq<-qq+1)}
#   +   ddd1[i]=pp }
# > 
#   > 
#   > ddd1
# [1] 10  3 14  8  3  5  2  7  9  4  2  6  7  1  2  1  2  1  0  0
# > 
#   > ddd4=rep(0,20)
# > 
#   > for(i in 1:20) {pp=qq=0
#   + kk=dd4[i]
#   + for (j in i+1:20){
#     +   ifelse (kk<=dd4[j], pp<-pp+1, qq<-qq+1)}
#   + ddd4[i]=pp }
# > 
#   > ddd4
# [1] 19 17 13 11 15 13  9  5 11  9  5  4  7  5  3  2  3  2  1  0
# > 
#   > 
#   > tt = seq(1:20)
# > 
#   > cor.test(tt, ddd1, method = c("kendall"), exact = F)
# 
# Kendall's rank correlation tau
# 
# data:  tt and ddd1
# z = -3.598, p-value = 0.0003206
# alternative hypothesis: true tau is not equal to 0
# sample estimates:
#        tau 
# -0.5981442 
# 
# > 
# > cor.test(tt, ddd4, method = c("kendall"), exact = F)
# 
# 	Kendall's rank correlation tau
# 
# data:  tt and ddd4
# z = -5.2149, p-value = 1.839e-07
# alternative hypothesis: true tau is not equal to 0
# sample estimates:
#   tau 
# -0.860414 

##########################################################################################################################################