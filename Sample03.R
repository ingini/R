install.packages("tidyverse")
library(tidyverse)
mtcars
ggplot(mtcars) + geom_point(mapping = aes(x=mpg, y = disp))

p <- ggplot(mtcars, mapping = aes(x=mpg, y=disp)) 
p + geom_point() + geom_line() + geom_smooth(method = "lm", 
      formula = y ~ poly(x,2))

