process MidiToNoteSequence{
    conda "${projectDir}/envs/env.yml"
    
    input:
        file files

    output:
        file "note_sequences.tfrecord"

    script:
        """
        convert_dir_to_note_sequences \
            --input_dir=. \
            --output_file=note_sequences.tfrecord \
            --recursive
        """
}