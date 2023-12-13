library(purrr)


list1 = list(
  city1=list(name='Moscow',pop=12e9),
  city2=list(name='Istanbul',pop=16e9))

list1["city1"]
list1[["city1"]]
list1[["city1"]][["name"]]
get_pop <- function ( litem) { litem [["pop"]] }
lapply(list1, get_pop)

(pop_list <- map(list1,get_pop) ) # lapply
(pop_v<-map_dbl(list1,get_pop)) # map_dbl -- sapply 
str(pop_v)
map_chr(list1,~.x[["name"]])

x=1:10
n=-(1:10)

map2(x,n, .f= function(x1,x2) x1^x2 )
map2_dbl(x,n, .f= function(x1,x2) x1^x2 )
#  ~ = formula operator
map2_dbl(x,n,  ~ .x^.y )
map2_dbl(x,n,  ~ .1^.2 )


## return even items from x
keep(x, ~ .x %% 2 == 0)
discard(x, ~ .x %% 2 != 0)

## 1 item
detect(x, ~ .x %% 2 == 0)
detect_index(x, ~ .x %% 2 == 0)
## right - to - left lookup
detect(x, ~ .x %% 2 == 0,.dir = "backward")
detect_index(x, ~ .x %% 2 == 0 ,.dir = "backward")

##
list2 = list(
  city1=list(name='Moscow',stats=list(pop=12e9)),
  city2=list(name='Istanbul',stats=list(pop=16e9,area=5343)))
## map : extractor 

map(list2,.f=c(2,2))
map(list2,.f=list(2,"pop"))
map(list2,.f=list(2,"area"),.default=NA)
map_chr(list2,.f="name",.default=NA)


## Задача отбрать элементы >200
mtcars$hp 

keep(mtcars$hp, ~.x>200)

mtcars[ map_lgl(mtcars$hp, ~.x>200), ]

## hist -- гисторрамма в базовой графике
library(tidyverse)
class_v <- unique(mpg$class)
class_v
hist_func=function(cls) 
  hist(
    mpg$cyl[mpg$class==cls], 
    main=str_glue("Гисторамма для класса авто {cls}"),xlab="cyl",
    breaks = 0.5+-1:8)
walk(.x = class_v, .f= hist_func  )

h1 <- hist(mpg$cyl[mpg$class=="midsize"],xlab="cylinders",breaks = 0.5+-1:8)
h1
unique(mpg$class)


hist_mapper <- as_mapper(~ hist(
  mpg$cyl[mpg$class==.x], 
  main=str_glue("Гисторамма для класса авто {.x}"),xlab="cyl",
  breaks = 0.5+-1:8))
walk(.x=class_v,.f=hist_mapper)
hist_list <- map(.x=class_v,.f=hist_mapper)
names(hist_list) <- class_v
