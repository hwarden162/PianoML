process YTToMPThree{
    conda "${projectDir}/envs/env.yml"

    input:
        val sample_id
        val url

    output:
        val sample_id, emit: sample_id
        path "${sample_id}.mp3", emit: mpthree_file

    script:
        """
        youtube-dl -x -f 'bestaudio' --audio-format mp3 --output ${sample_id}.mp3 "${url}"
        """
}