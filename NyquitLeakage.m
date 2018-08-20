%% Nyquist Criteria and Lekage---------------------------------------------
% Nyquist:  In order to recover all Fourier components of a periodic waveform,
%           it is necessary to use a sampling rate at least twice the highest
%           waveform frequency. The Nyquist frequency, also called the
%           Nyquist limit, is the highest frequency that can be coded at a
%           given sampling rate in order to be able to fully reconstruct
%           the signal.
%
% Lekage: happens when when the frequency bin is not capable to have a 
%         integer value, so the result will fluctuate
%
%--------------------------------------------------------------------------

figure
%Time domain representation-----------------------------------------
%Transmitted signal 
f = 10;                 %[Hz]  Frequency: number of cycles per second
T = 1/f;                %[s]   Period
pahse = deg2rad(45);    %[rad] Phase 
A = 10;                 %[V]   Amplitude: The maximum absolute value reached by a voltage or current waveform.
nc = 5;                 %number of cycles

%%-- Under Sampling
fs1 = 1.5*f;            %[Hz]  Sample frequency
Ts1 = 1/fs1;            %[s]   Sample period
t1 = (0:Ts1:nc*T);      %[s]   Sampling time 
%%-- Signal  
yt1 = A*sin(2*pi*f*t1 + pahse); 

%%-- Great Sampling
fs2 = 30*f;             %[Hz]  Sample frequency 
Ts2 = 1/fs2;            %[s]   Sample period
t2 = (0:Ts2:nc*T);      %[s]   Sampling time 
%%-- Signal  
yt2 = A*sin(2*pi*f*t2 + pahse); 

subplot(2,2,1)
plot(t2, yt2, 'b', 'LineWidth', 1.5)
title ('Time domain - above Nyquist frequency')
subplot(2,2,3)
plot(t1, yt1, 'r', 'LineWidth', 1.5)
title ('Time domain - below Nyquist frequency')
%--------------------------------------------------------------------


%Frequency domain representation-------------------------------------
%%-- Without Lekage - using the great frequency sampling
NFFT = 150;     %frequency bins DeltaF = SampleFreq/NFFT = (30*f)/150 = 2Hz
n = 1:1:NFFT;
Yf = (1/NFFT)*( fft(yt2, NFFT) );

%%-- With Lekage - using the great frequency sampling
NFFT_lekage = 512;  % frequency bins DeltaF = SampleFreq/NFFT = (30*f)/512 = 0.5859 Hz  
n_lekage = 1:1:NFFT_lekage;
Yf_lekage = (1/NFFT_lekage)*( fft(yt2, NFFT_lekage) );


%Output contains DC at index 1
subplot(2,2,2)
%The 10 Hz frequency shoud appear in the bin 5 (f/2 -> 10/2)
plot(n, abs(Yf), 'g', 'LineWidth', 1.5);
title('Frequency domain - Without Leakage')
xlim([1 NFFT])

subplot(2,2,4)
%The 10 Hz frequency shoud appear in the bin 17.0678 (f/0.5859 -> 10/0.5859)
plot(n_lekage, abs(Yf_lekage), 'm', 'LineWidth', 1.5);
title('Frequency domain - With Leakage')
xlim([1 NFFT_lekage])