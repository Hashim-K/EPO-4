
function out = music()
A = 1; 
B = 2; 
C = 3; 
D = 4; 

EPOCommunications('transmit','S'); 
notes = [3 0.5; 4 0.5; 5 0.5; 3 0.5;
         3 0.5; 4 0.5; 5 0.5; 3 0.5;
         5 0.5; 6 0.5; 7 0.5; 7 0.5;
         5 0.5; 6 0.5; 7 0.5; 7 0.5;
         7 0.25; 8 0.25; 6 0.5; 5 0.5; 1 0.5;
         ]
for i = 1:length(notes)
    if(notes(i,1) == 1)
        notes(i,1) = 440;
    elseif (notes(i,1) == 2)
        notes(i,1) = 493.92; 
    elseif (notes(i,1) == 3)
        notes(i,1) = 523.28; 
    elseif (notes(i,1) == 4)
        notes(i,1) = 587.36; 
    elseif (notes(i,1) == 5)
        notes(i,1) = 659.28; 
    elseif (notes(i,1) == 6)
        notes(i,1) = 698.48; 
   elseif (notes(i,1) == 7)
        notes(i,1) = 784.92; 
    end 
end 



for i = 1:length(notes)
    
EPOCommunications('transmit','A1')


EPOCommunications('transmit','B1'); % set the bit frequency
str = "F" + notes(i,1) 
chr = convertStringsToChars(str)
EPOCommunications('transmit',chr);% set the carrier frequency
EPOCommunications('transmit','R1'); % set the repetition count
EPOCommunications('transmit','C0xaa55aa55'); % set the audio cod

pause(notes(i,2));
end 
end