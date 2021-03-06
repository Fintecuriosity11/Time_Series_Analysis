##########################################################################################################################################

#(주의) ->  순차적으로 코드를 실행하는 것을 권함!

#에러 발생 시 github Time_Series_Analysis/R_Time_Series_Data_Analysis 경로에 issue를 남기면 확인

##########################################################################################################################################


### Time Lag의 처리.

# 시계열 자료분석에서 중요한 요소의 하나는 Time Lag.

# 이는 시간 지연 또는 시차라고 불림.
# 예를 들어서 어떤 특정한 활동에 있어서 어떤 자극이 주어졌을 때, 이에 대한 반응이 나타나기까지의 시간적 지체를 나타낼 때  적용.

# 시계열 자료의 시간지체는, 특정한 시점의 시간 t를 기준으로 하였을 경우, 
# yt-1을 yt의 1차 Lag, yt-2을 yt의 2차, yt-k을 yt의 K차 Lag라고 지칭.

# Time lag를 처리하는 "lag" 프로그램이 있음.




dd.ts                                             # 입력된 자료의 출력 (yt).

dda.ts = lag(dd.ts, k=2)                          # yt의 2차 Lag,  

dda.ts                                            # yt - 2

ddb.ts = lag(dd.ts, k=-3)                         # yt의 -3차 Lag, 

ddb.ts                                            # yt + 3


graphics.off()                                                      # 그래프 지워주는 함수.

############################################################결과값(print)#################################################################

# # # > dd.ts
# Qtr1 Qtr2 Qtr3 Qtr4
# 2006 1342 1442 1252 1343
# 2007 1425 1362 1456 1272
# 2008 1243 1359 1412 1253
# 2009 1201 1478 1322 1406
# 2010 1254 1289 1497 1208
# > dda.ts = lag(dd.ts, k=2)                          # yt의 2차 Lag,  
# > 
#   > dda.ts                                            # yt - 2
# Qtr1 Qtr2 Qtr3 Qtr4
# 2005           1342 1442
# 2006 1252 1343 1425 1362
# 2007 1456 1272 1243 1359
# 2008 1412 1253 1201 1478
# 2009 1322 1406 1254 1289
# 2010 1497 1208          
# > 
#   > ddb.ts = lag(dd.ts, k=-3)                         # yt의 -3차 Lag, 
# > 
#   > ddb.ts                                            # yt + 3
# Qtr1 Qtr2 Qtr3 Qtr4
# 2006                1342
# 2007 1442 1252 1343 1425
# 2008 1362 1456 1272 1243
# 2009 1359 1412 1253 1201
# 2010 1478 1322 1406 1254
# 2011 1289 1497 1208     


##########################################################################################################################################