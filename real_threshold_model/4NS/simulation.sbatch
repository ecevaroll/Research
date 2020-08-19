#!/bin/bash
#SBATCH --job-name=mutation_sim             # Job name
#SBATCH --ntasks=5               # number of processes
#SBATCH --nodes=1                # number of nodes
#SBATCH --mem-per-cpu=8000M      # memory; default unit is megabytes
#SBATCH --time=01-05:00           # time (DD-HH:MM)
#SBATCH --mail-user=evarol@uchicago.edu  # Send email updates to you or someone else
#SBATCH --mail-type=ALL          # send an email in all cases (job started, job ended, job aborted)
#SBATCH --partition=broadwl
echo "Running on hostname `hostname`"


echo "Working directory is `pwd`"

module load midway2; module load SLiM/3.0

for rep in {1..40}
do
slim -d rho=0.497 -d "prev_name='prev_01.txt'"  -d "var_name='var_01.txt'" sim.txt
echo "Finished sim01 at `date`."
slim -d rho=0.269 -d "prev_name='prev_1.txt'"  -d "var_name='var_1.txt'" sim.txt
echo "Finished sim1 at `date`."
slim -d rho=0.007 -d "prev_name='prev_5.txt'"  -d "var_name='var_5.txt'" sim.txt
echo "Finished sim5 at `date`."
echo "Finished $rep"
done

echo "Finished slim at `date`."

module load R

R CMD BATCH --save --no-restore analysis.R

echo "Finished analysis at `date`."

