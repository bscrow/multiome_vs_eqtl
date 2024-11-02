import pandas as pd
import glob
from scipy.stats import false_discovery_control

scent_genelist = pd.read_csv(
    "../SCENT/GeneBody_500kb_margin.bed", 
    header=None, sep="\t", index_col=False, 
    names=["chr", "cis_start", "cis_end", "scent_gene"]
)

onek1k_files = glob.glob("../onek1k/*.gz")

df = pd.read_csv("/projects/zhanglab/users/ana/multiome/validation/gentruth/data/onek1k_ciseqtl.tsv.gz", sep="\t", compression="gzip", nrows=1)
colnames = df.columns.tolist()

for f in onek1k_files:
    print(f, flush=True)
    onek1k = pd.read_csv(f, sep="\t", compression="gzip", names=colnames)
    onek1k_subset = onek1k.merge(scent_genelist, left_on="GENE", right_on="scent_gene", how="inner")
    onek1k_subset = onek1k_subset[
        (onek1k_subset["start"]>=onek1k_subset["cis_start"]) & 
        (onek1k_subset["end"]<=onek1k_subset["cis_end"]) 
    ]
    onek1k_subset["NEW_Q"] = onek1k_subset.groupby("GENE")["P_VALUE"].transform(false_discovery_control)
    n_genes = onek1k_subset["GENE"].nunique()
    print(onek1k.shape, n_genes, flush=True)

    onek1k_subset = onek1k_subset[onek1k_subset["NEW_Q"] < 0.1].copy()
    onek1k_enhancers = onek1k_subset[onek1k_subset["SPEARMANS_RHO"] > 0]
    onek1k_silencers = onek1k_subset[onek1k_subset["SPEARMANS_RHO"] < 0]
    cell_type = f.split(".")[0]
    onek1k_enhancers.to_csv(f"../outputs/onek1k_enhancers_fdr0.1/{cell_type}_{n_genes}genes.csv")
    onek1k_silencers.to_csv(f"../outputs/onek1k_silencers_fdr0.1/{cell_type}_{n_genes}genes.csv")
    del onek1k
    del onek1k_subset