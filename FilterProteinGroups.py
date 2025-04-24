#!/bin/python3                                                                

#get arguments for database, a tsv file and a database a                      
import sys

if sys.argv != False:
        path=sys.argv[1]
else:
        print("No Path")
        exit

#open path to tsv and save the peptide names in an array                      
file = open(path)

n = 0
c = 0
collapse = 0
lengthcount =0
pvalcount = 0
alphcount = 0
geneid = "geneid"
pcount = 0
pvalue = 1
printline = "0"
check = 0
alphcount=0

#look through the file, print first line, check if the gene id matches (column 2) if it does, keep the one with the higher protein ocunt, if same keep the one with lowest p-value, if same keep the one with the lower RefSeq ID 

for line in file:
        if n == 0:
                l=line.strip("\n")
                print(l)
        if n > 0:
                l = line.strip("\n")
                l2 = l.split("\t")
                if geneid == l2[1]:
                        collapse = collapse+1
                        if check == 0:
                                c = c+1
                                check = 1
                        if pcount == l2[2]:
                                if pvalue != l2[15]:
                                        pvalcount = pvalcount+1
                                        if pvalue > l2[15]:
                                                printline = l2
                                                pvalue = l2[15]
                                else:
                                        alphcount = alphcount+1
                        
                        else:
                                lengthcount = lengthcount+1
                                if pcount < l2[2]:
                                        printline = l2
                                        pcount = l2[2]
                else:
                        if printline != "0":
                                print(printline)
                        check = 0
                        geneid = l2[1]
                        pcount = l2[2]
                        pvalue = l2[15]
                        printline = l2
                
        n=n+1
print(printline)
print("Total proteins that were collapsed into =", c)
print("Proteins collapsed because of length =", lengthcount)
print("Proteins collapsed because of pvalue =", pvalcount)
print("Proteins collapsed because of alphabetical order =", alphcount)
print("Total proteins that were removed =", collapse)
