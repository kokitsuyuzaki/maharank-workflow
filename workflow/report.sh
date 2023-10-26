# HTML
mkdir -p report
snakemake -s workflow/identifier.smk --report report/identifier.html
snakemake -s workflow/download.smk --report report/download.html
snakemake -s workflow/divide_plasmid_host.smk --report report/divide_plasmid_host.html
snakemake -s workflow/stats.smk --report report/stats.html
snakemake -s workflow/rho.smk --report report/rho.html
snakemake -s workflow/reference.smk --report report/reference.html
snakemake -s workflow/distance.smk --report report/distance.html
snakemake -s workflow/roc.smk --report report/roc.html
snakemake -s workflow/plot.smk --report report/plot.html
