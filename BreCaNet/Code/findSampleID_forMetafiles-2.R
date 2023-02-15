# from Dr. Camila Lopes-Ramos

# This reads a GDC manifest file and output sample IDs
# Found tutorial on https://www.biostars.org/p/215175/
# Had to update based on the new GDC host website https://docs.gdc.cancer.gov/API/Users_Guide/Search_and_Retrieval/
# I ran on my laptop because the server cannot verify the website is secure and fails to run the curl command

setwd("~/Desktop/BreCaNet/Data/")
#setwd("/jqlab/camila/tcga/mirna")
manifest="gdc_manifest_20191011_142215.txt"

x=read.table(manifest,header = T)
manifest_length= nrow(x)
id= toString(sprintf('"%s"', x$id))

Part1= '{"filters":{"op":"in","content":{"field":"files.file_id","value":[ '
Part2= '] }},"format":"TSV","fields":"file_id,file_name,cases.submitter_id,cases.case_id,data_category,data_type,cases.samples.tumor_descriptor,cases.samples.tissue_type,cases.samples.sample_type,cases.samples.submitter_id,cases.samples.sample_id,cases.samples.portions.analytes.aliquots.aliquot_id,cases.samples.portions.analytes.aliquots.submitter_id,project_id","size":'
Part3= paste(shQuote(manifest_length,type="cmd"),"}",sep="")
Sentence= paste(Part1,id,Part2,Part3, collapse=" ")
write.table(Sentence,"Payload.txt",quote=F,col.names=F,row.names=F)

# This second part is in the command line (CMD or terminal)
# cd C:/Here/your/manifest/directory
# curl --request POST --header "Content-Type: application/json" --data @Payload.txt 'https://api.gdc.cancer.gov/files' > File_metadata.txt -k


