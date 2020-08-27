
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

my_plotter <- function(firstGen, lastGen, m1, m2, m3, title, y_axis) {

generations <- seq(firstGen, lastGen)
val_1 = as.numeric(m1)
val_01 = as.numeric(m2)
val_5 = as.numeric(m3)
df <- data.frame(generations, val_1, val_01, val_5)
mdf <- melt(df,id.vars="generations")
ggplot (mdf, aes(x= generations, y = value, colour = variable))+
  geom_line() +
  xlim(firstGen, lastGen) + geom_vline(xintercept = 20000, color="black", size=0.1)
}

fd3 = "var_1.txt"
output1 = read.table(fd3)
fd4 = "prev_1.txt"
firstGen <- output1[[1]][1]
lastGen <- output1[[1]][nrow(output1)]
output2 = read.table(fd4)
var_1 <- calc_var(output1)
prev_1 <- calc_prev(output2)


fd3 = "var_01.txt"
output1 = read.table(fd3)
fd4 = "prev_01.txt"
output2 = read.table(fd4)
var_01 <- calc_var(output1)
prev_01 <- calc_prev(output2)

fd3 = "var_5.txt"
output1 = read.table(fd3)
fd4 = "prev_5.txt"
output2 = read.table(fd4)
var_5 <- calc_var(output1)
prev_5 <- calc_prev(output2)

my_plotter(firstGen, lastGen, var_1[[1]], var_01[[1]], var_5[[1]], "Genetic Variance", "Mean Genetic Variance") 

my_plotter(firstGen, lastGen, var_1[[2]], var_01[[2]], var_5[[2]], "Heritability", "Mean Heritability") 

my_plotter(firstGen, lastGen, prev_1[[1]], prev_01[[1]], prev_5[[1]], "Prevalance", "% of Population with Disease") 

my_plotter(firstGen, lastGen, prev_1[[2]], prev_01[[2]], prev_5[[2]], "Risk Effect Size", "Risk Effect Size") 
