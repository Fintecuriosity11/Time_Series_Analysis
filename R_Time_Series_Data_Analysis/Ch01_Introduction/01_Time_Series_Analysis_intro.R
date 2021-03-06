##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인

##########################################################################################################################################


### 시계열 자료 분석.

# 시계열 자료를 분석하기 위하여 필요한 기본적인 프로그램은 "stats" package에 있는 "ts" 라는 프로그램이 존재.
# 이는 Matrix 형태의 자료를 R 프로그램의 시계열 자료로 변환하는 프로그램.

# R에서 시계열 자료를 구성하고 처리하기 위한 기본적인 프로그램인 "ts" 프로그램의 syntax는 다음과 같음.


.libPaths("C://Users//yjang//R")    # 저장 디렉토리 및 lib 경로 설정.

help(ts)

ts(1:10,frequency = 4, start = c(2001,2))   # 자료는 1부터 10까지,
                                            # 1년, 4로 나눈 분기 자료, 그러므로 frequency 주기는 4가 됨, 1/4,2/4... 분기 형식.
                                            # 시작시간 2001년 2분기 기준
                                            # 종료시간은 자료의 마지막.  
is.ts(x)

############################################################결과값(print)#################################################################

# > ts(1:10,frequency = 4, start = c(2001,2))

# Qtr1 Qtr2 Qtr3 Qtr4
# 2001         1    2    3
# 2002    4    5    6    7
# 2003    8    9   10     

##########################################################################################################################################

