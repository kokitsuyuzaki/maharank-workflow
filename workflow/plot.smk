from snakemake.utils import min_version

#
# Setting
#
min_version("7.20.0")
container: 'docker://koki/tensor-projects-plasmids:20211018'

WORDSIZE = [str(x) for x in list(range(1, 7))]
TYPES = ['host', 'plasmid']

rule all:
    input:
        'plot/auc.png'

rule plot_auc:
    output:
        'plot/auc.png'
    resources:
        mem_gb=50
    benchmark:
        'benchmarks/plot_auc.txt'
    log:
        'logs/plot_auc.log'
    shell:
        'src/plot_auc.sh >& {log}'
