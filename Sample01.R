df <- read.csv("income.csv", 
               header = TRUE,
               stringsAsFactors = FALSE)
str(df)
# plyr(x)
# dplyr(o)
options(repos = c(CRAN = 'https://cloud.r-project.org'))
install.packages('dplyr', repos = 'https://cloud.r-project.org')
#library(dplyr)

df
sample_n(df,3)
sample_frac(df, 0.1)
df2 <- distinct(df)
df2
df <- read.csv("income.csv", 
               header = TRUE,
               stringsAsFactors = TRUE)
str(df)
# select
select(df,Index,State:Y2008)
select(df,Index,State)
select(df, State)
select(df, -Index, -State)
select(df, -c(Index,State))
select(df, starts_with("Y"))
select(df, -starts_with("Y"))
select(df, contains("I"))
select(df, State, everything())
df2 <- rename(df, Index2=Index)
names(df2)

# filter
filter(df, Index == "A")
filter(df, Index %in% "A")
filter(df, Index %in% c("A","C"))
filter(df, Index %in% c("A", "C") & Y2002 >= 1400000)
filter(df, !Index %in% c("A","C"))
# 010-1234-1234 -> [0-9][0-9][0-9] => 정규표현식
# regular expression
filter(df, grepl("Ar", State))

summarise(df, Y2015_mean = mean(Y2015),
          Y2015_median = median(Y2015))

# arrange
df3 <- select(df, Index)
df3
df4 <- arrange(df3, Index)
head(df4)
df5 <- arrange(df3, desc(Index))
df5

df6 <- select(df, Index, State)
df6
df7 <- arrange(df6, desc(Index), State)
df7
#1 1
#1 2
#1 1
#1 2
#2 1
#3 2

# group_by
group_by(df, Index)

View(df)
head(df,5)
tail(df,5)
View(df)

# Pipe Operator %>%
# magrittr
df %>% select(Index, State)

sample_n(select(df, Index,State), 10)
df %>% select(Index,State) %>% sample_n(10)

df10 <- read.csv("exam.csv")
str(df10)
df10
filter(df10, class == 1)
df10 %>% filter(class == 1)

filter(select(df10, class, math, english), class == 1)
df10 %>% 
  select(class, math, english) %>%
  filter(class == 1) %>%
  arrange(desc(math))

df_temp <- df10 %>%
  filter(class %in% c(1,3,5)) %>%
  arrange(desc(english))

df_temp




