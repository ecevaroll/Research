#!/bin/bash
#SBATCH --job-name=mutation_sim             # Job name
#SBATCH --ntasks=5               # number of processes
#SBATCH --nodes=1                # number of nodes
#SBATCH --mem-per-cpu=8000M      # memory; default unit is megabytes
#SBATCH --time=00-12:00           # time (DD-HH:MM)
#SBATCH --mail-user=evarol@uchicago.edu  # Send email updates to you or someone else
#SBATCH --mail-type=ALL          # send an email in all cases (job started, job ended, job aborted)
#SBATCH --partition=broadwl
echo "Running on hostname `hostname`"


echo "Working directory is `pwd`"

module load midway2; module load SLiM/3.0

for rep in {1..15}
do
slim ./simulation_01.txt
echo "Finished sim01 at `date`."
slim ./simulation1.txt
echo "Finished sim1 at `date`."
slim ./simulation5.txt
echo "Finished sim5 at `date`."
echo "Finished $rep"
done


echo "Finished slim at `date`."
