
library(ggplot2)



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

gens <- seq(firstGen, lastGen)
df <- data.frame(x = gens, y = as.numeric(unlist(m1)))
colors <- c("4NS = 1" = "red", "4NS = 0.1" = "blue", "4NS = 5" = "green")
print(ggplot (df, aes(gens, as.numeric(m1)))) +
  geom_line(size = 0.3, aes(color= "red")) + ggtitle(title) + geom_line(aes(y=as.numeric(m2), color="blue" ), size = 0.3) + geom_line(aes(y=as.numeric(m3), color="green" ), size = 0.3) +
  labs(x ="generation", y= y_axis, color = "Legend") + scale_color_identity(guide = "legend", name = "4NS Value", labels = c("4NS = 1" , "4NS = 0.1", "4NS = 5")) + 
  xlim(firstGen, lastGen) + geom_vline(xintercept = 10000, color="black", size=0.1)
}

fd3 = "variance_1.txt"
output1 = read.table(fd3)
fd4 = "prevalence_1.txt"
firstGen <- output1[[1]][1]
lastGen <- output1[[1]][nrow(output1)]
output2 = read.table(fd4)
var_1 <- calc_var(output1)
prev_1 <- calc_prev(output2)


fd3 = "variance_01.txt"
output1 = read.table(fd3)
fd4 = "prevalence_01.txt"
output2 = read.table(fd4)
var_01 <- calc_var(output1)
prev_01 <- calc_prev(output2)

fd3 = "variance_5.txt"
output1 = read.table(fd3)
fd4 = "prevalence_5.txt"
output2 = read.table(fd4)
var_5 <- calc_var(output1)
prev_5 <- calc_prev(output2)

my_plotter(firstGen, lastGen, var_1[[1]], var_01[[1]], var_5[[1]], "Genetic Variance", "Mean Genetic Variance") 

my_plotter(firstGen, lastGen, var_1[[2]], var_01[[2]], var_5[[2]], "Heritability", "Mean Heritability") 

my_plotter(firstGen, lastGen, prev_1[[1]], prev_01[[1]], prev_5[[1]], "Prevalance", "% of Population with Disease") 

my_plotter(firstGen, lastGen, prev_1[[2]], prev_01[[2]], prev_5[[2]], "Risk Effect Size", "Risk Effect Size") 
