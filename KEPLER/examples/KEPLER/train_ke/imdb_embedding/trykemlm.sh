TOTAL_UPDATES=125000    # Total number of training steps
WARMUP_UPDATES=10000    # Warmup the learning rate over this many updates
PEAK_LR=0.0005          # Peak learning rate, adjust as needed
TOKENS_PER_SAMPLE=512   # Max sequence length
MAX_POSITIONS=512       # Num. positional embeddings (usually same as above)
MAX_SENTENCES=6        # Number of sequences per batch (batch size)
UPDATE_FREQ=16          # Increase the batch size 16x
#MODEL="~/projekt/models/keplerModel/ke/model.pt"
MODEL="ke.pt"
CHECKPOINT_PATH="mlm_ke"
KE=k2data
DATA_DIR=$KE/IMDb2_0:$KE/IMDb2_1:$KE/IMDb2_2:$KE/IMDb2_3:$KE/IMDb2_4:$KE/IMDb2_5:$KE/IMDb2_6:$KE/IMDb2_7:$KE/IMDb2_8:$KE/IMDb2_9

fairseq-train $DATA_DIR \
    --restore-file $MODEL \
    --save-dir $CHECKPOINT_PATH --reset-optimizer\
    --task masked_lm --criterion masked_lm \
    --arch roberta_base --sample-break-mode complete --tokens-per-sample $TOKENS_PER_SAMPLE \
    --optimizer adam --adam-betas '(0.9, 0.98)' --adam-eps 1e-6 --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $PEAK_LR --warmup-updates $WARMUP_UPDATES --total-num-update $TOTAL_UPDATES \
    --dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
    --max-sentences $MAX_SENTENCES --update-freq $UPDATE_FREQ \
    --max-update $TOTAL_UPDATES --log-format simple --log-interval 1 --ddp-backend=no_c10d
