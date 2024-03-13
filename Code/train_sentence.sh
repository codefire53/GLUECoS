# Copyright (c) Microsoft Corporation. Licensed under the MIT license.

REPO=$PWD
TASK=${1:-Sentiment_EN_ES}
MODEL=${2:-bert-base-multilingual-cased}
MODEL_TYPE=${3:-bert}
DATA_DIR=${4:-"$REPO/Data/Processed_Data"}
TRAIN_FILE=${5:-"train.txt"}
VAL_FILE=${6:-"validation.txt"}
TEST_FILE=${7:-"test.txt"}
OUT_DIR=${8:-"$REPO/Results"}

EPOCH=5
BATCH_SIZE=16
MAX_SEQ=256

dir=`basename "$TASK"`
if [ $dir == "Devanagari" ] || [ $dir == "Romanized" ]; then
  OUT=`dirname "$TASK"`
else
  OUT=$TASK
fi

python $PWD/Code/BertSequence.py \
  --data_dir $DATA_DIR/$TASK \
  --train_data_file  $DATA_DIR/$TASK/$TRAIN_FILE \
  --val_data_file  $DATA_DIR/$TASK/$VAL_FILE \
  --test_data_file  $DATA_DIR/$TASK/$TEST_FILE \
  --output_dir $OUT_DIR/$OUT \
  --model_type $MODEL_TYPE \
  --model_name $MODEL \
  --num_train_epochs $EPOCH \
  --train_batch_size $BATCH_SIZE \
  --max_seq_length $MAX_SEQ \
  --save_steps -1