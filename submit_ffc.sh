#!/bin/sh
#$ -V
#$ -cwd
#$ -pe mpi 24 # threads * num of parloop
#$ -l mem_total=20G # num of parloop * 2G 
#$ -N FFC
#$ -M mohammadaamir.abbasi@cshs.org
#$ -m ae
matlab -nodisplay -nosplash -r "cd /common/abbasim/code/;parloop_coherence(1);exit"