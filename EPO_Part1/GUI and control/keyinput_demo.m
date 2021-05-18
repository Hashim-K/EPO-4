function drive_demo()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     PRESS 'Q' TO EXIT GAME         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
%OPTIONS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
refreshRate=30;
Period=1/refreshRate;
bounds=1;         %bounds? 1-yes 0-no
axis_limit= 100;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%555555555
d=0;
x =round(axis_limit/2); %starting point
y =round(axis_limit/2); %starting point
pos=[x;y];
press=0;
ex=0;    % used to exit game
showCar(pos,axis_limit)
figure('KeyPressFcn',@my_callback);
    function my_callback(splooge,event)%callback function for movement
        switch event.Character
            case 'q'
                ex=1;
            case 'w'               % arrow direction
                if(d~=2)
                    d = 1;              %up d=1
                    press=1;
                end
            case 's'
                if(d~=1)
                    d = 2;              %down d=2
                    press=1;
                end
            case 'd'
                if(d~=4)
                    d = 3;              %right d=3
                    press=1;
                end
            case 'a'
                if(d~=3)
                    d = 4;              %left d=4
                    press=1;
                end
        end
    end
while (ex~=1)%runs the snake as long as q is not pressed
    n=width(pos);
    if press==1;
        switch d         %calling callback function
            case 1
                pos=[pos, [pos(1,n); pos(2,n)+1]];%add value of 1 to y position
            case 2
                pos=[pos, [pos(1,n); pos(2,n)-1]];%subtract value of 1 to y position
            case 3
                pos=[pos, [pos(1,n)+1; pos(2,n)]];;%add value of 1 to x position
            case 4
                pos=[pos, [pos(1,n)-1; pos(2,n)]];%subtracts value of 1 to x position
        end
    end
    press=0;
    showCar(pos,axis_limit)
      pause(Period) 
      if bounds==1
          if pos(1,n)==0 %if snake exceeds boundaries display message box
              msgbox('YOU LOST! HAHA')
              ex=1
          elseif pos(2,n)==0%if snake exceeds boundaries display message box
              msgbox('YOU LOST! HAHA')
              ex=1
          elseif pos(1,n)==axis_limit%if snake exceeds boundaries display message box
              msgbox('YOU LOST! HAHA')
              ex=1
          elseif pos(2,n)==axis_limit%if snake exceeds boundaries display message box
              msgbox('YOU LOST! HAHA')
              ex=1
          end
      end
  end
  close all
  end
function showCar(pos,axis_limit)
      plot(pos(1,:),pos(2,:), 'wo')
      whitebg([0 0 0])%creates black background
      axis([0, axis_limit, 0, axis_limit])%creates the axis for gameplay
      hold off
      end