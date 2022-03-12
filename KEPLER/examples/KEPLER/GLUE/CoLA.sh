TOTAL_NUM_UPDATES=10336  
WARMUP_UPDATES=520      
LR=5e-05    
NUM_CLASSES=2
MAX_SENTENCES=64        # Batch size.
ROBERTA_PATH=path_to_KEPLER_original_checkpoint

fairseq-train CoLA-bin/ \
    --restore-file $ROBERTA_PATH \
    --max-positions 512 \
    --save-dir CoLA-ckpt \
    --max-sentences $MAX_SENTENCES \
    --max-tokens 8800 \
    --task sentence_prediction \
    --reset-optimizer --reset-dataloader --reset-meters \
    --required-batch-size-multiple 1 \
    --init-token 0 --separator-token 2 \
    --arch roberta_base \
    --criterion sentence_prediction \
    --num-classes $NUM_CLASSES \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.1 --optimizer adam --adam-betas "(0.9, 0.98)" --adam-eps 1e-06 \
    --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $LR --total-num-update $TOTAL_NUM_UPDATES --warmup-updates $WARMUP_UPDATES \
    --fp16 --fp16-init-scale 4 --threshold-loss-scale 1 --fp16-scale-window 128 \
    --max-epoch 20 \
    --find-unused-parameters \
    --best-checkpoint-metric accuracy --maximize-best-checkpoint-metric;