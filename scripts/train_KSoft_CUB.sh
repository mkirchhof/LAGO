#!/bin/bash

unset outbase
unset experiment_basedir
unset trainlog_filename
unset data_dir
unset data_loader
unset SG_psi
unset LG_uniformPa
unset attributes_weight
unset LG_true_compl_x
unset batch_size

test_set=1
num_repeats=${num_repeats:-10} # default value is 10 repeatitions

dataset=CUB
modelname=KSoft
lr=3e-05
max_epochs=160
beta=0.00001
lambda=0.00001
SG_gain=1
SG_num_K=30
SG_lr=1


if [[ "$num_repeats" =~ ^[0-9]+$ ]] && # check valid non-zero integer
    [ "$num_repeats" -ge 1 -a "$num_repeats" -le 20 ]; then # check if in [1..20]
    echo
else
    echo "Usage example: num_repeats=5 source $BASH_SOURCE"
    echo "\$num_repeats indicates how many times to repeat the experiment. "
    echo "Number of repeatitions can be in 1 to 9. "
    echo "The reported results in the paper are averaged across 5 repeatitions."

    return 1
fi

echo "Training on $dataset with $modelname for $num_repeats repeatitions. is_test_set=$test_set"

for (( rpt=0; rpt<$num_repeats; rpt+=1 ));
do
    source scripts/train.sh
done
