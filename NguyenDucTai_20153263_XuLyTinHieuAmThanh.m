fs = 44100; % tan so lay mau (Hz)
t = 0 : 1/fs : 0.3;

fla2 = 880; % tan so cac not nhac
fsol2 = 792;
ffa2 = 704;
fmi2 = 660;
fre2 = 586;
fdo2 = 528;
fsi = 495;
fla = 440;
fsol = 396;
ffa = 352;
fmi = 330;
fre = 293;
fdo = 264;

A0 = .7;
A1 = .6; A2 = .5; A3 = .4; A4 = .3; A5 = .2; A6 = .1;   % bien do

w = 0; % pha
la2 = A1 *sin( 2 * pi * fla2 * t + w );
sol2 = A2 *sin( 2 * pi * fsol2 * t + w );
fa2 = A3 *sin( 2 * pi * ffa2 * t + w );
mi2 = A4 *sin( 2 * pi * fmi2 * t + w );
re2 = A5 *sin( 2 * pi * fre2 * t + w );
do2 = A6 *sin( 2 * pi * fdo2 * t + w );
si = A0 *sin( 2 * pi * fsi * t + w );
la = A1 *sin( 2 * pi * fla * t + w );
sol = A2 *sin( 2 * pi * fsol * t + w );
fa = A3 *sin( 2 * pi * ffa * t + w );
mi = A4 *sin( 2 * pi * fmi * t + w );
re = A5 *sin( 2 * pi * fre * t + w );
do = A6 *sin( 2 * pi * fdo * t + w );

y = [do fa sol sol la la t fa sol la sol do2 do2 t do2 re2 mi2 mi2 fa2 fa2 t sol2 la2 sol2 fa2 mi2 t fa2 mi2 do2 do2 re2 re2 t do2 si si do2 do2 t fa sol la la si si t re fa mi fa];
mySpeech = audioread('orig_input.wav');
x1 = mySpeech';
x2 = x1(1:length(y));

melody = y+x2;
audiowrite('melody.wav',melody',44100);
sound(melody,44100);

subplot(2,1,1);
MELODY=fft(melody);
plot(abs(MELODY));

N = fs;
transform = fft(melody,N)/N;
magTransform = abs(transform);
faxis = linspace(-fs/2,fs/2,N);
plot(faxis,fftshift(magTransform));
xlabel('Frequency (Hz)');
axis([0 length(faxis)/2, 0 max(magTransform)]);
xt = get(gca,'XTick');  
set(gca,'XTickLabel', sprintf('%.0f|',xt));
title('FT(melody)');

subplot(2,1,2);
win = 128;
hop = win/2;            
nfft = win;
spectrogram(melody,win,hop,nfft,fs,'yaxis');
title('Spectogram(melody)');
yt = get(gca,'YTick');  
set(gca,'YTickLabel', sprintf('%.0f|',yt));