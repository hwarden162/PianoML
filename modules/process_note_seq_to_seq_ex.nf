process NoteSeqToSeqEx{
    conda "${projectDir}/envs/env.yml"

    input:
        file note_seq
    
    output:
        path "training_poly_tracks.tfrecord", emit: training
        path "eval_poly_tracks.tfrecord", emit: eval

    script:
        """
        polyphony_rnn_create_dataset \
        --input=${note_seq} \
        --output_dir=. \
        --eval_ratio=0.10
        """
}