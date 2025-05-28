#import necessary libraries
import pandas as pd
import gseapy as gp
import matplotlib.pyplot as plt
import csv
from collections import defaultdict 

#Load in MF ontology terms
#awk '$9=="F" {print $3"\t"$5}' /vulpine/FoxGenomeBrian/321/ncbi_dataset/data/GCF_048418805.1/GCF_048418805.1-RS_2025_03_gene_ontology.gaf | sort | uniq > MFGOTerms.txt
MFdavid=defaultdict(list) 
with open('MFGOTerms.gmt', 'r') as termfile:
	terms = csv.reader(termfile, delimiter='\t')
	for line in terms:
		MFdavid[line[1]].append(line[0])
#Load in BP ontology terms
#awk '$9=="P" {print $3"\t"$5}' /vulpine/FoxGenomeBrian/321/ncbi_dataset/data/GCF_048418805.1/GCF_048418805.1-RS_2025_03_gene_ontology.gaf | sort | uniq > BPGOTerms.txt
BPdavid=defaultdict(list) 
with open('BPGOTerms.gmt', 'r') as termfile:
	terms = csv.reader(termfile, delimiter='\t')
	for line in terms:
		BPdavid[line[1]].append(line[0])
#Load in CC ontology terms
#awk '$9=="C" {print $3"\t"$5}' /vulpine/FoxGenomeBrian/321/ncbi_dataset/data/GCF_048418805.1/GCF_048418805.1-RS_2025_03_gene_ontology.gaf | sort | uniq > CCGOTerms.txt
CCdavid=defaultdict(list) 
with open('CCGOTerms.gmt', 'r') as termfile:
	terms = csv.reader(termfile, delimiter='\t')
	for line in terms:
		CCdavid[line[1]].append(line[0])

#Load in generic library terms
names = gp.get_library_name()
kegg = gp.get_library(name='KEGG_2021_Human')
gobp = gp.get_library(name='GO_Biological_Process_2023')
gocc = gp.get_library(name='GO_Cellular_Component_2023')
gomf = gp.get_library(name='GO_Molecular_Function_2023')
ract = gp.get_library(name='Reactome_2022')
gosy = gp.get_library(name='SynGO_2022')
wiki = gp.get_library(name='WikiPathways_2019_Human')

phe0 = gp.get_library(name='MGI_Mammalian_Phenotype_Level_4_2021')
phe1 = gp.get_library(name='Human_Phenotype_Ontology')
phe2 = gp.get_library(name='KOMP2_Mouse_Phenotypes_2022')
phe3 = gp.get_library(name='PheWeb_2019')
phe4 = gp.get_library(name='PhenGenI_Association_2021')

#read in my list of DE terms - this will change depending on analysis
with open("AvsDE.gmt", "r") as f:
    genelist = [line.strip() for line in f if line.strip()]

#Load in Background list
with open("Background.gmt", "r") as f:
    flat_background = [line.strip() for line in f if line.strip()]

genesets=kegg

#run enrichr analysis
gotest = gp.enrichr(gene_list=genelist, gene_sets=genesets,  background=flat_background)

#Check results
a= gotest.results.Gene_set.str.replace('gs_ind_0', 'genesets', regex=False)
gotest.results.Gene_set=a

print(gotest.results.sort_values("Adjusted P-value"))

results_df = gotest.res2d
results_df.to_csv("AvsCKEGG_results.csv")


