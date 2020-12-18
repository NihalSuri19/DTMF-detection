function [buttonPress] = buttonDetect(low,high)
buttons = ['1', '2', '3', 'A';
            '4', '5', '6', 'B';
            '7', '8', '9', 'C';
            '*', '0', '#', 'D'];
for i = 1:4
    buttonPress(i) = buttons(low(i),high(i));
end
disp("The Buttons that were pressed were...");
disp(buttonPress)
end

