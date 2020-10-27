#!/bin/sh
# properties = {"type": "single", "rule": "calc_vals", "local": false, "input": ["10000_1_test.txt", "10000_100_test.txt", "10000_5_test.txt", "10000_10_test.txt", "10000_30_test.txt", "1000_1_test.txt", "1000_100_test.txt", "1000_5_test.txt", "1000_10_test.txt", "1000_30_test.txt", "3162_1_test.txt", "3162_100_test.txt", "3162_5_test.txt", "3162_10_test.txt", "3162_30_test.txt", "31622_1_test.txt", "31622_100_test.txt", "31622_5_test.txt", "31622_10_test.txt", "31622_30_test.txt"], "output": ["10000_1_data.txt", "10000_100_data.txt", "10000_5_data.txt", "10000_10_data.txt", "10000_30_data.txt", "1000_1_data.txt", "1000_100_data.txt", "1000_5_data.txt", "1000_10_data.txt", "1000_30_data.txt", "3162_1_data.txt", "3162_100_data.txt", "3162_5_data.txt", "3162_10_data.txt", "3162_30_data.txt", "31622_1_data.txt", "31622_100_data.txt", "31622_5_data.txt", "31622_10_data.txt", "31622_30_data.txt"], "wildcards": {}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 4, "cluster": {"mem": 16000, "partition": "broadwl", "ntasks": 1, "tasks": 1, "mem-per-cpu": 2000, "output": "logs/calc_vals..out", "error": "logs/calc_vals..err", "job-name": "calc_vals."}}
 cd /home/evarol/Research/Research/lower_threshold_project && \
PATH='/software/python-3.7.0-el7-x86_64/bin':$PATH /software/python-3.7.0-el7-x86_64/bin/python \
-m snakemake 10000_1_data.txt --snakefile /home/evarol/Research/Research/lower_threshold_project/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp 10000_1_test.txt 10000_100_test.txt 10000_5_test.txt 10000_10_test.txt 10000_30_test.txt 1000_1_test.txt 1000_100_test.txt 1000_5_test.txt 1000_10_test.txt 1000_30_test.txt 3162_1_test.txt 3162_100_test.txt 3162_5_test.txt 3162_10_test.txt 3162_30_test.txt 31622_1_test.txt 31622_100_test.txt 31622_5_test.txt 31622_10_test.txt 31622_30_test.txt --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler greedy \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules calc_vals --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/4.jobfinished || (touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/4.jobfailed; exit 1)

