library(ggplot2)
library(shiny)
library(shinydashboard)
library(dplyr)
library(tidyverse)
library(ggpubr)
library(lubridate)
library(data.table)

data<- read.csv("transaction-dataset.csv")


data <- mutate(data,
       
      success_rate = success * 100/t)
setDT(data)[, paste0("hr", 1:2) := tstrsplit(hr," ")]
newData <- data %>% filter(hr2 >= "20", hr2 <="23")


pmtVSpg <- ggplot(newData, aes(x = pmt, y = pg, colour = success_rate)) +
  theme(axis.text.x = element_text(size = 8)) +
  geom_point()

pmtVSmid <- ggplot(newData, aes(x = mid, y = pmt, colour = success_rate)) +
  theme(axis.text.x = element_text(size = 10,angle=-45)) +
  geom_point()

pgVSmid <- ggplot(newData, aes(x = mid, y = pg, colour = success_rate)) +
  theme(axis.text.x = element_text(size = 10,angle=-45)) +
  geom_point()

ggarrange(pmtVSpg, pmtVSmid, pgVSmid,
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)

datestwelve <- data %>% select(hr,success_rate,mid,pmt,sub_type,pg)
twelvefeb <- datestwelve %>% filter(hr >= as.Date("2020-02-12") & hr < as.Date("2020-02-13"))
df_grp_twelve <- twelvefeb %>% group_by(hr) %>% summarise(mean_success_rate = mean(success_rate))

setDT(df_grp_twelve)[, paste0("hr", 1:2) := tstrsplit(hr," ")]
twelveplot <- ggplot(df_grp_twelve, mapping = aes(x= mean_success_rate,y=hr2)) +
  geom_point()

datesthirteen <- data %>% select(hr,success_rate,success_rate,mid,pmt,sub_type,pg)
thirteenfeb <- datesthirteen %>% filter(hr >= as.Date("2020-02-13") & hr < as.Date("2020-02-14"))
df_grp_thirteen <- thirteenfeb %>% group_by(hr) %>% summarise(mean_success_rate = mean(success_rate))

setDT(df_grp_thirteen)[, paste0("hr", 1:2) := tstrsplit(hr," ")]
thirteenplot <- ggplot(df_grp_thirteen, mapping = aes(x= mean_success_rate,y=hr2)) +
  geom_point()


datesfourteen <- data %>% select(hr,success_rate,success_rate,mid,pmt,sub_type,pg)
fourteenfeb <- datesfourteen %>% filter(hr >= as.Date("2020-02-14"))
df_grp_fourteen <- fourteenfeb %>% group_by(hr) %>% summarise(mean_success_rate = mean(success_rate))

setDT(df_grp_fourteen)[, paste0("hr", 1:2) := tstrsplit(hr," ")]
fourteenplot <- ggplot(df_grp_fourteen, mapping = aes(x= mean_success_rate,y=hr2)) +
  geom_point() 

#bankplot <- ggplot(data = data, mapping = aes(x=success_rate,y=bank)) +
#  geom_point()
#bankplot

#pmtplot <- ggplot(data = data, mapping = aes(x=success_rate,y=pmt)) +
#  geom_point()
#pmtplot

#pgplot <- ggplot(data = data, mapping = aes(x=success_rate,y=pg)) +
#  geom_point()
#pgplot

#subplot <- ggplot(data = data, mapping = aes(x= success_rate,y=sub_type)) +
#  geom_point()
#subplot

ggarrange(twelveplot, thirteenplot, fourteenplot,
          labels = c("A", "B", "C"),
          ncol = 2, nrow = 2)




