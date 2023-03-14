process WAVToMIDI{
    conda "${projectDir}/envs/env.yml"

    input:
        val sample_id
        path file

    output:
        path "*.midi"

    script:
        """
        onsets_frames_transcription_transcribe \
        --model_dir="${projectDir}/models/wav_to_midi" \
        "${file}"
        """
}