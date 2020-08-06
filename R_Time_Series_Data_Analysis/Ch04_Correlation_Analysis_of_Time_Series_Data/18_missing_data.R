##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


###  결측자료(Missing Data)의 처리 및 분석사례.

# R 패키지에서 " mice: Multivariate Imputation by Chained Equations"의 프로그램을 이용한 결측자료 처리의 분석사례는 다음과 같음.

# 1) 결측자료 (Missing Data) 종류 : 결측자료는 다음과 같이 구분

# - MCAR (Missing Completely at Random) : 결측값이 완전히 임의로 정해지는 경우로서, 분석에 영향을 주지 않음. 
# 실제로 이러한 경우는 거의 없음


# - MAR (Missing at Random): 결측값이 특정변수에 따라 결정되는 경우로써, 교육수즌에 따라 소득 수준이 영향을 받음.
# 소득액이 결측된 사례

# MNAR(Missing at not Random): 결측값이 결측된 이유와 관련이 있는 경우로서, 소득수준이 높을수록 소득액 응답을 기피하는 사례



# 2) 결측자료의 조치: 결측자료는 그게 다음과 같은 방법으로 조치.

# Listwise Deletion***** :  결측값이 포함된 자료를 분석에서 제외.

# Pairwise Deletion***** :  결측값이 포함된 자료를 특정분석에서만 제외.

# 단일대입법 (Single Imputation): MAR의 경우, 평균, 회귀분석 등으로 대입.

# 다중대입법 (Multiple Imputation): 몬테카를로 Simulation을 이용하여 여러(default, 5개) 자료를 구성한 다음 , 하나의 자료로 통합


# 3) 분석자료 분석

install.packages("mice")

library(forecast)
library(tsDyn)
library(tseries)
library(mice)


x=c(22,34, NA, 36,28, 35, 46, 42, 39,25, 36, 25, 38, NA, 37)                                            # X자료
t=seq(1:15)                                                                                             # t 자료

zz=mice(matrix(c(x,t), nc=2))

t(complete(zz))

graphics.off()                                                                                          # 그래프를 지워주는 함수.




# 추정결과

# 결측자료 추정결과는 다음과 같음. 분석결과에서 zz는 다중대입법에 따라 5개의 시뮬레이션 자료이며, 결측값은 36, 25 로 추정정

############################################################결과값(print)#################################################################

# [Workspace loaded from ~/.RData]


# # > library(forecast)
# > library(tsDyn)
# > library(tseries)

# > install.packages("mice")

# WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
#   
#   https://cran.rstudio.com/bin/windows/Rtools/
#   Installing package into ‘C:/Users/yjang/Documents/R/win-library/4.0’
# (as ‘lib’ is unspecified)
# 
# There is a binary version available but the source version is later:
#   binary source needs_compilation
# mice 3.10.0 3.11.0              TRUE
# 
# Binaries will be installed
# URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/mice_3.10.0.zip'을 시도합니다
# Content type 'application/zip' length 1969734 bytes (1.9 MB)
# downloaded 1.9 MB
# 
# package ‘mice’ successfully unpacked and MD5 sums checked
# 
# The downloaded binary packages are in
# C:\Users\yjang\AppData\Local\Temp\Rtmpe47o1l\downloaded_packages
# > library(mice)
# 
# 다음의 패키지를 부착합니다: ‘mice’
# 
# The following objects are masked from ‘package:base’:
#   
#   cbind, rbind
# 
# > x=c(22,34, NA, 36,28, 35, 46, 42, 39,25, 36, 25, 38, NA, 37)                                            # X자료
# > t=seq(1:15)                                                                                             # t 자료
# > 
#   > zz=mice(matrix(c(x,t), nc=2))
# 
# iter imp variable
# 1   1  V1
# 1   2  V1
# 1   3  V1
# 1   4  V1
# 1   5  V1
# 2   1  V1
# 2   2  V1
# 2   3  V1
# 2   4  V1
# 2   5  V1
# 3   1  V1
# 3   2  V1
# 3   3  V1
# 3   4  V1
# 3   5  V1
# 4   1  V1
# 4   2  V1
# 4   3  V1
# 4   4  V1
# 4   5  V1
# 5   1  V1
# 5   2  V1
# 5   3  V1
# 5   4  V1
# 5   5  V1
# > 
#   > t(complete(zz))
# [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14] [,15]
# V1   22   34   28   36   28   35   46   42   39    25    36    25    38    39    37
# V2    1    2    3    4    5    6    7    8    9    10    11    12    13    14    15




##########################################################################################################################################