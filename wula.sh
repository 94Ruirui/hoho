#!/bin/bash

# 设置显卡负载的最低阈值
MIN_LOAD_THRESHOLD=10

# 无限循环，每60秒检查一次显卡负载
while true; do
  # 获取所有NVIDIA显卡的负载（%）
  gpu_loads=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)

  # 遍历每个显卡负载
  for load in $gpu_loads
  do
    if [ "$load" -lt "$MIN_LOAD_THRESHOLD" ]; then
      echo "GPU负载过低 ($load%), 重启所有挖矿软件..."
      # 重启矿机的命令
      miner restart
      break  # 找到低负载的显卡后停止继续检测
    fi
  done
  
  # 等待60秒后再检测一次
  sleep 60
done
