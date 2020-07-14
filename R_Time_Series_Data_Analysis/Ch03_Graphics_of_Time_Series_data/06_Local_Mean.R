##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### Local Mean에 의한 적용사례("wapply"의 사용)

.libPaths("C://Users//yjang//R")                                              # 저장 디렉토리 및 lib 경로 설정.

install.packages("gplots")

library(gplots)

x<-1:1000

y<- rnorm(1000, mean = 1, sd = 1 + x/1000)

(ww = wapply(x,y, fun = mean))

plot(x,y, main = "Wapply Plot by Local Mean")

lines(wapply(x,y, fun = mean), col='red', lwd=2)

CL<- function(x,sd) mean(x) + sd*sqrt(var(x))

lines(wapply(x,y, CL, sd = 1), col="blue", lwd=2)
lines(wapply(x,y, CL, sd = -1), col="blue", lwd=2)
lines(wapply(x,y, CL, sd = 2), col="green", lwd=2)
lines(wapply(x,y, CL, sd = -2), col="green", lwd=2)
lines(wapply(x,y, CL, sd = 0.5), col="yellow", lwd=2)
lines(wapply(x,y, CL, sd = 0.5), col="yellow", lwd=2)



legend("bottomleft",c("m +/- 2d", "m +/- d", "Local Mean"), col=c(3,4,2), lwd = c(2,2,2), cex = 0.6)


graphics.off()                                                                                         # 그래프를 지워주는 함수.


# 분석자료: x = 1에서 1000
#           y = 정규분포의 난수 1000개

# local mean: 1000개의 시계열 자료. (20개씩 총 50개 평균산정)

# mean +/- 2sd, mean +/- sd 그래프 직접 돌려보고 참조.


############################################################(패키지 설치확인)#############################################################

# 패키지 설치 확인.

# > [Workspace loaded from ~/.RData]

# > .libPaths("C://Users//yjang//R")                                              # 저장 디렉토리 및 lib 경로 설정.
# > install.packages("gplots")
# Installing package into ‘C:/Users/yjang/R’
# (as ‘lib’ is unspecified)
# also installing the dependencies ‘gtools’, ‘gdata’, ‘caTools’
#                                                     
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/gtools_3.8.2.zip'
# Content type 'application/zip' length 336236 bytes (328 KB)
# downloaded 328 KB
#                                                     
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/gdata_2.18.0.zip'
# Content type 'application/zip' length 1262939 bytes (1.2 MB)
# downloaded 1.2 MB
#                                                     
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/caTools_1.18.0.zip'
# Content type 'application/zip' length 317325 bytes (309 KB)
# downloaded 309 KB
#                                                     
# trying URL 'https://cran.rstudio.com/bin/windows/contrib/4.0/gplots_3.0.4.zip'
# Content type 'application/zip' length 594561 bytes (580 KB)
# downloaded 580 KB
#                                                     
# package ‘gtools’ successfully unpacked and MD5 sums checked
# package ‘gdata’ successfully unpacked and MD5 sums checked
# package ‘caTools’ successfully unpacked and MD5 sums checked
# package ‘gplots’ successfully unpacked and MD5 sums checked
#                                                     
# The downloaded binary packages are in
# C:\Users\yjang\AppData\Local\Temp\RtmpecTDoA\downloaded_packages
# > library(gplots)
#                                                     
# 다음의 패키지를 부착합니다: ‘gplots’
#                                                     
# The following object is masked from ‘package:stats’:
#                                                       
# lowess
#                                                     
# Warning message:
# 패키지 ‘gplots’는 R 버전 4.0.2에서 작성되었습니다 


##########################################################################################################################################


############################################################결과값(print)#################################################################

# > x<-1:1000
# > 
#   > y<- rnorm(1000, mean = 1, sd = 1 + x/1000)
# > (ww = wapply(x,y, fun = mean))
# $x
# [1]    1.00000   21.38776   41.77551   62.16327   82.55102  102.93878  123.32653  143.71429  164.10204  184.48980  204.87755  225.26531  245.65306  266.04082  286.42857
# [16]  306.81633  327.20408  347.59184  367.97959  388.36735  408.75510  429.14286  449.53061  469.91837  490.30612  510.69388  531.08163  551.46939  571.85714  592.24490
# [31]  612.63265  633.02041  653.40816  673.79592  694.18367  714.57143  734.95918  755.34694  775.73469  796.12245  816.51020  836.89796  857.28571  877.67347  898.06122
# [46]  918.44898  938.83673  959.22449  979.61224 1000.00000
# 
# $y
# [1] 0.8051851 0.8085230 0.7742675 0.8004762 0.7821458 0.8562122 0.9336443 1.0291025 0.9916440 1.0084393 1.0408993 0.9670525 1.0001201 1.0148940 1.0161145 1.1778599
# [17] 1.0379895 1.0062035 0.8882396 0.9242393 0.9531147 0.9054506 0.9751269 1.0343840 0.9064428 0.7449493 0.8236986 0.7338380 0.9070530 1.0015574 1.0462873 1.2378862
# [33] 1.4689473 1.3219636 1.2463219 1.0706034 0.8615882 0.6831820 0.7861382 0.9496923 1.2317026 1.1450731 1.2528040 1.0406034 1.0418591 1.0636033 1.0802769 0.9391122
# [49] 0.9048099 0.8752796
# 
# > plot(x,y, main = "Wapply Plot by Local Mean")

# > lines(wapply(x,y, fun = mean), col='red', lwd=2)

# > CL<- function(x,sd) mean(x) + sd*sqrt(var(x))

# > lines(wapply(x,y, CL, sd = 1), col="blue", lwd=2)

# > lines(wapply(x,y, CL, sd = 2), col="green", lwd=2)


# > lines(wapply(x,y, CL, sd = 0.5), col="yellow", lwd=2)

# > lines(wapply(x,y, CL, sd = 0.5), col="yellow", lwd=2)

# > lines(wapply(x,y, CL, sd = -1), col="blue", lwd=2)

# > lines(wapply(x,y, CL, sd = -2), col="green", lwd=2)

# > legend("bottomleft",c("m +/- 2d", "m +/- d", "Local Mean"), col=c(3,4,2), lwd = c(2,2,2), cex = 0.6)

# > graphics.off()   





##########################################################################################################################################