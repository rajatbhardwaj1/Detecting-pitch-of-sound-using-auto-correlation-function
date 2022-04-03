% We have consider both the ways to have the initial audio file that is
% using any pre existing audio as well as recording real time audio.
loadOrRecord = input(['If you want to use a pre-existing .wav file, Enter 1. ' ...
    'If you want to record any audio, Enter 2 '])

fs = 10000;   %fs is sampling frequency


if (loadOrRecord == 1)
    filename = input('Enter filename ');  %if a pre- existing file is used
else 
    duration = input('Enter the duration of the speech ');
    recorder = audiorecorder(fs,8,1); %used to record audio
    disp('start recording');
    recordblocking(recorder,duration); % stops recorder after 'duration' sec
    disp('Recording finished');
    play(recorder);   %to hear the recorded audio
    y = getaudiodata(recorder);  %stores the audio data in y
    filename = 'speech.wav';   %gives name to the audio file
    audiowrite(filename,y,10000);  %write the audio file
    info = audioinfo(filename);  %gives the information about the audio
    disp(info);
end 

% Plotting audio signal
[y,fs] = audioread(filename);
figure(1);
subplot(3,1,1)
plot(y);
title('speech signal');
ylabel('amplitude');
xlabel('sample number');


%Using in-built autocorrelation function to get the autocorrelation plot
[amplitude,sample_number_lag] = xcorr(y);
subplot(3,1,2)
plot(sample_number_lag,amplitude);
title('Autocorrelation plot');
ylabel('amplitude');
xlabel('sample number lag');


% filters the peaks from the autocorrelation plot
[amplitude,peak_sample_number] = findpeaks(amplitude,'MinPeakDistance',10);
subplot(3,1,3)
plot(peak_sample_number,amplitude);
title('Autocorrelation - Peak plot');
ylabel('amplitude_peaks');
xlabel('sample number lag');


% Pitch Calculation
TimePeriod = mean(diff(peak_sample_number))/fs;
Pitch = 1/TimePeriod;
disp('Pitch of the Audio signal is: ')
disp(Pitch);

% Below are a few more things we can display to get a better idea of the
% pitch (can removw percentage and get the result)

%maximum = max(diff(peak_sample_number))/fs;
%minimum = min(diff(peak_sample_number))/fs;
%disp(maximum);
%disp(minimum);