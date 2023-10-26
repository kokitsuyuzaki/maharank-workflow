# maharank-workflow
Snakemake workflow to generate the reference files for MahaRank

This workflow consists of XXXX workflows as follows:

- **workflow/identifier.smk**: ID retreival

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/identifier.png)

- **workflow/download.smk**: Data download

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/download.png)

- **workflow/divide_plasmid_host.smk**: Dividing plasmid/host amino acids sequences

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/divide_plasmid_host.png)

- **workflow/stats.smk**: Some statistics such as length and GC contents of amino acids sequences

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/stats.png)

- **workflow/rho.smk**: k-mer

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/rho.png)

- **workflow/reference.smk**: Reference files (`reference.tar.gz`, `reference_slim.tar.gz`)

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/reference.png)

- **workflow/distance.smk**: Distance calculation

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/distance.png)

- **workflow/roc.smk**: ROC/AUC analysis

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/roc.png)

- **workflow/plot.smk**: Plot of ROC/AUC analysis

![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/plot.png)


# Requirements
- Bash: GNU bash, version 4.2.46(1)-release (x86_64-redhat-linux-gnu)
- Snakemake: 7.20.0
- Singularity: 3.9.2

# Summary
![](https://github.com/kokitsuyuzaki/maharank-workflow/blob/main/plot/auc.png)

#

# How to reproduce this workflow
In local machine:

```
snakemake -s workflow/identifier.smk -j 4 --use-singularity
snakemake -s workflow/download.smk -j 4 --use-singularity
snakemake -s workflow/divide_plasmid_host.smk -j 4 --use-singularity
snakemake -s workflow/stats.smk -j 4 --use-singularity
snakemake -s workflow/rho.smk -j 4 --use-singularity
snakemake -s workflow/reference.smk -j 4 --use-singularity
snakemake -s workflow/distance.smk -j 4 --use-singularity
snakemake -s workflow/roc.smk -j 1 --use-singularity
snakemake -s workflow/plot.smk -j 1 --use-singularity
```

In parallel environment (GridEngine):

```
snakemake -s workflow/identifier.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/download.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/divide_plasmid_host.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/stats.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/rho.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/reference.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/distance.smk -j 32 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
snakemake -s workflow/roc.smk -j 1 --cluster "qsub -l nc=4 -p -50 -r yes -q large.q" --latency-wait 2000 --use-singularity
snakemake -s workflow/plot.smk -j 1 --cluster "qsub -l nc=4 -p -50 -r yes -q node.q" --cluster-cancel qdel --latency-wait 2000 --use-singularity
```

In parallel environment (Slurm):

```
snakemake -s workflow/identifier.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/download.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/divide_plasmid_host.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/stats.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/rho.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/reference.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/distance.smk -j 32 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/roc.smk -j 1 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
snakemake -s workflow/plot.smk -j 1 --cluster sbatch --cluster-cancel scancel --latency-wait 2000 --use-singularity
```

# License
Copyright (c) 2023 Koki Tsuyuzaki [Artistic License 2.0](http://www.perlfoundation.org/artistic_license_2_0).

# Authors
- Koki Tsuyuzaki