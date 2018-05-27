clear all

audio_file = 'G:\neckcap\1208\audio\D1208_trimmed.wav';
out_dir = 'G:\neckcap\1208\audio\coeff';

mkdir(out_dir);
[b0,a,p,v] = LPCSR_AnalysisAudio(audio_file, 256, 128, 32);

% Save binary
save(strcat(out_dir,'\coeff.mat'));

% Save LPC coeff
fid = fopen(strcat(out_dir, '\lpc_coeff.txt'), 'wt');
fprintf(fid, '%d\n', size(a, 2));
for i = 1:size(a,2)
    fprintf(fid, '%d\n', size(a,1)-1);
    fprintf(fid, '%f\n', a(2:end,i));
end
fclose(fid);

% Save b0
fid = fopen(strcat(out_dir, '\b0.txt'), 'wt');
fprintf(fid, '%d\n', size(b0, 2));
fprintf(fid, '%f\n', b0);
fclose(fid);

% Save pitch
fid = fopen(strcat(out_dir, '\pitch.txt'), 'wt');
fprintf(fid, '%d\n', size(p, 2));
fprintf(fid, '%d\n', p);
fclose(fid);

% Save V
fid = fopen(strcat(out_dir, '\voiced.txt'), 'wt');
fprintf(fid, '%d\n', size(v, 2));
fprintf(fid, '%d\n', v);
fclose(fid);
