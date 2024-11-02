TRAINING DATA

Columns:
chr, start, end (optional) : SNP location in hg38 coordinates.
gene : Gene in Ensembl ID.
pli : Probability of Loss Intolerance for gene score from gnomad. Higher score indicates more conserved.
cts : Log Fold Change for a cell-type specific gene from Tabula Sapiens, Cell Atlas. Higher logFC indicates the gene is expressed more exclusively in a CT.
dist : Distance of SNP from gene TSS in bp. Negative distance indicates the SNP is downstream the TSS.

1. gtex_susie.tsv.gz
- Technology: eQTL
- Description: GTEx data analyzed by SuSIE method
- Recommended metric: pip
- Source: Finucane Lab Website

2. pops_eval.tsv.gz
- Technology: GWAS
- Description: Curated SNP-gene-trait list used in PoPs and cS2G methods. 
- Recommended metric: pops_score (see Weeks et al. Nat Gen 2023)
- Source: Gazal et al. Nat Gen 2022, Data availability

3. pgb_constituents.tsv.gz
- Technology: Enhancer-gene (Multiomics)
- Description: Scores for multiple Multiomics analysis, overlapped with SNP data for pgBoost method (Dorans et al.)
- Recommended metric: SCENT (SCENT FDR level, see Sakaue et al. Nat Gen 2024)
- Source: Dorans et al. medRxiv 2024
