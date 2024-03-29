#!/bin/bash

MODEL=g2s_series_rel

EXP_NO=1
DATASET=USPTO_480k
#CHECKPOINT=./checkpoints/pretrained/USPTO_50k_dgcn.pt
CHECKPOINT=./checkpoints/USPTO_480k_g2s_series_rel_smiles_smiles.1/model.95000_18.pt
BS=30
T=1.0
NBEST=30
MPN_TYPE=dgat

REPR_START=smiles
REPR_END=smiles

PREFIX=${DATASET}_${MODEL}_${REPR_START}_${REPR_END}

python predict.py \
  --do_predict \
  --do_score \
  --model="$MODEL" \
  --data_name="$DATASET" \
  --test_bin="./preprocessed/$PREFIX/test_0.npz" \
  --test_tgt="./data/$DATASET/tgt-test.txt" \
  --result_file="./results/predict.result.95000.txt" \
  --log_file="$PREFIX.predict.$EXP_NO.log" \
  --load_from="$CHECKPOINT" \
  --mpn_type="$MPN_TYPE" \
  --rel_pos="$REL_POS" \
  --seed=42 \
  --batch_type=tokens \
  --predict_batch_size=4096 \
  --beam_size="$BS" \
  --n_best="$NBEST" \
  --temperature="$T" \
  --predict_min_len=1 \
  --predict_max_len=512 \
  --log_iter=100
