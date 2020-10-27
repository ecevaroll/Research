#!/bin/sh
# properties = {"type": "single", "rule": "plot", "local": false, "input": ["summary.csv"], "output": ["plot.png"], "wildcards": {}, "params": {}, "log": [], "threads": 1, "resources": {}, "jobid": 0, "cluster": {"mem": 16000, "partition": "broadwl", "ntasks": 1, "tasks": 1, "mem-per-cpu": 2000, "output": "logs/plot..out", "error": "logs/plot..err", "job-name": "plot."}}
 cd /home/evarol/Research/Research/lower_threshold_project && \
PATH='/software/python-3.7.0-el7-x86_64/bin':$PATH /software/python-3.7.0-el7-x86_64/bin/python \
-m snakemake plot --snakefile /home/evarol/Research/Research/lower_threshold_project/Snakefile \
--force -j --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp summary.csv --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler greedy \
\
\
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules plot --nocolor --notemp --no-hooks --nolock \
--mode 2  && touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/0.jobfinished || (touch /home/evarol/Research/Research/lower_threshold_project/.snakemake/tmp.mzpd3kzp/0.jobfailed; exit 1)

