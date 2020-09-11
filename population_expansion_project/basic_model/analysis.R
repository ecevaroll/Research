
library(ggplot2)

#LIABILITY INCREASING MUTATION
fd1 = "risk_effect_m1.txt"
output = read.table(fd1)

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

gens = seq(firstGen, lastGen, 100)
df <- data.frame(x = gens, y = as.numeric(unlist(mean_pi_m1)))
print(ggplot (df, aes(x = gens, y = as.numeric(mean_pi_m1)))) +
geom_line(size = 1) + ggtitle("Liability Increasing Mutation") + labs(x ="generation", y="average π") + 
xlim(100,20000) + geom_vline(xintercept = 10000, color="red")

ggsave("pi_m1.png")



#LIABILITY DECREASING MUTATION
fd2 = "risk_effect_m2.txt"
output = read.table(fd2)

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

gens = seq(firstGen, lastGen, 100)
df <- data.frame(x = gens, y = as.numeric(unlist(mean_pi_m2)))
print(ggplot (df, aes(x = gens, y = as.numeric(mean_pi_m2)))) +
    geom_line(size = 1) + ggtitle("Liability Decreasing Mutation") + labs(x ="generation", y="average π") + 
    xlim(100,20000) + geom_vline(xintercept = 10000, color="red")

ggsave("pi_m2.png")




#VARIANCE & HERITABILITY & PREVALENCE
fd3 = "variance.txt"
output = read.table(fd3)
fd4 = "prevalence.txt"
output2 = read.table(fd4)

prevalence <- list()
variance <- list()
heritability <- list()
firstGen <- output[[1]][1]
lastGen <- output[[1]][nrow(output)]
for (i in (1 : (lastGen))) {
  prevalence[[i]]<- list()
  variance[[i]]<-list()
  heritability[[i]]<-list()
}

for (i in 1 : nrow(output)) {
  gen1 = output[[1]][i]
  gen2 = output2[[1]][i]
  prevalence[[gen2]] <- append(prevalence[[gen2]], output2[[2]][[i]])
  variance[[gen1]] <- append(variance[[gen1]], output[[2]][i])
  heritability[[gen1]] <- append(heritability[[gen1]], output[[3]][i])
}

mean_prev = list()
mean_variance = list()
mean_heritability = list()
for (i in 1: length(variance)) {
  mean_prev[i] <- mean(unlist(prevalence[[i]]))
  mean_variance[i] <- mean(unlist(variance[[i]]))
  mean_heritability[i] <- mean(unlist(heritability[[i]]))
}

gens = seq(firstGen, lastGen)
df <- data.frame(x = gens, y = as.numeric(unlist(mean_variance)))
print(ggplot (df, aes(x = gens, y = as.numeric(mean_variance)))) +
  geom_line(size = 1) + ggtitle("Additive Genetic Variance") + labs(x ="generation", y="additive genetic variance") +
  xlim(0,20000) + geom_vline(xintercept = 10000, color="red")
ggsave("gen_var.png")


df <- data.frame(x = gens, y = as.numeric(unlist(mean_heritability)))
print(ggplot (df, aes(x = gens, y = as.numeric(mean_heritability)))) +
  geom_line(size = 1) + ggtitle("Heritability") + labs(x ="generation", y="heritability") + 
  xlim(0,20000) + geom_vline(xintercept = 10000, color="red")
ggsave("heritability.png")


df <- data.frame(x = gens, y = as.numeric(unlist(mean_prev)))
print(ggplot (df, aes(x = gens, y = as.numeric(mean_prev)))) +
geom_line(size = 1) + ggtitle("Disease Prevalence") + labs(x ="generation", y=" % prevalence") + 
xlim(0,20000) + geom_vline(xintercept = 10000, color="red")
ggsave("prevalence.png")



