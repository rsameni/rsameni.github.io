% Note: This is an IF band simulation of the project

%//////////////////////////////////////////////////////////////////////////
clear;
close all;
clc

% rand('seed',0);
% randn('seed',0);

%//////////////////////////////////////////////////////////////////////////
% lpf = load('LPFilter_Fs128_Fpass25_Fstop38');

T = .1e-3; % s
fs = 245e6; % Hz
ffs = fs;%246e6/4.0; % Hz (sampling rate after decimation)
fc_original = 160e6; % Hz (fs - 160MHz) used in sub-sampling mode
fc = mod(fs - fc_original, fs); % Hz (fs - 160MHz) used in sub-sampling mode

BW = 50e6; % Hz used for noise shaping
BW_channelized = 10e6; % channelized receiver bandwidth
wlen_video = 50e-9; % video integration window length
wlen_IF_filter = 500e-9; % integration window length
wlen_IF_smoothing = 1000e-9;%3*wlen_IF_filter; % integration window length

sgn = -1; % use 1 for forward mixer shift and -1 for backward mixer shift
adcbits = 16;

% the pulses
f1 = 167.5e6;%167e6; % Hz
pa1 = 1;
pw1 = 1.5e-6;%50e-9; % s
prf1 = 30e3; % Hz
phase1 = 0.5; % normalized between 0 and 1 (indicating start point phase)

f2 = 161e6;%161e6; % Hz
pa2 = .5;
pw2 = 1.0e-6; % s
prf2 = 30e3; % Hz
phase2 = .2; % normalized between 0 and 1 (indicating start point phase)

f3 = 157e6;%151e6; % Hz
pa3 = .5;
pw3 = 3.0e-6; % s % 30e-6
prf3 = 25e3; % Hz
phase3 = .7; % normalized between 0 and 1 (indicating start point phase)

snr = 15; % in dB
iterations = 1;

e_ma = zeros(1, iterations);
e_med = zeros(1, iterations);
for k = 1:iterations,
    %//////////////////////////////////////////////////////////////////////////
    % signal + noise generation
    [s1 IF1_raw pls1] = PulseGenerator(fs, T, f1, pa1, pw1, prf1, phase1);
    [s2 IF2_raw pls2] = PulseGenerator(fs, T, f2, pa2, pw2, prf2, phase2);
    [s3 IF3_raw pls3] = PulseGenerator(fs, T, f3, pa3, pw3, prf3, phase3);
    
    pulse_active = pls1 | pls2 | pls3;
    s = s1 + s2 + s3;
    IF_true = IF1_raw + IF2_raw + IF3_raw;
    IF_true(IF_true == 0) = fc_original;
    
    noise_power = mean(s.^2)/(10^(snr/10));
    N = round(T*fs);
    n = (0:N-1);
    noise = randn(1,N);
    noise = LPFilter(noise, (BW/2)/fs);
    noise = LPFilter(noise, (BW/2)/fs);
    noise = LPFilter(noise, (BW/2)/fs);
    noise = noise.*cos(2*pi*n*fc/fs + pi/4);
    noise = noise / std(noise);
    
    x = s + sqrt(noise_power)*noise; % noisy signal (received by ADC)
    
    %//////////////////////////////////////////////////////////////////////////
    c = exp(sgn*1j*2*pi*n*fc/fs);
    xx = x.*c; % mixed signal
    
    % xxr = resample(real(z), ffs, fs);
    % xxi = resample(imag(z), ffs, fs);
    % xx = xxr + 1j*xxi;
    % xx = z;
    
    LLL = round(fs/BW_channelized);
    y = 2*filtfilt(ones(1,LLL), LLL, xx);
    
    yr = real(y);
    yi = imag(y);
    
    %//////////////////////////////////////////////////////////////////////////
    % Video calculation
    videowinlen = round(fs*wlen_video);
    video = filter(ones(1,videowinlen), videowinlen, abs(y));
    
    %//////////////////////////////////////////////////////////////////////////
    % IF calculation
    
    % method 1: Correlator; Inspired from Microwave Receivers with EW Applications, p. 185-188
    wlensamples = round(wlen_IF_filter*fs);
    
    A1 = yr(1:end-1) - yi(2:end);
    B1 = yi(1:end-1) - yr(2:end);
    C1 = yi(1:end-1) + yi(2:end);
    D1 = -yr(1:end-1) + yr(2:end);
    
    A2 = A1.^2;
    B2 = B1.^2;
    C2 = C1.^2;
    D2 = D1.^2;
    
    A2 = filter(ones(1,wlensamples),wlensamples,A2);
    B2 = filter(ones(1,wlensamples),wlensamples,B2);
    C2 = filter(ones(1,wlensamples),wlensamples,C2);
    D2 = filter(ones(1,wlensamples),wlensamples,D2);
    
    E = B2 - A2;
    F = C2 - D2;
    omega = atan2(E, F);
    IF_estimated = fs*omega([1 1:end])/(2*pi);
    
    
    % % %     % method 2 (Hilbert)
    % % %     hil = hilbert(real(y));
    % % %     omega2 = diff(unwrap(atan2(imag(hil), real(hil))));
    % % %     IF_estimated = fs*omega2([1 1:end])/(2*pi);
    % % %     wlensamples = 0;
    
    wlensamplessmoothed = round(wlen_IF_smoothing*fs);
    IF_ma = filter(ones(1,wlensamplessmoothed), wlensamplessmoothed, IF_estimated);
    IF_med = TrimmedFilter(IF_estimated, 'median', wlensamplessmoothed, 0, 0);
    
    error_ma = fc_original - Lagged(IF_ma, -(LLL + wlensamples/2 + wlensamplessmoothed/2) ) - IF_true;
    error_med = fc_original - Lagged(IF_med, -(LLL + wlensamples/2) ) - IF_true;
    
    indx = (IF_true ~= fc_original & pulse_active);%true(1,length(IF_true));%
    % plot(1e6*n(indx)/fs, IF_true_lagged(indx), 'ro', 'linewidth', 2);
    
    % e_ma = 10*log10(mean(error_ma(end/2:end).^2)/mean(IF_true_lagged(end/2:end).^2))
    % e1_med = 10*log10(mean(error_med(end/2:end).^2)/mean(IF_true_lagged(end/2:end).^2))
    e_ma(k) = 100*(sqrt(mean(error_ma(indx).^2)/mean(IF_true(indx).^2)));
    e_med(k) = 100*(sqrt(mean(error_med(indx).^2)/mean(IF_true(indx).^2)));
    
    disp(['e_ma: ' num2str(e_ma(k))]);
    disp(['e_med: ' num2str(e_med(k))]);
end

disp(['MA mean(std): ' num2str(mean(e_ma)) '(' num2str(std(e_ma)) ')']);
disp(['MED mean(std): ' num2str(mean(e_med)) '(' num2str(std(e_med)) ')']);
%//////////////////////////////////////////////////////////////////////////
% plot results
n = (0:length(y)-1);

figure;
hold on;
plot(1e6*n/fs, x, 'r');
plot(1e6*n/fs, s);
plot(1e6*n/fs, Lagged(real(y), 0), 'c');
plot(1e6*n/fs, Lagged(imag(y), 0), 'm');
plot(1e6*n/fs, Lagged(video, -videowinlen/2), 'k');
grid;
set(gca, 'box', 'on');

% figure
% hold on
% plot(1e6*n/fs,yr);
% plot(1e6*n/fs,video, 'r');
% grid
% xlabel('time (\mus)');
% ylabel('amplitude (V)');
% set(gca, 'box', 'on');

figure
hold on
plot(1e6*n/fs, fc_original - Lagged(IF_estimated, -(LLL + wlensamples/2) ), 'b');
plot(1e6*n/fs, fc_original - Lagged(IF_ma, -(LLL + wlensamplessmoothed/2 + wlensamples/2) ), 'r');
plot(1e6*n/fs, fc_original - Lagged(IF_med, -(LLL + wlensamples/2) ), 'g');
plot(1e6*n/fs, IF_true, 'k', 'linewidth', 2);
grid
legend('IF estimated', 'MA', 'Median', 'IF original');
xlabel('time (\mus)');
ylabel('IF(Hz)');
aa = axis;
aa(3) = fc_original - BW_channelized/1.5;
aa(4) = fc_original + BW_channelized/1.5;
axis(aa);
set(gca, 'box', 'on');

% figure;
% plot(1e6*n/fs, pulse_active);

% figure;
% hold on;
% plot((0:length(s)-1)/fs, s);
% plot((0:length(IF_estimated_lagged)-1)/fs, IF_estimated_lagged*std(s)/std(IF_estimated_lagged), 'r');
% plot((0:length(IF_ma)-1)/fs, IF_ma*std(s)/std(IF_ma), 'g');
% grid

% % % figure;
% % % hold on;
% % % plot(n/fs,x);
% % % plot(n/fs,s,'r');
% % % grid
% % % legend('Noisy','Clean');
% % % title('Input Signals');
% % %
% % % figure;
% % % hold on
% % % plot(n/fs,real(y));
% % % plot(n/fs,imag(y),'r');
% % % plot(n/fs,video,'c','linewidth',2)
% % % plot(n/fs,video,'g','linewidth',1)
% % % legend('In-Phase','Quadrature-Phase','Wide Band Video','Video');
% % % title('I/Q');
% % % grid
% % %
% % % figure
% % % plot(fX, 20*log10(abs(X)));
% % % grid
% % % title('Input Spectrum (before mixer)');
% % %
% % % figure
% % % plot(fZ, 20*log10(abs(Z)));
% % % grid
% % % title('I/Q Spectrum (after mixer, before filter)');
% % %
% % % figure
% % % hold on
% % % plot(fY0, 20*log10(abs(xx)),'r');
% % % plot(fY, 20*log10(abs(Y)));
% % % grid
% % % title('I/Q Spectrum (after mixer, after filter)');
% % % legend('first filter','second filter');
% % %
% % % figure
% % % hold on
% % % % plot(n/fs,x*std(omega1)/std(x),'b');
% % % plot(n/fs,s*std(omega1)/std(s)+210e6,'b--');
% % % plot(n/fs,omega2+fc_original,'m');
% % % plot(n/fs,omega3+fc_original,'g');
% % % plot(n/fs,omega1+fc_original,'r','linewidth',2);
% % % plot(n/fs,omega4+fc_original,'c','linewidth',2);
% % % % plot(n(1:length(omega5))/fs,omega5+fc_original,'k','linewidth',2);
% % % % plot(n/fs,1e7*omega6+fc_original,'k','linewidth',2);
% % % plot(n/fs,IF_estimated+fc_original,'k','linewidth',2);
% % % plot(n/fs,omega8+fc_original,'b','linewidth',2);
% % % grid
% % % % legend('Signal video','Hilbert','IFM (real)','IFM (complex)','IFM (complex prefilter)','FM Demodulation','real correlator');
% % % legend('Signal video','Hilbert','IFM (real)','IFM (complex)','IFM (complex prefilter)','real correlator','my real correlator');
% % %
% % % % xx = round((2^(adcbits-1)-1)*(x./max(abs(x))));
% % % yyr = round((2^(adcbits-1)-1)*(real(y)./max(abs(y))));
% % % yyi = round((2^(adcbits-1)-1)*(imag(y)./max(abs(y))));
% % % vvideo = round((2^(adcbits-1)-1)*(video./max(video)));
% % %
% % % fid = fopen('testinput.txt','w');
% % % fprintf(fid, '%d %d %d\n', [yyr ; yyi ; vvideo]);
% % % fclose(fid);
% % %
% % % figure
% % % hold on
% % % plot(yyr);
% % % plot(yyi,'r');
% % % % plot(real(y));
% % % % plot(imag(y),'r');
% % % grid
% % %
% % % % figure
% % % % hold on
% % % % plot(n,xx);
% % % % plot(n,xx,'ro');
% % % % plot(n,th1(ones(1,length(n))),'k');
% % % % plot(n,th2(ones(1,length(n))),'k');
% % % % grid
% % % % figure;
% % % % h = spectrum.welch;    % Create a Welch spectral estimator.
% % % % Hpsd = psd(h,x,'Fs',fs);             % Calculate the PSD
% % % % plot(Hpsd)
% % %
% % % % % % figure;
% % % % % % h = spectrum.welch;    % Create a Welch spectral estimator.
% % % % % % Hpsd = psd(h,y,'Fs',fs);             % Calculate the PSD
% % % % % % plot(Hpsd)
% % %
% % %
% % % % % % figure
% % % % % % spectrogram(x,256,250,256,fs,'yaxis');
% % % % % %
% % % % % % figure
% % % % % % spectrogram(y,256,250,256,fs,'yaxis');
% % %
% % % % % % x2 = sin(2*pi*n*f1/fs2) + 1e-2*randn(1,N);
% % % % % %
% % % % % %
% % % % % % x1 = sin(2*pi*n*f1/fs1) + 1e-2*randn(1,N);
% % % % % % x2 = sin(2*pi*n*f1/fs2) + 1e-2*randn(1,N);
% % % % % %
% % % % % % ff1 = fs1*n/N;
% % % % % % ff2 = fs2*n/N;
% % % % % %
% % % % % % X1 = fft(x1);
% % % % % % X2 = fft(x2);
% % % % % %
% % % % % % figure;
% % % % % % subplot(211);
% % % % % % plot(ff1,10*log10(abs(X1)));
% % % % % % grid;
% % % % % % axis tight
% % % % % % subplot(212);
% % % % % % plot(ff2,10*log10(abs(X2)),'r');
% % % % % % grid;
% % % % % % axis tight
