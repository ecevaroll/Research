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

for rep in {1..10}
do
slim -d rho=0.00005 -d "prev_name='prev_t1.txt'"  -d "var_name='var_t1.txt'" sim.txt
echo "Finished sim1 at `date`."
slim -d rho=0.00025 -d "prev_name='prev_t5.txt'"  -d "var_name='var_t5.txt'" sim.txt
echo "Finished sim5 at `date`."
slim -d rho=0.0005 -d "prev_name='prev_t10.txt'"  -d "var_name='var_t10.txt'" sim.txt
echo "Finished sim10 at `date`."
slim -d rho=0.0015 -d "prev_name='prev_t30.txt'"  -d "var_name='var_t30.txt'" sim.txt
echo "Finished sim30 at `date`."
slim -d rho=0.005 -d "prev_name='prev_100.txt'"  -d "var_name='var_100.txt'" sim.txt
echo "Finished $rep"
done

echo "Finished slim at `date`."

module load R

R CMD BATCH --save --no-restore analysis.R

echo "Finished analysis at `date`."

