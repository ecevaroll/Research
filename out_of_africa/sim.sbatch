#!/bin/bash
#SBATCH --job-name=mutation_sim             # Job name
#SBATCH --ntasks=5               # number of processes
#SBATCH --nodes=1                # number of nodes
#SBATCH --mem-per-cpu=8000M      # memory; default unit is megabytes
#SBATCH --time=1-10:00           # time (DD-HH:MM)
#SBATCH --mail-user=evarol@uchicago.edu  # Send email updates to you or someone else
#SBATCH --mail-type=ALL          # send an email in all cases (job started, job ended, job aborted)
#SBATCH --partition=broadwl
echo "Running on hostname `hostname`"
echo "started slim at `date`."

echo "Working directory is `pwd`"

module load midway2; module load SLiM/3.0

for rep in {1..30}
do
slim -d rho=0.9 -d "prev_name='prevalance.txt'" -d "var_name='variance.txt'" simulation.txt
echo "Finished $rep at `date`."
done
echo "Finished slim at `date`."
