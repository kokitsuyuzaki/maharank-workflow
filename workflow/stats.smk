import pandas as pd
from snakemake.utils import min_version

#
# Setting
#
min_version("7.20.0")
container: 'docker://koki/tensor-projects-plasmids:20211018'

FILES = pd.read_csv('data/truepairs.txt', header=None,
    dtype='string', sep='|', usecols=[0])[0]

rule all:
    input:
        expand('data/{f}/stats.csv', f=FILES)

rule stats:
    output:
        'data/{f}/stats.csv'
    resources:
        mem_gb=50
    benchmark:
        'benchmarks/stats_{f}.txt'
    log:
        'logs/stats_{f}.log'
    shell:
        'src/stats.sh {wildcards.f} {output} >& {log}'
