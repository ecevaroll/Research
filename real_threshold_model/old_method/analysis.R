
library(ggplot2)

calc_m1 <- function(output) {

	firstGen <- output[[1]][1]
	lastGen <- output[[1]][nrow(output)]
	h <- list()
	for (i in (1 : (lastGen/100))) {
		h[[i]]<-list()
	}

	for (i in 1 : (nrow(output))) {
		gen <- output[[1]][i] #generation
		mut_ID <- output[[2]][i] #mutation ID
		DAA <- output[[3]][i] #number of people homozygous without the allele and has disease
		DAa <- output[[4]][i] #number of people heterozygous and has disease
		Daa <- output[[5]][i] #number of people homozygous for allele and has the disease
		NAA <- output[[6]][i] #number of people homozygous, without the allele
		NAa <- output[[7]][i] #number of people heterozygous for the allele
		Naa <- output[[8]][i] #number of people homozygous, have the allele
		N <- (Naa + NAa + NAA) #population
		
		Raa <- ifelse(Naa != 0, Daa /Naa, 0)
		RAa <- ifelse(NAa != 0, DAa /NAa, 0)
		RAA <- ifelse(NAA != 0, DAA /NAA, 0)
		
		pi_a <- (Raa - RAa)
		pi_A <- (RAa - RAA)
		
		x <- ((2 * NAA) + NAa) / (2 * N)
		pi <- ((1 - x) * pi_a) + (x * pi_A)
		h[[gen/100]] <- append(h[[gen/100]], pi)
	}

	mean_pi_m1 = list()
	for (i in 1: length(h)) {
		mean_pi_m1[i] <- mean(unlist(h[[i]]))
	}
	return (mean_pi_m1)
	
}

calc_m2 <- function(output) {

	firstGen <- output[[1]][1]
	lastGen <- output[[1]][nrow(output)]
	h <- list()
	for (i in (1 : (lastGen/100))) {
		h[[i]]<-list()
	}

	for (i in 1 : (nrow(output))) {
		gen <- output[[1]][i] #generation
		mut_ID <- output[[2]][i] #mutation ID
		DAA <- output[[3]][i] #number of people homozygous without the allele and has disease
		DAa <- output[[4]][i] #number of people heterozygous and has disease
		Daa <- output[[5]][i] #number of people homozygous for allele and has the disease
		NAA <- output[[6]][i] #number of people homozygous, without the allele
		NAa <- output[[7]][i] #number of people heterozygous for the allele
		Naa <- output[[8]][i] #number of people homozygous, have the allele
		N <- (Naa + NAa + NAA) #population
		
		Raa <- ifelse(Naa != 0, Daa /Naa, 0)
		RAa <- ifelse(NAa != 0, DAa /NAa, 0)
		RAA <- ifelse(NAA != 0, DAA /NAA, 0)
		
		pi_a <- (RAa - Raa)
		pi_A <- (RAA - RAa)
		
		x <- ((2 * NAA) + NAa) / (2 * N)
		pi <- ((1 - x) * pi_a) + (x * pi_A)
		h[[gen/100]] <- append(h[[gen/100]], pi)
	}

	mean_pi_m2 = list()
	for (i in 1: length(h)) {
		mean_pi_m2[i] <- mean(unlist(h[[i]]))
	}
	return (mean_pi_m2)
	
}



fd = "risk_effect_m1_1.txt"
output = read.table(fd)
firstGen <- output[[1]][1]
lastGen <- output[[1]][nrow(output)]
m1_1 <- calc_m1(output)


fd = "risk_effect_m1_01.txt"
output = read.table(fd)
m1_01 <- calc_m1(output)

fd = "risk_effect_m1_5.txt"
output = read.table(fd)
m1_5 <- calc_m1(output)

gens <- seq(firstGen, lastGen, 100)
df <- data.frame(x = gens, y = as.numeric(unlist(m1_1)))
colors <- c("4NS = 1" = "red", "4NS = 0.1" = "blue", "4NS = 5" = "green")
print(ggplot (df, aes(gens, as.numeric(m1_1)))) +
  geom_line(size = 0.3, aes(color= "red")) + ggtitle("Liability Increasing Mutation") + geom_line(aes(y=as.numeric(m1_01), color="blue" ), size = 0.3) + geom_line(aes(y=as.numeric(m1_5), color="green" ), size = 0.3) +
  labs(x ="generation", y="average π", color = "Legend") + scale_color_identity(guide = "legend", name = "4NS Value", labels = c("4NS = 1" , "4NS = 0.1", "4NS = 5")) + 
  xlim(firstGen, lastGen) + geom_vline(xintercept = 10000, color="black", size=0.1)



fd = "risk_effect_m2_1.txt"
output = read.table(fd)
firstGen <- output[[1]][1]
lastGen <- output[[1]][nrow(output)]
m2_1 <- calc_m2(output)

fd = "risk_effect_m2_01.txt"
output = read.table(fd)
m2_01 <- calc_m2(output)

fd = "risk_effect_m2_5.txt"
output = read.table(fd)
m2_5 <- calc_m2(output)

gens <- seq(firstGen, lastGen, 100)
df <- data.frame(x = gens, y = as.numeric(unlist(m2_1)))
colors <- c("4NS = 1" = "red", "4NS = 0.1" = "blue", "4NS = 5" = "green")
print(ggplot (df, aes(gens, as.numeric(m2_1)))) +
  geom_line(size = 0.3, aes(color= "red")) + ggtitle("Liability Decreasing Mutation") + geom_line(aes(y=as.numeric(m2_01), color="blue" ), size = 0.3) + geom_line(aes(y=as.numeric(m2_5), color="green" ), size = 0.3) +
  labs(x ="generation", y="average π", color = "Legend") + scale_color_identity(guide = "legend", name = "4NS Value", labels = c("4NS = 1" , "4NS = 0.1", "4NS = 5")) + 
  xlim(firstGen, lastGen) + geom_vline(xintercept = 10000, color="black", size=0.1)



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
    firstGen <- output[[1]][1]
    lastGen <- output[[1]][nrow(output)]
    for (i in (1 : (lastGen))) {
        prevalence[[i]]<- list()
    }

    for (i in 1 : nrow(output)) {
        gen = output[[1]][i]
        prevalence[[gen]] <- append(prevalence[[gen]], output[[2]][[i]])
    }

    mean_prev = list()
    for (i in 1: length(prevalence)) {
        mean_prev[i] <- mean(unlist(prevalence[[i]]))
    }
    return (mean_prev)
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
firstGen <- output[[1]][1]
lastGen <- output[[1]][nrow(output)]
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

my_plotter(firstGen, lastGen, var_1[2], var_01[2], var_5[2], "Heritability", "Mean Heritability") 

my_plotter(firstGen, lastGen, prev_1, prev_01, prev_5, "Prevalance", "% of Population with Disease") 

