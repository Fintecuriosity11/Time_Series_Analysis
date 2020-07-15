##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### "Trivariate Time Series Plots" 작성 사례

# R의 내장 Database에 있는 "Lynx Trappings" (캐나다에 야생 시라소니의 개체수 조사)
# 시계열 자료를 대상으로, 이를 log 변환을 한 다음, 3개의 Time Lag에 따른 "Trivariate Time Series Plots 작성"

.libPaths("C://Users//yjang//R")                                                                # 저장 디렉토리 및 lib 경로 설정.


install.packages("tsDyn")

library(tsDyn)
head(log(lynx),5)

autopairs(log(lynx),type = "levels")


# lags 가 사용되지 않은 인자라고 함.

# autopairs(log(lynx), lags=0:1, type = "levels")
# autopairs(log(lynx), lags=0:2, type = "levels")
# autopairs(log(lynx), lags=1:2, type = "levels")



autopairs(log(lynx), type="persp")
autopairs(log(lynx), type="image")
autopairs(log(lynx), type="points")


# 분석결과:  3개의 Time Lag 별로 구성되는 Trivariate Plots은 4개 Type으로 작성됨.

graphics.off()                                                                                         # 그래프를 지워주는 함수.


############################################################결과값(print)#################################################################


# > library(tsDyn)
# > head(log(lynx),5)
# Time Series:
#   Start = 1821 
# End = 1825 
# Frequency = 1 
# [1] 5.594711 5.771441 6.371612 6.769642 7.296413
# > autopairs(log(lynx), lags=0:1, type="levels")
# Error in autopairs(log(lynx), lags = 0:1, type = "levels") : 
#   사용되지 않은 인자 (lags = 0:1)
# > autopairs(log(lynx), lag = 0:1, type="levels")
# Error in quantile.default(est, opt$props/100) : 
#   missing values and NaN's not allowed if 'na.rm' is FALSE
# > autopairs(log(lynx), lags=0:2, type="levels")
# Error in autopairs(log(lynx), lags = 0:2, type = "levels") : 
#   사용되지 않은 인자 (lags = 0:2)
# > autopairs(log(lynx), type="persp")
# > autopairs(log(lynx), type="image")
# > autopairs(log(lynx), type="points")
# 

# > install.packages("tsDyn")
# WARNING: Rtools is required to build R packages but is not currently installed. Please download and install the appropriate version of Rtools before proceeding:
#   
#   https://cran.rstudio.com/bin/windows/Rtools/
#   Installing package into ‘C:/Users/yjang/Documents/R/win-library/4.0’
# (as ‘lib’ is unspecified)
# URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/tsDyn_10-1.2.zip'을 시도합니다
# Content type 'application/zip' length 883185 bytes (862 KB)
# downloaded 862 KB
# 
# package ‘tsDyn’ successfully unpacked and MD5 sums checked
# 
# The downloaded binary packages are in
# C:\Users\yjang\AppData\Local\Temp\RtmpkRdJcD\downloaded_packages
# > library(tsDyn)
# Registered S3 method overwritten by 'quantmod':
#   method            from
# as.zoo.data.frame zoo 
# > head(log(lynx),5)
# Time Series:
#   Start = 1821 
# End = 1825 
# Frequency = 1 
# [1] 5.594711 5.771441 6.371612 6.769642 7.296413


##########################################################################################################################################