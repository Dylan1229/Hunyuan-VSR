#!/bin/bash
#SBATCH -J Test_HunyuanVideo
#SBATCH -p hopper
#SBATCH -A r01156
#SBATCH -o /N/slate/fanjye/repo/VSR_project/HunyuanVideo/scripts/shell_logs/Test_HunyuanVideo_multigpu_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gpus-per-node=4
#SBATCH --cpus-per-task=64
#SBATCH --time=2-00:00:00


# Supported Parallel Configurations
# |     --video-size     | --video-length | --ulysses-degree x --ring-degree | --nproc_per_node |
# |----------------------|----------------|----------------------------------|------------------|
# | 1280 720 or 720 1280 | 129            | 8x1,4x2,2x4,1x8                  | 8                |
# | 1280 720 or 720 1280 | 129            | 1x5                              | 5                |
# | 1280 720 or 720 1280 | 129            | 4x1,2x2,1x4                      | 4                |
# | 1280 720 or 720 1280 | 129            | 3x1,1x3                          | 3                |
# | 1280 720 or 720 1280 | 129            | 2x1,1x2                          | 2                |
# | 1104 832 or 832 1104 | 129            | 4x1,2x2,1x4                      | 4                |
# | 1104 832 or 832 1104 | 129            | 3x1,1x3                          | 3                |
# | 1104 832 or 832 1104 | 129            | 2x1,1x2                          | 2                |
# | 960 960              | 129            | 6x1,3x2,2x3,1x6                  | 6                |
# | 960 960              | 129            | 4x1,2x2,1x4                      | 4                |
# | 960 960              | 129            | 3x1,1x3                          | 3                |
# | 960 960              | 129            | 1x2,2x1                          | 2                |
# | 960 544 or 544 960   | 129            | 6x1,3x2,2x3,1x6                  | 6                |
# | 960 544 or 544 960   | 129            | 4x1,2x2,1x4                      | 4                |
# | 960 544 or 544 960   | 129            | 3x1,1x3                          | 3                |
# | 960 544 or 544 960   | 129            | 1x2,2x1                          | 2                |
# | 832 624 or 624 832   | 129            | 4x1,2x2,1x4                      | 4                |
# | 624 832 or 624 832   | 129            | 3x1,1x3                          | 3                |
# | 832 624 or 624 832   | 129            | 2x1,1x2                          | 2                |
# | 720 720              | 129            | 1x5                              | 5                |
# | 720 720              | 129            | 3x1,1x3                          | 3                |

export TOKENIZERS_PARALLELISM=false

export NPROC_PER_NODE=4
export ULYSSES_DEGREE=4
export RING_DEGREE=1

module load conda
conda activate /N/slate/fanjye/condaenv/HunyuanVideo
module load cudatoolkit/11.8
cd /N/slate/fanjye/repo/VSR_project/Hunyuan-VSR

set -x
# Use Nsight System profile
# nsys profile --gpu-metrics-device=all --cuda-memory-usage=true --output=/N/slate/fanjye/repo/VSR_project/HunyuanVideo/scripts/profile_result/Multigpu_inferstep-4 \
# 	torchrun --nproc_per_node=$NPROC_PER_NODE sample_video.py \
# 		--video-size 1280 720 \
# 		--video-length 129 \
# 		--infer-steps 5 \
# 		--prompt "A dancing Couple of cute Ghost, Night Spring ambience, pixar style." \
# 		--seed 42 \
# 		--embedded-cfg-scale 6.0 \
# 		--flow-shift 7.0 \
# 		--flow-reverse \
# 		--ulysses-degree=$ULYSSES_DEGREE \
# 		--ring-degree=$RING_DEGREE \
# 		--save-path ./results

# Use pytorch profiler
torchrun --nproc_per_node=$NPROC_PER_NODE sample_video.py \
	--video-size 1280 720 \
	--video-length 129 \
	--infer-steps 50 \
	--prompt "A cat walks on the grass, realistic style." \
	--seed 42 \
	--embedded-cfg-scale 6.0 \
	--flow-shift 7.0 \
	--flow-reverse \
	--ulysses-degree=$ULYSSES_DEGREE \
	--ring-degree=$RING_DEGREE \
	--save-path ./results