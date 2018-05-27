function [b0, a, pitch, v] = LPCSR_AnalysisAudio(audio_file, frame_size, step, LPC_order)
%LPCSR_ANALYSISAUDIO Do Analysis for each overlapping frame
%   Detailed explanation goes here
%   audio_file: .wav file
%   frame_size: each frame to do LPC. In samples.
%   step: Step between two frames. Should be smaller than frame_size so the
%   frames are overlapped. In samples.
%   LPC_order: Order of LPC formants

[y, Fs] = audioread(audio_file);
nTotal = size(y,1);
assert(step < frame_size)
nFrame = ceil((nTotal-frame_size)/step + 1)
nPadding = (nFrame-1)*step + frame_size - nTotal
if (nPadding > 0)
    y = [y; zeros(nPadding,1)];
end

b0 = zeros(1, nFrame);
a = zeros(LPC_order+1, nFrame);
pitch = zeros(1, nFrame);
v = zeros(1, nFrame);

for i = 1:nFrame
    start_sample = 1+(i-1)*step;
    end_sample = frame_size+(i-1)*step;
    [temp_b0,temp_a, temp_pitch,temp_v] = LPCSR_Analysis(y(start_sample:end_sample), Fs, frame_size, LPC_order);
    b0(i) = temp_b0;
    a(:,i) = temp_a;
    pitch(i) = temp_pitch;
    v(i) = temp_v;
end

end

