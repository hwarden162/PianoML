process TrainModel{
    conda "${projectDir}/envs/env.yml"

    input:
        path training_data

    output:
        path run_dir

    script:
        """
        polyphony_rnn_train \
        --run_dir=run_dir \
        --sequence_example_file=${training_data} \
        --hparams="batch_size=64,rnn_layer_sizes=[128,128,128]" \
        --num_training_steps=10000
        """
}