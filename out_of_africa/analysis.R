library(ggplot2)

#POPULATION
fd = "population_size.txt"
output = read.table(fd)
firstGen <- output[[1]][1]
lastGen <- output[[1]][nrow(output)]

#plot the overall population trend
df <- data.frame(x = output[1], y = output[2])
print(ggplot (df, aes(x = as.numeric(unlist((output[1]))), y = as.numeric(unlist(output[2]))))) +
  geom_line(size = 0.5) + ggtitle("Population Trajectory After Expansion Event") + labs(x ="generation", y="population size") + 
  xlim(50000,lastGen)



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

my_plotter <- function(firstGen, lastGen, m1, title, y_axis) {

gens <- seq(firstGen, lastGen)
df <- data.frame(x = gens, y = as.numeric(unlist(m1)))
print(ggplot (df, aes(x = gens, y = as.numeric(unlist(m1)))))+ geom_line(size = 0.1) + ggtitle(title) + labs(x ="generation", y= y_axis) + 
  xlim(firstGen, lastGen) + geom_vline(xintercept = 52080, color="red", size=0.1)+ geom_vline(xintercept = 55960, color="red", size=0.1) + 
  geom_vline(xintercept = 57080, color="red", size=0.1) + geom_vline(xintercept = 57795, color="red", size=0.1)
}

fd3 = "variance.txt"
output1 = read.table(fd3)
fd4 = "prevalance.txt"
firstGen <- output1[[1]][1]
lastGen <- output1[[1]][nrow(output1)]
output2 = read.table(fd4)
var_1 <- calc_var(output1)
prev_1 <- calc_prev(output2)


my_plotter(firstGen, lastGen, var_1[[1]], "Genetic Variance of OOA", "Mean Genetic Variance") 

my_plotter(firstGen, lastGen, var_1[[2]], "Heritability of OOA", "Mean Heritability") 

my_plotter(firstGen, lastGen, prev_1[[1]], "Prevalance of OOA", "% of Population with Disease") 

my_plotter(firstGen, lastGen, prev_1[[2]], "Risk Effect Size of OOA", "Risk Effect Size") 
