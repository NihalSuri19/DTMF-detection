clear all;close all;
%row = [1 3 2 1];
% load data
x = load('sygnalDtmf.dat');

% signal parameters
fs = 4096;
ts = 1/fs;
% time vector
t = (0 : length(x) - 1) * ts;
% plot the signal
plot(t, x);

% lower frequencies vector
fLow = [697, 770, 852, 941];
% higher frequencies vector
fHigh = [1209, 1336, 1477, 1633];

% ------------------------------------
% put your additional variables here
indexLow = 0;
indexHigh = 0;
% end
% ------------------------------------

% window length - adjust to get optimal results
Nw = 2048;
% sliding window of length Nw
for k = 1 : length(x) - Nw + 1
    % current signal fragment
    curx = x(k : k + Nw - 1);
   
    % ------------------------------------
    % put your code to detect buttons here
    curX = fft(curx);
    for i = 1:4
        fl = fLow(i);
        Kl = round(fl*Nw*ts);
        Al = (2*abs(curX(Kl+1)))/Nw;
        if Al>0.4
            indexLow = i;
        end
    end
    for m = 1:4
          fh = fHigh(m);
          Kh = round(fh*Nw*ts);
          Ah = (2*abs(curX(Kh+1)))/Nw;
          if Ah > 0.4 
              indexHigh = m;
          end
    end
    
    low(k,:) = indexLow;
    high(k,:) = indexHigh;
  
end

newLow = low(1);
for i = 2:length(low)
    if low(i) ~= low(i-1) && i < length(low)
        newLow = [newLow low(i)];
    end
end

newHigh = high(1);
for i = 2:length(high)
    if high(i) ~= high(i-1) && i < length(high)
        newHigh = [newHigh high(i)];
    end
end

buttonsPressed = buttonDetect(newLow,newHigh);


        



    







