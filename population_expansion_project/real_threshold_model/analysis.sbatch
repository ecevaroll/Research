#!/bin/bash
#SBATCH --job-name=analysis_sim             # Job name
#SBATCH --ntasks=5               # number of processes
#SBATCH --nodes=1                # number of nodes
#SBATCH --mem-per-cpu=8000M      # memory; default unit is megabytes
#SBATCH --time=00-12:00           # time (DD-HH:MM)
#SBATCH --mail-user=evarol@uchicago.edu  # Send email updates to you or someone else
#SBATCH --mail-type=ALL          # send an email in all cases (job started, job ended, job aborted)
#SBATCH --partition=broadwl
echo "Running on hostname `hostname`"

echo "Working directory is `pwd`"

module load R

R CMD BATCH --save --no-restore analysis.R

echo "Finished analysis at `date`."
