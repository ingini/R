# Conditional Syntax
a <- 10
if(is.integer(a)){
  print("X is an Integer")
} 
a1 <- 10L
if(is.integer(a1)){
  print("X is an Integer")
} 
a2 <- c("What","is","truth")
if("Truth" %in% a2){
  print("True")
} else {
  print("False") 
}
a3 <- switch(3,"One","Two","Three","Four")
a3
# Code Complete(코드 완전정복)
# 컴퓨터 역사.... 빌게이츠 생각속도

# Loop
a4 <- c("Hello", "R loop")
cnt <- 2
repeat {
  print(a4)
  cnt <- cnt + 1
  print(cnt)
  if(cnt > 5) {
    break;
  }
}

a5 <- c("Hello", "R loop")
cnt <- 2
while(cnt < 7){
  print(a5)
  cnt = cnt + 1
}

a6 <- LETTERS[1:4]
a7 <- letters[1:4]

for(i in a6){
  print(i)
}

# function -> 함수, 프로시져(procedure), 메소드(method)
# -> (black box, swap...) -> 반복적인 작업

#built-in functions
#print()
#select()
#filter()
print(seq(1,10))

#user-defined functions
myfunc <- function(a) {
  for(i in 1:a){
    b <- i*2
    print(b)
  }
}

myfunc(10)

myfunc2 <- function(){
  for(i in 1:5){
    print(i * 2)
  }
}
myfunc2()

myfunc3 <- function(a,b){
  r <- a + b
  print(r)
}
myfunc3(1,2)
myfunc3(a=1,b=2)
myfunc3(b=2,a=1)
myfunc3(1, b=3)

myfunc4 <- function(a=0, b=0){
  r <- a + b
  print(r)
}

myfunc4(a=1)
myfunc4(b=2)
myfunc5 <- function(a){c <- a}
myfunc5(1)

df <- read.csv("exam.csv")
str(df)

df %>% 
  select(id, class, math) %>%
  filter(class == 1) %>%
  arrange
df %>%
  arrange(class, desc(id)) %>%
  head(5)
library(magrittr)
df %>%
  arrange(class, desc(id)) %>%
  mutate(total = math + english + science,
         mean = (math + english + science)/3)
# group_by
df %>%
  group_by(class) %>%
  summarise(mean_math = mean(math),
            median_math = median(math),
            sum_math = sum(math),
            count_math = n())


mpg <- as.data.frame(ggplot2::mpg)
str(mpg)

select(mpg, class)
mpg %>% 
  group_by(class) %>%
  summarise(mean_cty=mean(cty))

# 어떤 회사(manufacturer)의 자동차 hwy가 가장 높은 것을 
# 알아보려고 한다. hwy평균 가장 높은 회사 5곳을 출력하시오.
names(mpg)
mpg%>%
  group_by(displ <= 4) %>%
  group_by(displ >= 5) %>%
  filter(displ <= 4 | displ >= 5) %>%
  summarise(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy))

mpg %>% 
  select(manufacturer,cty) %>% 
  filter(manufacturer == 'toyota' | manufacturer == 'audi') %>%
  group_by(manufacturer) %>% 
  summarise(mean_cty = mean(cty)) %>% 
  arrange(desc(mean_cty))

mpg %>%
  filter(manufacturer == 'chevrolet' | manufacturer == 'ford' | manufacturer == 'honda') %>%
  group_by(manufacturer) %>%
  summarise(mean_hwy = mean(hwy))
  
#4.mpg 데이터 복사본을 만들고, 
#cty와 hwy를 더한 '합산 연비 변수'를 추가하세요.

mpg_copy <- mpg %>%
  mutate(totaly = cty + hwy)
mpg_copy
#5. 앞에서 만든 '합산 연비 변수'를 2로 나눠 '평균 연비 변수'를 추가세요.
mpg_copy <- mpg %>%
  mutate(totaly = cty + hwy, avgy = totaly/2 )
mpg_copy
# 6. '평균 연비 변수'가 가장 높은 자동차 3종의 데이터를 출력하세요.
mpg_copy <- mpg %>%
  mutate(totaly = cty + hwy, avgy = totaly/2 ) %>%
  arrange(desc(avgy)) %>%
  head(3)
mpg_copy

#7. 어떤 회사에서 "compact"(경차) 차종을 #
#가장 많이 생산하는지 알아보려고 합니다. 
#각 회사별 "compact" 차종 수를 내림차순으로 
#정렬해 출력하세요.
mpg %>%
  filter(class=='compact') %>%
  group_by(manufacturer) %>%
  summarise('count' = n()) %>%
  arrange(desc(count))

# 
filter(select(mpg,manufacturer)
              , manufacturer == c('audi','toyota'))

filter(select(mpg,manufacturer), manufacturer == 'audi' | 
         manufacturer == 'toyota')

select(mpg,manufacturer)




