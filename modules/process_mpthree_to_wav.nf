process MPThreeToWav{
    conda "${projectDir}/envs/env.yml"

    input:
        val sample_id
        path mpthree_file

    output:
        val sample_id, emit: sample_id
        path "${sample_id}.wav", emit: wav_file

    script:
        """
        ffmpeg -i ${mpthree_file} -acodec pcm_s16le -ac 1 -ar 16000 ${sample_id}.wav
        """
}