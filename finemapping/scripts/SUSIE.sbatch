#!/bin/bash
#
#$ -j y
#$ -S /bin/bash
#$ -cwd

## the next line selects the partition/queue
#SBATCH -p mzhang

## the next line selects the number of cores
#SBATCH -n 16

#SBATCH -c 1

## the next line selects the memory size
#SBATCH --mem-per-cpu=11G

## specify the location of our output log
#SBATCH -o CPU_ARRAY%A_%a.out

#SBATCH --time=4-03:00:00

## Submit a job array with index values between
#SBATCH --array=0-199%50

RANDOM_SEEDS_ROOT=2025
echo "random seeds root: $RANDOM_SEEDS_ROOT"
export RANDOM_SEED=$((RANDOM_SEEDS_ROOT+$SLURM_ARRAY_TASK_ID))
echo "random seed: $RANDOM_SEED"


scenario_type="FPR"
effect_size="large"

echo "scenario: $scenario_type"
dir_scenario_Y=$scenario_type
echo "dir scenario level: $dir_scenario_Y"

dir_scenario_to=$scenario_type
mkdir $dir_scenario_to


export dir_direct_size_Y=$dir_scenario_Y/$effect_size

echo "dir direct size Y: $dir_direct_size_Y"

export dir_size_to=$dir_scenario_to/$effect_size

mkdir $dir_size_to

source activate r-pure
export addr_X=$dir_direct_size_Y/X_G_$RANDOM_SEED
export addr_Y=$dir_direct_size_Y/Y_$RANDOM_SEED
export addr_to=$dir_size_to/RD_$RANDOM_SEED
mkdir $addr_to


addr_w=SUSIE_direct_$RANDOM_SEED.csv


Rscript SUSIE_regressor.R $addr_to $addr_X $addr_Y $addr_w