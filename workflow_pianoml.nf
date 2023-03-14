#!/usr/bin/env nextflow
nextflow.enable.dsl = 2

include { YTToMPThree } from './modules/process_yt_to_mpthree.nf'
include { MPThreeToWav } from './modules/process_mpthree_to_wav.nf'
include { WAVToMIDI } from './modules/process_wav_to_midi.nf'
include { CollectMidis } from './modules/process_collect_midis.nf'
include { MidiToNoteSequence } from './modules/process_midi_to_note_sequence.nf'
include { NoteSeqToSeqEx } from './modules/process_note_seq_to_seq_ex.nf'
include { TrainModel } from './modules/process_train_model.nf'

ch_urls = Channel.from("https://www.youtube.com/watch?v=7maJOI3QMu0", "https://www.youtube.com/watch?v=P2K7D-uMH2g", "https://www.youtube.com/watch?v=GJWU2Y_tGRk")
ch_urls = ch_urls
    .multiMap {it -> 
        sample_id: UUID.randomUUID().toString() 
        url: it
    }

workflow {
    YTToMPThree(ch_urls.sample_id, ch_urls.url)
    ch_mpthrees = YTToMPThree.out
    
    MPThreeToWav(ch_mpthrees.sample_id, ch_mpthrees.mpthree_file)
    ch_wavs = MPThreeToWav.out

    ch_midi = WAVToMIDI(ch_wavs.sample_id, ch_wavs.wav_file).collect()

    ch_note_seq = MidiToNoteSequence(ch_midi)

    NoteSeqToSeqEx(ch_note_seq)
    ch_seq_ex = NoteSeqToSeqEx.out

    ch_run_dir = TrainModel(ch_seq_ex.training)
}

