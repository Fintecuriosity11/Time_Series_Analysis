##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인

##########################################################################################################################################


### Box Cox 변환.

# 시계열 자료의 특수한 변환을 나타내는 방식.


.libPaths("C://Users//yjang//R")    # 저장 디렉토리 및 lib 경로 설정.

install.packages("forecast")


dd.ts                              # 입력 자료


lambda=BoxCox.lambda(dd.ts)
lambda

new=BoxCox(dd.ts,lambda)
new

ss=(ds.ts^lambda-1)/lambda>ss

InvBoxCox(new,lambda)



graphics.off()                                       # 그래프 지워주는 함수.

############################################################결과값(print)#################################################################



# 에러

# > library(forecast)
# Error: package or namespace load failed for ‘forecast’ in inDL(x, as.logical(local), as.logical(now), ...):
#   unable to load shared object 'C:/Users/yjang/R/Rcpp/libs/x64/Rcpp.dll':
#   LoadLibrary failure:  지정된 프로시저를 찾을 수 없습니다.
# In addition: Warning message:
#   패키지 ‘forecast’는 R 버전 4.0.2에서 작성되었습니다 


##########################################################################################################################################