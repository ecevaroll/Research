#!/bin/sh
# properties = {"type": "single", "rule": "analyze", "local": false, "input": ["10000_1.txt", "10000_100.txt", "10000_5.txt", "10000_10.txt", "10000_30.txt", "1000_1.txt", "1000_100.txt", "1000_5.txt", "1000_10.txt", "1000_30.txt", "3162_1.txt", "3162_100.txt", "3162_5.txt", "3162_10.txt", "3162_30.txt", "31622_1.txt", "31622_100.txt", "31622_5.txt", "31622_10.txt", "31622_30.txt"], "output": ["10000_1_analysis.txt", "10000_100_analysis.txt", "10000_5_analysis.txt", "10000_10_analysis.txt", "10000_30_analysis.txt", "1000_1_analysis.txt", "1000_100_analysis.txt", "1000_5_analysis.txt", "1000_10_analysis.txt", "1000_30_analysis.txt", "3162_1_analysis.txt", "3162_100_analysis.txt", "3162_5_analysis.txt", "3162_10_analysis.txt", "3162_30_analysis.txt", "31622_1_analysis.txt", "31622_100_analysis.txt", "31622_5_analysis.txt", "31622_10_analysis.txt", "31622_30_analysis.txt"], "wildcards": {}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 2, "cluster": {"mem": 16000, "partition": "broadwl", "ntasks": 1, "tasks": 1, "mem-per-cpu": 2000, "output": "logs/analyze..out", "error": "logs/analyze..err", "job-name": "analyze."}}
 cd /home/evarol/Research/Research/lower_threshold_project && \
PATH='/software/python-3.7.0-el7-x86_64/bin':$PATH /software/python-3.7.0-el7-x86_64/bin/python \
-m snakemake 10000_1_analysis.txt --snakefile /home/evarol/Research/Research/lower_threshold_project/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp 10000_1.txt 10000_100.txt 10000_5.txt 10000_10.txt 10000_30.txt 1000_1.txt 1000_100.txt 1000_5.txt 1000_10.txt 1000_30.txt 3162_1.txt 3162_100.txt 3162_5.txt 3162_10.txt 3162_30.txt 31622_1.txt 31622_100.txt 31622_5.txt 31622_10.txt 31622_30.txt --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler greedy \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules analyze --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/2.jobfinished || (touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/2.jobfailed; exit 1)

