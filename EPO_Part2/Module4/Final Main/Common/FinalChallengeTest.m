open EPO communications before using function:
Port ='\.\COM15';
result = EPOCommunications('close');
result = EPOCommunications('open',Port);
EPOCommunications('transmit','S'); 
load modelFinalChall.mat

%up down, left right. Bingo = slow. Twice bingo = stop

drive_time_slow = 0.35;
drive_time = 0.6;
while(1);

out_voice = 6
while(out_voice == 6)
    out_voice = voice_final(model, mu_train, sigma_train); %0 is bingo, 1-2-3-4 = right-straight-left-down, 6 = silence
    
end


if(out_voice == 0 && last_command == 0)%stop
  setMotorspeed(0);
  pause(40); %pause after stop
end

if(out_voice == 1) %go right
    setSteering(-23);
elseif(out_voice == 2) %go straight
    setSteering(0);
elseif(out_voice == 3) %go left
    setSteering(23);
elseif(out_voice == 4) %go backwards
    setSteering(0);
end



setMotorSpeed(force);
if(last_command == 0)
    pause(drive_time_slow);
else
    pause(drive_time);
end
setMotorspeed(0);

last_command = out_voice; %update last command
end
