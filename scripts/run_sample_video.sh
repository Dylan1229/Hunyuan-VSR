#!/bin/bash
#SBATCH -J Test_HunyuanVideo
#SBATCH -p hopper
#SBATCH -A r01156
#SBATCH -o /N/slate/fanjye/repo/VSR_project/HunyuanVideo/scripts/shell_logs/Test_HunyuanVideo_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00


module load conda
conda activate /N/slate/fanjye/condaenv/HunyuanVideo
module load cudatoolkit/11.8
cd /N/slate/fanjye/repo/VSR_project/Hunyuan-VSR

set -x
# Use Nsight System profile
# nsys profile --output=/N/slate/fanjye/repo/VSR_project/HunyuanVideo/scripts/profile_result/Singlegpu_inferstep-1 \
#     python3 sample_video.py \
#         --video-size 720 1280 \
#         --video-length 129 \
#         --infer-steps 50 \
#         --prompt "A cat walks on the grass, realistic style." \
#         --seed 42 \
#         --embedded-cfg-scale 6.0 \
#         --flow-shift 7.0 \
#         --flow-reverse \
#         --use-cpu-offload \
#         --save-path ./results
python3 sample_video.py \
    --video-size 720 1280 \
    --video-length 129 \
    --infer-steps 50 \
    --prompt "A cat walks on the grass, realistic style." \
    --seed 42 \
    --embedded-cfg-scale 6.0 \
    --flow-shift 7.0 \
    --flow-reverse \
    --use-cpu-offload \
    --save-path ./results
