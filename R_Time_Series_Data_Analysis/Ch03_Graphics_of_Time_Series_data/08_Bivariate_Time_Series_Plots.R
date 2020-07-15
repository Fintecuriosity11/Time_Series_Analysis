##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### "Bivariate Time Series Plots" 분석 사례

# R의 내장 Database에 있는 "Lynx Trappings" (캐나다에 야생 시라소니의 개체수 조사)
# 시계열 자료를 대상으로, 2개의 Time Lag에 따른 "Bivariate Time Series Plots"를 작성.


.libPaths("C://Users//yjang//R")                                                                # 저장 디렉토리 및 lib 경로 설정.

install.packages("tsDyn")
install.packages("sm")

library(tsDyn)

(xx<-lynx)

autopairs(xx, type="levels")
autopairs(xx, type="persp")
autopairs(xx, type="image")
autopairs(xx, type="lines")
autopairs(xx, type="points")
autopairs(xx, type="regression")

# autopair가 패키지 문제로 안돌아감. 다시 확인 필요.
# levels를 수행하려면 추가 패키지 "sm" 설치 및 로딩 확인 요망.

graphics.off()                                                                                         # 그래프를 지워주는 함수.


############################################################(패키지 설치확인)#############################################################

# 패키지 설치 확인.

# > .libPaths("C://Users//yjang//R")                                              # 저장 디렉토리 및 lib 경로 설정.
# > install.packages("tsDyn")
# Installing package into ‘C:/Users/yjang/R’
# (as ‘lib’ is unspecified)
# also installing the dependencies ‘tmvnsim’, ‘deSolve’, ‘strucchange’, ‘sandwich’, ‘iterators’, ‘mnormt’, ‘tseriesChaos’, ‘vars’, ‘foreach’
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/tmvnsim_1.0-2.zip'
# Content type 'application/zip' length 36918 bytes (36 KB)
# downloaded 36 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/deSolve_1.28.zip'
# Content type 'application/zip' length 2973236 bytes (2.8 MB)
# downloaded 2.8 MB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/strucchange_1.5-2.zip'
# Content type 'application/zip' length 983946 bytes (960 KB)
# downloaded 960 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/sandwich_2.5-1.zip'
# Content type 'application/zip' length 1380858 bytes (1.3 MB)
# downloaded 1.3 MB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/iterators_1.0.12.zip'
# Content type 'application/zip' length 343699 bytes (335 KB)
# downloaded 335 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/mnormt_2.0.1.zip'
# Content type 'application/zip' length 193661 bytes (189 KB)
# downloaded 189 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/tseriesChaos_0.1-13.1.zip'
# Content type 'application/zip' length 158453 bytes (154 KB)
# downloaded 154 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/vars_1.5-3.zip'
# Content type 'application/zip' length 965830 bytes (943 KB)
# downloaded 943 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/foreach_1.5.0.zip'
# Content type 'application/zip' length 145883 bytes (142 KB)
# downloaded 142 KB
# 
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/tsDyn_10-1.2.zip'
# Content type 'application/zip' length 883185 bytes (862 KB)
# downloaded 862 KB
# 
# package ‘tmvnsim’ successfully unpacked and MD5 sums checked
# package ‘deSolve’ successfully unpacked and MD5 sums checked
# package ‘strucchange’ successfully unpacked and MD5 sums checked
# package ‘sandwich’ successfully unpacked and MD5 sums checked
# package ‘iterators’ successfully unpacked and MD5 sums checked
# package ‘mnormt’ successfully unpacked and MD5 sums checked
# package ‘tseriesChaos’ successfully unpacked and MD5 sums checked
# package ‘vars’ successfully unpacked and MD5 sums checked
# package ‘foreach’ successfully unpacked and MD5 sums checked
# package ‘tsDyn’ successfully unpacked and MD5 sums checked
# 
# The downloaded binary packages are in
# C:\Users\yjang\AppData\Local\Temp\RtmpecTDoA\downloaded_packages


##########################################################################################################################################

############################################################결과값(print)#################################################################

# # > library(tsDyn)
# Registered S3 method overwritten by 'quantmod':
#   method            from
# as.zoo.data.frame zoo 
# Error: package or namespace load failed for ‘tsDyn’ in inDL(x, as.logical(local), as.logical(now), ...):
#   unable to load shared object 'C:/Users/yjang/R/Rcpp/libs/x64/Rcpp.dll':
#   LoadLibrary failure:  지정된 프로시저를 찾을 수 없습니다.
# In addition: Warning message:
#   패키지 ‘tsDyn’는 R 버전 4.0.2에서 작성되었습니다 
# > (xx<-lynx)
# Time Series:
#   Start = 1821 
# End = 1934 
# Frequency = 1 
# [1]  269  321  585  871 1475 2821 3928 5943 4950 2577  523   98  184  279  409 2285 2685 3409 1824  409  151   45   68  213  546 1033 2129 2536  957  361  377  225  360
# [34]  731 1638 2725 2871 2119  684  299  236  245  552 1623 3311 6721 4254  687  255  473  358  784 1594 1676 2251 1426  756  299  201  229  469  736 2042 2811 4431 2511
# [67]  389   73   39   49   59  188  377 1292 4031 3495  587  105  153  387  758 1307 3465 6991 6313 3794 1836  345  382  808 1388 2713 3800 3091 2985 3790  674   81   80
# [100]  108  229  399 1132 2432 3574 2935 1537  529  485  662 1000 1590 2657 3396


# > graphics.off()   

##########################################################################################################################################