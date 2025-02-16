#!/bin/bash

# Set common variables
model="decapoda-research/llama-7b-hf"
# model="/data/anyongqi/wanda/llm_weights/mlp0.5_llama_7b"
sparsity_ratio=0.418
remove_heads=64
cuda_device=$1

# Set CUDA device visibility
export CUDA_VISIBLE_DEVICES=$cuda_device

# Define function to run python command
run_python_command () {
    /data/anyongqi/miniconda3/envs/prune_llm/bin/python3.9 main_old.py \
    --model $model \
    --prune_method $1 \
    --sparsity_ratio $sparsity_ratio \
    --remove_heads $remove_heads \
    --sparsity_type $2 \
    --save $3 \
    --mode per-out \
    --nsamples 1024 \
    --save_model llm_weights/ns1024_seq128_rh${remove_heads}_mlp${sparsity_ratio}_llama_7b/
}

# llama-7b with bias_unify pruning method
echo "Running with unify pruning method"
run_python_command "unify" "unstructured" "out/llama_7b/structured/unify_$sparsity_ratio/"

# # llama-7b with wanda_sp pruning method
# echo "Running with wanda_sp pruning method"
# run_python_command "wanda_sp" "unstructured" "out/llama_7b/unstructured/wanda_sp_$sparsity_ratio/"

# # llama-7b with skill pruning method
# echo "Running with skill pruning method"
# run_python_command "skill" "unstructured" "out/llama_7b/unstructured/skill_$sparsity_ratio/"

# # llama-7b with wanda pruning method
# echo "Running with wanda++ pruning method"
# run_python_command "wanda++" "unstructured" "out/llama_7b/unstructured/wanda_plus_$sparsity_ratio/"

# # llama-7b with taylor pruning method
# echo "Running with taylor pruning method"
# run_python_command "taylor" "unstructured" "out/llama_7b/unstructured/taylor/"

# # llama-7b with weightedobs pruning method
# echo "Running with weightedobs pruning method"
# run_python_command "weightedobs" "unstructured" "out/llama_7b/unstructured/weighteobs/"

# # llama-7b with wanda pruning method
# echo "Running with wanda pruning method"
# run_python_command "wanda" "unstructured" "out/llama_7b/unstructured/wanda_$sparsity_ratio/"
# run_python_command "wanda" "2:4" "out/llama_7b/2-4/wanda/"
# run_python_command "wanda" "4:8" "out/llama_7b/4-8/wanda/"
# echo "Finished wanda pruning method"

# # llama-7b with sparsegpt pruning method
# echo "Running with sparsegpt pruning method"
# run_python_command "sparsegpt" "unstructured" "out/llama_7b/unstructured/sparsegpt/"
# run_python_command "sparsegpt" "2:4" "out/llama_7b/2-4/sparsegpt/"
# run_python_command "sparsegpt" "4:8" "out/llama_7b/4-8/sparsegpt/"
# echo "Finished sparsegpt pruning method"

# # llama-7b with magnitude pruning method
# echo "Running with magnitude pruning method"
# run_python_command "magnitude" "unstructured" "out/llama_7b/unstructured/magnitude/"
# run_python_command "magnitude" "2:4" "out/llama_7b/2-4/magnitude/"
# run_python_command "magnitude" "4:8" "out/llama_7b/4-8/magnitude/"
# echo "Finished magnitude pruning method"