#!/bin/sh

cd /camp/lab/luscomben/home/users/iosubi/projects/comp_hiclip/nonhybrids/rnafold_forgi_peaks_10nt_10nt

# Annotate peaks


# RNAplfold (3'UTRs of STAU1-bound tranacripts)
./run_rnaplfold.R -b stau1_high.10nt_10nt.peaks.bed.gz.annot.bed.gz,stau1_low.10nt_10nt.peaks.bed.gz.annot.bed.gz -t gencode_V33_txdb.sqlite -p stau1

# Generate RNAplfold unpaired probability metaprofile (-100nt and +100nt window)
./get_structure_metaprofile.R --bed=stau1_high.10nt_10nt.peaks.bed.gz.annot.bed.gz,stau1_low.10nt_10nt.peaks.bed.gz.annot.bed.gz --prob=stau1_threeutrs.rnaplfold.bed,stau1_threeutrs.rnaplfold.shuffled.bed --prefix=stau1

# Cluster RNAplfold probability profiles
./cluster_probability_profiles.R -p stau1_threeutrs.rnaplfold_prob.df.txt -s stau1_threeutrs.rnaplfold.shuffled_prob.df.txt -c 5

# run RNAfold and annotate structures with forgi for all STAU1 peaks
./run_rnafold.R -b stau1_high.10nt_10nt.peaks.bed.gz.annot.bed.gz,stau1_low.10nt_10nt.peaks.bed.gz.annot.bed.gz -p stau1

# Analyse structure annotions for the 3'UTR peaks with predicted stems downstream according to RNAplfold (in the"stau1_threeutrs.rnaplfold_prob_clusters.df.txt" output from steps above)
