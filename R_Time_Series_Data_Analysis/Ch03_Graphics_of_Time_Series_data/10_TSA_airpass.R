##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인


##########################################################################################################################################


### "Forecast"와 "ggplot" 이용한 그래프 작성 사례

# "TSA" 에 있는 자료를 대상으로 그래프 작성

# 분석자료: 항공여객, 금값, 노동시간, RV 차량 판매량을 대상.

install.packages("timeSeries")

install.packages("https://cran.r-project.org/src/contrib/Archive/TSA/TSA_1.2.1.tar.gz", repos = NULL, type="source")

# install.packages("https://cran.r-project.org/src/contrib/Archive/[패키지명]/[원하는 버전 파일명].tar.gz", repos = NULL, type="source")

# TSA package installation Error


library(timeSeries)
library(forecast)

data("airpass")
data

p<-autoplot(AirPassengers, main = "Airpassengers / Loess Line")
p<-p+geom_ribbon(aes(ymin=airpass-50, ymax=airpass+50), fill="lightblue")
p<-p+geom_line(aes(y=airpass)
p<-p+stat_smooth(method="loess". se=F, col="red")
p

graphics.off()                                                                                         # 그래프를 지워주는 함수.


############################################################결과값(print)#################################################################


# > 


##########################################################################################################################################