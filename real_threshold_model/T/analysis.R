
library(ggplot2)
library(reshape2)

calc_var <- function(output) {
    variance <- list()
    heritability <- list()
    firstGen <- output[[1]][1]
    lastGen <- output[[1]][nrow(output)]
    for (i in (1 : (lastGen))) {
        variance[[i]]<-list()
        heritability[[i]]<-list()
    }

    for (i in 1 : nrow(output)) {
        gen = output[[1]][i]
        variance[[gen]] <- append(variance[[gen]], output[[2]][i])
        heritability[[gen]] <- append(heritability[[gen]], output[[3]][i])
    }
	
	mean_variance<- list()
	mean_heritability <-list()
    
    for (i in 1: length(variance)) {
        mean_variance[i] <- mean(unlist(variance[[i]]))
        mean_heritability[i] <- mean(unlist(heritability[[i]]))
    }
    mean_var_her <- list()
    mean_var_her[[1]]<- mean_variance
    mean_var_her[[2]]<- mean_heritability

    return (mean_var_her)
    
}

calc_prev <- function(output) {
    prevalence <- list()
	risk <- list()
    firstGen <- output[[1]][1]
    lastGen <- output[[1]][nrow(output)]
    for (i in (1 : (lastGen))) {
		risk[[i]]<- list()
        prevalence[[i]]<- list()
    }

    for (i in 1 : nrow(output)) {
        gen = output[[1]][i]
        prevalence[[gen]] <- append(prevalence[[gen]], output[[2]][i])
		risk[[gen]] <- append(prevalence[[gen]], output[[3]][i])
    }
    
	mean_prev<- list()
	mean_risk <-list()
    
    for (i in 1: length(prevalence)) {
        mean_prev[i] <- mean(unlist(prevalence[[i]]))
        mean_risk[i] <- mean(unlist(risk[[i]]))
    }
    mean_prev_risk <- list()
    mean_prev_risk[[1]]<- mean_prev
    mean_prev_risk[[2]]<- mean_risk


    return (mean_prev_risk)
}

my_plotter <- function(firstGen, lastGen, m1, m2, m3, m4, m5, title, y_axis) {

generations <- seq(firstGen, lastGen)
T1 = as.numeric(m1)
T5 = as.numeric(m2)
T10 = as.numeric(m3)
T30 = as.numeric(m4)
T100 = as.numeric(m5)
df <- data.frame(generations, T1, T5, T10, T30, T100)
mdf <- melt(df,id.vars="generations")
ggplot (mdf, aes(x= generations, y = value, colour = variable))+
  geom_line() +
  xlim(firstGen, lastGen) + geom_vline(xintercept = 20000, color="black", size=0.1) + ylab(y_axis) + ggtitle(title)
}

fd3 = "var_t1.txt"
output1 = read.table(fd3)
fd4 = "prev_t1.txt"
firstGen <- output1[[1]][1]
lastGen <- output1[[1]][nrow(output1)]
output2 = read.table(fd4)
var_1 <- calc_var(output1)
prev_1 <- calc_prev(output2)


fd3 = "var_t5.txt"
output1 = read.table(fd3)
fd4 = "prev_t5.txt"
output2 = read.table(fd4)
var_5 <- calc_var(output1)
prev_5 <- calc_prev(output2)

fd3 = "var_t10.txt"
output1 = read.table(fd3)
fd4 = "prev_t10.txt"
output2 = read.table(fd4)
var_10 <- calc_var(output1)
prev_10 <- calc_prev(output2)

fd3 = "var_t30.txt"
output1 = read.table(fd3)
fd4 = "prev_t30.txt"
output2 = read.table(fd4)
var_30 <- calc_var(output1)
prev_30 <- calc_prev(output2)

fd3 = "var_t100.txt"
output1 = read.table(fd3)
fd4 = "prev_t100.txt"
output2 = read.table(fd4)
var_100 <- calc_var(output1)
prev_100 <- calc_prev(output2)

my_plotter(firstGen, lastGen, var_1[[1]], var_5[[1]], var_10[[1]], var_30[[1]] , var_100[[1]],"Genetic Variance", "Mean Genetic Variance") 

my_plotter(firstGen, lastGen, var_1[[2]], var_5[[2]], var_10[[2]], var_30[[2]] , var_100[[2]], "Heritability", "Mean Heritability") 

my_plotter(firstGen, lastGen, prev_1[[1]], prev_5[[1]], prev_10[[1]], prev_30[[1]] , prev_100[[1]], "Prevalance", "% of Population with Disease") 

my_plotter(firstGen, lastGen, prev_1[[2]], prev_5[[2]], prev_10[[2]], prev_30[[2]] , prev_100[[2]], "Risk Effect Size", "Risk Effect Size") 
