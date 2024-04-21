function [s IF pls] = PulseGenerator(fs, T, f0, pa, pw, prf, phase)

N = round(T*fs);
n = (0:N-1);
s0 = sin(2*pi*n*f0/fs);
pw_samples = ones(1,round(pw*fs));
prf_samples = zeros(1,round(fs/prf)-length(pw_samples));
pulse = [pw_samples prf_samples];
pulse = repmat(pulse,1,ceil(N/length(pulse)));
pulse = [zeros(1,round(phase*fs/prf)) pulse];
pulse = pulse(1:N);

s = pa*s0.*pulse;
IF = f0*ones(1,length(s0)).*pulse;
pls = pulse == 1;