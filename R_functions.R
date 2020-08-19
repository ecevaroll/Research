setwd("Desktop/Research")
slim_path <- "/usr/local/bin/slim"
script_path <- "SLIM/PopExpEnvBen.txt"

##Function to run the slim code 
doOneSLiMRun <- function(seed, script)
{
  system2(slim_path, args = c("-s", seed, shQuote(script)), stdout=TRUE, stderr=TRUE)
}

##Constants used
reps <- 5 ##how many times will the code run
firstGen <- 8000 ##first generation to start the analysis
popExp<-10000 ##the generation the population expands at
lastGen<- 11000 ##last generation of the simulation
threshold<-7 ##threshold mutation number (above threshold has disease)
generations<- lastGen-firstGen ##how many generations are in the simulation



clean_data <- function(reps, generations, firstGen, script_path){
  ##clean the data imported from SLIM and return a list that has a list with two elements, 
  ##the first one being the generation number and the second one being a list of number of mutations of that generation from every rep combined
  splitCounts <- list()

  for(rep in 1:reps){ #for loop for repeats of the simulation
    data<- list()
    valuesList<- list()
    print(rep)
    output <- doOneSLiMRun(rep, script_path)
    myPattern <- paste(toString(firstGen), ":", sep=" ")
    firstLine <- grep(myPattern,output)
    valuesList<-strsplit(output[firstLine:length(output)] , " : ")
    gens <- sapply(valuesList, FUN = function(ELEM) ELEM[1])
    data <- lapply(valuesList, FUN= function(ELEM)as.numeric(strsplit(ELEM[2]," ")[[1]]))
    
    for (gen in 1: (generations + 1)){
      if (rep == 1){
        splitCounts[[gen]]<- list()
        splitCounts[[gen]][[2]] <- list()
        splitCounts[[gen]][[1]] <- gens[gen]
        splitCounts[[gen]][[2]][[rep]] <- data[[gen]]}
      else{
        splitCounts[[gen]][[2]][[rep]] <- data[[gen]]}
      print(gen)
    }
  }
  return(splitCounts)
}



generation_means_across_rep <- function(reps, generations){
  ### Takes the cleaned up data and returns a matrix with generation number and the corresponding
  ### average value of liability for that generation.
  ### Inputs: 
    ### reps: (integer) number of repetitions of the simulation
    ### script_path: path to run SLIM 
    ### total number of generations
  ### Returns: meanCount: a matrix of average liabilities ncol= reps, nrow=generation
  ### reminder[nrow,ncol]
  clean <-clean_data(reps, generations, firstGen)
  meanCount<- matrix(rep(NA ,reps*(lastGen-firstGen)),nrow = reps ,ncol=c(lastGen-firstGen))

    for (gen in 1:generations+1){
      for (rep in 1:(reps)){ 
        inter<- lapply(clean[[gen]][[2]], mean)
        meanCount[rep, gen]<- inter [[rep]]
        print(gen)

      }
    }
  return(meanCount)
}  



calculate_diseased_people <- function(reps, generations, firstGen, script_path ){
  ### Calculate the average number of individuals per generation per rep who have the disease 
  ### use liability threshold model.
  ### diseased <- matrix[reps, gens]
  ###average_diseased<- matrix[1, gens] matrix of average % diseased
  ### Inputs:
  
  clean <-clean_data(reps, generations, firstGen, script_path)
  diseased<- matrix(rep(NA,(generations)*reps), ncol= (reps+1), nrow=generations)
  for (rep in (1 : reps)){
  for (gen in (1 : generations)){
    diseased[gen, 1]<- (firstGen+ gen-1)
      x <-as.numeric(unlist(clean[[gen]][[2]][[rep]]))
      liability <- length(which(x > threshold))
      diseased[gen,rep+1]<-liability/length(x)}
    }
  
  return(diseased)
}




plot_disease_prevelance<- function(reps, generations, firstGen, title, script_path){

  diseased<- calculate_diseased_people(reps, generations, firstGen)
  df<- data.frame(generation = integer(), diseased_percentage = numeric(), stdev = numeric())
  generation <- firstGen:(lastGen-1)
  diseased_percentage<- apply(diseased[,-1],1,mean)
  stdev <- apply(diseased[,-1], 1, sd)
  df = rbind(df, data.frame(generation, diseased_percentage, stdev))

library(ggplot2)

return(ggplot (df, aes(x = generation, y = diseased_percentage)) + geom_point(size = 0.1) + 
         ggtitle(title) + labs(y="generation", x="disease prevelance(%)"))}

"Disease Prevelance with Beneficial Mutation"
print(plot_disease_prevelance(reps, generations, firstGen, title, script_path))

