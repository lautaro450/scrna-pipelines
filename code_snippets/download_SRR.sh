while read accession; do
fasterq-dump $accession -O /mnt/faster/results/ --split-files --threads 16 -p
done < srr_accessions.txt
