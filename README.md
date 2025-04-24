# Proteomics

Result file (prolist) obtained from IP2
Contaminants and Reversed results were removed
All the proteins with a result missing in any of the 16 samples were removed (NoNA)

t Test
Run t test for each protein for each comparison (Tame vs Conventional, Tame vs Aggressive, Aggressive vs Conventional) from NoNA
Run results with p-value through FilterProteinGroups.py to sort into protein groups (Accession in alphabetical order Gene IDs in alphabetical order and prioritized over accession)
Redo t tests with protein groups
P values from protein groups corrected with BenjHochs.R

Kruskall Wallice Test
Run NoNA through KruskallWallis.R and add results to file
Run results for KWFilterProteinGroups
Rerun KW protein groups through KruskallWallis.R
Add results to file
