install.packages('dplyr')
install.packages('tibble')
install.packages('tidyr')
install.packages('purrr')
install.packages('ggplot2')

require(dplyr)
require(tibble)
require(tidyr)
require(purrr)
require(ggplot2)


nome = "Aironys"
nome

sobrenome = "Garrido"
sobrenome

# Lendo um arquivo
df <- read.csv("annual-enterprise-survey-2021-financial-year-provisional-csv.csv",stringsAsFactors = FALSE)
df

#Verificando o tipo de arquivo
str(df)

print(df)

#Transformando NA em zero
df[is.na(df)] <- 0

#Verificando Tipo de Dados
typeof(df$Year) # tipo de dados é integer

typeof(as_tibble(df)) #Tipo de dados é list

#Selecionando elementos distintos
distinct(df, df$Variable_name) # Total 41 nomes distintos

#Transaformando string date em DATE
df$Year <- as.character(df$Year)
typeof(df$Year)   # antes era integer agora é character



df$Year <- as.Date(ISOdate(df$Year, 1, 1))
df$Year <- as.Date(df$Year,"%Y-%m-%d")
str(df$Year)


df$Value <- as.numeric(df$Value)


#Tranformando string em numeric
df$Value <- sub(",",".",df$Value)
df$Value <- sub(",","",df$Value)

str(df$Value)

df$Value <- as.numeric(df$Value)

#Um pouquinho de dplyr
new_df <- dplyr::select(df,Year,Variable_name,Value)
new_df

#Podemos concatenar as operações
new_df_2 <- df %>% select(Year,Variable_name,Value) %>% filter(Year == '2021-01-01' || Year == '2020-01-01')


#Um pouquinho de ggplot2
df[is.na(df)] <- 0

plot <- df %>% select(Year,Value) %>% group_by(Year) %>% summarize(Value = sum(Value))

ggplot(plot, aes(y = Value, x = Year)) + 
  geom_point() +
  geom_smooth(method = "lm") 


vetor <- c(6,3,7,8)
