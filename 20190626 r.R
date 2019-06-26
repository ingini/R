df <- read.csv('income.csv',
               header = TRUE,
               stringsAsFactors = FALSE)
str(df)
df
# plyr(x)
# dplyr
options(repos =c(CRAN = 'https://cloud.r-project.org'))
install.packages('dplyr', repos = 'https://cloud.r-project.org')

df
sample_n(df,3)
sample_frac(df,0.1)
df2 <- distinct(df)
df2
str(df)
df <- read.csv('income.csv',
               header = TRUE,
               stringsAsFactors = TRUE)
str(df)
# select -> column,
select(df, Index,State:Y2008)
select(df,Index,State)
a <- 1:2
a
select(df,State,-State)
select(df, -c(Index,State))
select(df, starts_with('Y'))
select(df, -starts_with('Y'))

select(df, State, everything())

df2 <- rename(df, Index2=Index)
names(df2)

#filter
filter(df,Index=='A')
filter(df, Index %in% 'A')
filter(df, Index %in% c('A','C'))

filter(df, Index %in% c('A','C') &  Y2002 >= 1600000)
filter(df, !Index %in% c('A','C'))

# 010-1234-1234 -> [0-9][0-9][0-9] --> ����ǥ����
# regular expression

filter(df, grepl('Ar',State))

summarise(df, Y2015_mean= mean(Y2015),
          Y2015_median = median(Y2015))

#arrange
arrange(df,Index)
df3 <- select(df,Index)
df4 <- arrange(df3,Index)
head(df4)
df5 <- arrange(df3, desc(Index))
df5

1 1
1 2
1 1
1 2
2 1
3 2
df6 <- select(df, Index, State)
df6
df7 <- arrange(df6, desc(Index),State)
df7

# group by

group_by(df, Index)
View(df)
install.packages("viewshed3d")

head(df,3)
tail(df,3)


summarise_at(group_by(df,Index),vars(Y2011,Y2012,Y2013))


# Pipe Operator %>%
# magrittr

df %>% select(Index, State)
df_temp = sample_n(select(df,Index, State),10)
df_temp

df %>% select(Index,State) %>% sample_n(10)

df10 <- read.csv('exam.csv')
str(df10)

filter(df10, class ==1)
df10 %>% filter(class ==1)

filter(select(df10, class, math, english),class==1)

df10 %>% select(class, math, english) %>% filter(class==1) %>% arrange(desc(math))

df_temp <- df10 %>%
  filter(class %in% c(1,3,5)) %>% 
  arrange(desc(english))

df_temp

# conditional
a <- 10
if(is.integer(a)){
  print('X is an Integer')
  }

a1 <- 10L
if(is.integer(a1)){
  print('X is an Integer')
}

a2 <- c('what','is','truth')
if('Truth' %in% a2){
  print('True')
} else {
  print('False')
}

a3 <- switch (3,'One','Two','Three','Four')
a3


# code Complete
# ��ǻ�� ����

# Loop (�ݺ�) 
a4 <- c('Hello','R loop')
cnt <- 2
repeat {
  print(a4)
  cnt <- cnt+1
  print(cnt)
  if(cnt > 10){
    break;
  }
}
a5 <- c('Hell','the class')
cnt <- 1
while (cnt < 7){
  print(a5)
  cnt = cnt + 1
}

a6 <- LETTERS[1:4]
a7 <- letters[1:4]
for (i in a6) {
  print(i)
}

# function -> �Լ�, ���ν���(procedure), �޼ҵ�
# -> (black box, swap ...) -> (�ݺ����� �۾�)

# built - in -
# print()
# select()
# filter()
print(seq(1,10))


myfunc <- function(a) {
  for( i in 1:a){
    b <- i*2
    print(b)
    }
}

myfunc(10)

myfunc2 <- function(){
  for(i in 1:5){
    print(i* 2)
  }
}
myfunc2()

myfunc3 <- function(a,b){
  r<- a+b
  print(r)
}
myfunc3(1,2)
myfunc3(a=1,b=2)

myfunc3(3,2)

myfunc4 <- function(a=0,b=0){
  r <- a*b
  print(r)
}
myfunc4(a=1)

df <- read.csv('exam.csv')
str(df)

df %>% 
  select(id, class, math) %>%
  filter(class == 1) %>%
  arrange(desc(id))

df %>%
  arrange(class, desc(id)) %>%
  mutate(total = math + english + science,
         mean= (math + english + science)/3)

int(df[mean])

df %>% 
  group_by(class) %>%
  summarise(mean_math = mean(math),
            median_math = median(math),
            sum_math = sum(math),
            count_math = n())

mpg <- as.data.frame(ggplot::mpg)
str(mpg)

select(mpg,class)
mpg %>%
  group_by(class) %>%
  summarise(mean_cty = mean(cty))

#� ȸ���� �ڵ��� hwy �� ���� �������� ������ hwy ��� ���� ���� ȸ�� ������ ����Ͻÿ�

rank(mpg('hwy'))

mpg %>%
  group_by(class) %>%
  summarise(mean_hwy = mean(hwy),
            arrange(mean_hwy))
  
mpg            

# 1. �ڵ��� ��ⷮ�� ���� ���ӵ��� ���� �ٸ��� �˾ƺ������Ѵ�
# displ(��ⷮ)�� 4������ �ڵ����� 5�̻��� �ڵ�����
# � �ڵ����� hwy(����)�� ��������� �� ������
mpg %>%
  group_by(displ <= 4 ) %>%
  group_by(displ >= 5) %>%
  filter(displ <= 4 | displ >= 5) %>%
  summarise(hwy_mean = mean(hwy)) %>%
  arrange(desc(hwy_mean))
  
  
       
# 2. �ڵ��� ���� ȸ�翡 ���� ���� ���� �ٸ��� �˾ƺ����� �մϴ�.
# "audi"��  "toyota" �� ��� manufacturer(�ڵ��� ���� ȸ��)�� 
# cty(���� ����)�� ��������� �� ������ �˾ƺ�����.
mpg %>%
  filter(manufacturer == c('audi','toyota')) %>%
  group_by(manufacturer) %>%
  summarise(cty_mean = mean(cty)) %>%
  arrange(desc(cty_mean))
           

# 3. "chevrolet", "ford", "honda" �ڵ����� ���ӵ��� ���� �����
# �˾ƺ����� �մϴ�. �� ȸ����� �ڵ����� ������ �� hwy
# ��ü ����� ���غ�����.
a <- filter(mpg, manufacturer == c('chevrolet','honda','ford'))
mpg %>%
  filter(manufacturer == c('chevrolet','honda','ford')) %>%
  group_by(manufacturer) %>%
  summarise(hwy_mean = mean(hwy)) %>%
  arrange(hwy_mean)
  

# 4.mpg ������ ���纻�� �����, cty�� hwy�� ���� 
# '�ջ� ���� ����'�� �߰��ϼ���.
mpg_copy <- mpg
mpg_copy
mpg_copy %>%
  mutate(sum_ch = cty + hwy)

# 5. �տ��� ���� '�ջ� ���� ����'�� 2�� ���� '��� ���� ����'�� �߰�����.
mpg2 <- mpg_copy %>%
  mutate(sum_ch = cty + hwy) %>%
  mutate(mean_ch = sum_ch / 2)
mpg2

# 6. '��� ���� ����'�� ���� ���� �ڵ��� 3���� �����͸� ����ϼ���

 mpg3 <- mpg2 %>%
  group_by(manufacturer) %>%
  arrange(desc(mean_ch)) %>%
  head(3)
mpg3

# 7. 1~3�� ������ �ذ��� �� �ִ� �ϳ��� ����� dplyr ������ ����� ����ϼ���. 
# �����ʹ� ���纻 ��� mpg ������ �̿��ϼ���.
mpg %>%
  filter(class =='compact') %>%
  group_by(manufacturer) %>%
  summarise('count' = n()) %>%
  arrange(desc(count))

# 8. mpg �����ʹ� 11�� ������ �����Ǿ� �ֽ��ϴ�.
# �� �� �Ϻθ� �����ؼ� �м��� Ȱ���Ϸ��� �մϴ�. 
# mpg �����Ϳ��� class(�ڵ��� ����), cty(���� ����) ������ ������ ���ο� �����͸� ���弼��.
# ���� ���� �������� �Ϻθ� ����ؼ� �� �����θ� �����Ǿ� �ִ��� Ȯ���ϼ���.




# 9. �ڵ��� ������ ���� ���� ���� �ٸ��� �˾ƺ����� �մϴ�.
# �տ��� ������ �����͸� �̿��ؼ� class(�ڵ��� ����)�� "suv"�� �ڵ����� "compact"�� 
# �ڵ��� �� � �ڵ����� cty(���� ����)�� �� ������ �˾ƺ�����.



# 10. � ȸ�翡�� "compact"(����) ������ ���� ���� �����ϴ��� �˾ƺ����� �մϴ�.
# �� ȸ�纰 "compact" ���� ���� ������������ ������ ����ϼ���.