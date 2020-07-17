##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### 무작위성 검정에 대한 분석사례: Randomness Test- Runs Test

# 시계열 자료의 무작위성 검정은 비모수 분석기법의 하나인 Runs Test 적용.
# Runs Test는 시계열 자료의 중위값을 기분으로 조사값이 중위값보다 크거나 작은 경우를 파악하여 독립오차항 유무 및 추세를 파악.

# 분석자료: 우연변동의 시계열(dd1) 및 계절, 추세변동의 시계열(dd4)


library(forecast)
library(tsDyn)
library(tseries)


# dd2 = matrix(c(1142, 1242, 1452, 1543,  1125, 1262, 1456,1572,                                          # 계절변동 시계열자료(dd2)
#                1143, 1259, 1462, 1553,  1121, 1258, 1472, 1546,
#                1154, 1249, 1477, 1548))
# 
# 
# dd2.ts = ts(data=dd1, start=c(2006,1), frequency=4)                                                    # 4 분기 설정해서 display.

# dd2.ts

(xx1 = factor(ifelse(dd1>=median(dd1),1,0)))                                                             # 우연변동 자료변환. 
                                                                                                         # 중앙값보다 작으면 0 크면 1.

(xx4 = factor(ifelse(dd4>=median(dd4),1,0)))                                                             # 추세변동 자료변환. 
                                                                                                         # 중앙값보다 작으면 0 크면 1.  



runs.test(xx1, a="less")                                                                                 # 우연변동 Runs Test
                                                                                                         # "less" - trend


runs.test(xx4, a="less")                                                                                 # 추세변동 Runs Test
                                                                                                         # "less" - trend

graphics.off()                                                                                          # 그래프를 지워주는 함수.


# Runs Test 검정결과
# 입력자료는 Runs Test 입력조건에 맞추어 조건자료 값이 조사자료 Median 자료보다 작으면 0, 크면 1로 변환.
# 변환된 자료는 "factor : 0,1의 Level을 나타내는 변수로 설정.

# 분석결과, 우연변동 시계열 자료 dd1은 Standard Normal= 0.9189, p=0.8209로서, 자료가 한쪽으로 치우치지
# 않고 무작위성이 있다는 귀무가설을 기각할 수 없는 것으로 판단.

# 계절, 추세변동 시계열 자료 dd4는 Standard Normal = -1.3784, p=0.084로서, 시계열 자료는 한쪽으로
# (α = 0.05 < p = 0.08 < α = 0.1 )
# 치우치지 않고 무작위성이 있다는 귀무가설을 기각할 수 없으나 무작위성에는 다소 문제가 있는 것으로 판단.


############################################################결과값(print)#################################################################

# # # > library(forecast)
# > library(tsDyn)
# > library(tseries)

# > (xx1 = factor(ifelse(dd1>=median(dd1),1,0)))                                                             # 우연변동 자료변환. 
# [1] 0 1 0 1 1 1 1 0 0 1 1 0 0 1 0 1 0 0 1 0
# Levels: 0 1
# > (xx4 = factor(ifelse(dd4>=median(dd4),1,0)))                                                             # 추세변동 자료변환. 
# [1] 0 0 0 0 0 0 1 1 0 0 1 1 0 1 1 1 0 1 1 1
# Levels: 0 1
# > runs.test(xx1, a="less")                                                                                 # 우연변동 Runs Test
# 
# Runs Test
# 
# data:  xx1
# Standard Normal = 0.91894, p-value = 0.8209
# alternative hypothesis: less
# 
# >                                                                                                          # "less" - trend
#   > runs.test(xx4, a="less")                                                                                 # 추세변동 Runs Test
# 
# Runs Test
# 
# data:  xx4
# Standard Normal = -1.3784, p-value = 0.08404
# alternative hypothesis: less
# 
# >                                                                                                          # "less" - trend

##########################################################################################################################################