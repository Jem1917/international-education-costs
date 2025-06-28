iec<-read.csv(file.choose())
summary(iec)
iec$Total_Cost <- as.numeric(gsub("[$,]", "", iec$Total_Cost))
iec$Rent_USD <- as.numeric(gsub("[$,]", "", iec$Rent_USD))
iec$Visa_Fee_USD <- as.numeric(gsub("[$,]", "", iec$Visa_Fee_USD))
iec$Insurance_USD <- as.numeric(gsub("[$,]", "", iec$Insurance_USD))
iec$Tuition_USD <- as.numeric(gsub("[$,]", "", iec$Tuition_USD))

aggregate(Total_Cost ~ Country, data = iec, mean)
library(dplyr)
iec %>%
  group_by(Country) %>%
  summarise(Avg_Cost = mean(Total_Cost, na.rm = TRUE)) %>%
  arrange(desc(Avg_Cost)) %>%
  head(5)
library(tidyr)
long_iec <-iec %>%
  pivot_longer(cols = c(Tuition_USD, Rent_USD, Visa_Fee_USD, Insurance_USD),
               names_to = "Cost_Type",
               values_to = "Amount")
library(ggplot2)

ggplot(long_iec, aes(x = Country, y = Amount, fill = Cost_Type)) +
  geom_bar(stat = "identity", position = "stack") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

install.packages("factoextra")
install.packages("tibble")

library(factoextra)
library(tibble)
cluster_data <- iec %>%
  group_by(Country) %>%
  summarise(across(c(Tuition_USD, Rent_USD, Visa_Fee_USD, Insurance_USD), mean)) %>%
  column_to_rownames("Country") %>%
  scale()

k <- kmeans(cluster_data, centers = 3)
fviz_cluster(k, data = cluster_data)


model <- lm(Total_Cost ~ Tuition_USD + Rent_USD + Visa_Fee_USD + Insurance_USD, data = iec)
summary(model)


