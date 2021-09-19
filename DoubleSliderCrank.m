%% DOUBLE SLIDER CRANK
clear all; close all;

%% Define the lengths of the links  (in cm)

% First Linkage
a1 = 2.5; % Crank
b1 = 7; % Coupler
c1 = 0.062; % Offset of slider from ground

% Second Linkage
a2 = 5; % Crank
b2 = 7.8; % Coupler
c2 = 1.5; % Offset of slider from ground

%% Define time-step & input angular speed
time_step  = 0.05;
final_time = 10;
t = 0:time_step:final_time; % t is a vector
ang_speed = 1;       % Angular speed of the crank
theta = -ang_speed*t; % crank input angle. theta is a vector. Crank rotates ClockWise. 

%% Define the coordinates

% First Linkage
P1 = [0;0];   % crank pivot coordinates
P2 = a1*[cos(theta); sin(theta)]; % P2 is the common point between crank1 & coupler1
theta2 = asin(-((a1*sin(theta)-c1)/b1))+pi; % Angle between coupler and horizontal passing through slider
d1 = a1*cos(theta) - b1*cos(theta2);  % Horizontal distance between crank pivot and slider 
Sx = d1;  % x coordinate of slider 
Sy = c1; %  y coordinate of slider
P4x = d1; % x coordinate of Ground Vertical to slider (Virtual)
P4y = 0 ; % y coordinate of Ground Vertical to slider (Virtual)

% Second Linkage
P5 = a2*[cos(theta); sin(theta)]; % P2 is the common point between crank2 & coupler2
theta3 = acos(((a2*cos(theta)+c2)/b2)); % Angle between coupler2 and vertical passing through rack
d2 = a2*sin(theta) - b2*sin(theta3);  % Vertical distance between crank pivot and rack. 
Rx = -c2 ; % x coordinate of slider2  (Rack)
Ry = d2;  %  y coordinate of slider2  (Rack)

%% Animation
for i=1:length(t)

   animation = subplot(1,2,1); % Subplot for position of linkage
   r = 0.05; % Point Radius 
   
   % Draw 4 circles of radius r centered at P1, P2, P5, S, R
   P1_circle = viscircles(P1',r); 
   P2_circle = viscircles([P2(1,i)' , P2(2,i)'],r);
   S_circle = viscircles([Sx(1,i)' , Sy'],r);
   P5_circle = viscircles(P5(:,i)' , r);
   R_circle = viscircles([Rx' , Ry(1,i)'] , r);  
 
   % Draw links A1,B1 and A2,B2 as lines joining P1-P2, P2-S and P1-P5, P5-R
   
   A1_bar = line([P1(1) P2(1,i)],[P1(2) P2(2,i)],'Color','green');
   B1_bar = line([P2(1,i) Sx(1,i)],[P2(2,i) Sy(1)],'Color','green');
       
   A2_bar = line([P1(1) P5(1,i)],[P1(2) P5(2,i)],'Color','green');
   B2_bar = line([P5(1,i) Rx(1)],[P5(2,i) Ry(1,i)],'Color','green');
       
   %% Visual Aids
   
   SliderPath = line([min(Sx)-1 , max(Sx)+6] , [Sy(1)-0.75 Sy(1)-0.75] ,'Color' , 'k');
   
   % Slider Box
   V1 = [Sx(1,i)-0.2 , Sy(1)-0.75];   
   V2 = [Sx(1,i)-0.2 , Sy(1)+0.75];
   V3 = [Sx(1,i)+4.8 , Sy(1)-0.75];
   V4 = [Sx(1,i)+4.8 , Sy(1)+0.75];   % Vertices
   L1 = line([V1(1) , V2(1)] , [V1(2) , V2(2)] , 'Color' , 'blue');
   L2 = line([V1(1) , V3(1)] , [V1(2) , V3(2)] , 'Color' , 'blue');
   L3 = line([V3(1) , V4(1)] , [V3(2) , V4(2)] , 'Color' , 'blue');
   L4 = line([V2(1) , V4(1)] , [V2(2) , V4(2)] , 'Color' , 'blue'); % Edges
   xVector = [V1(1) , V3(1) , V4(1) , V2(1)];
   yVector = [V1(2) , V3(2) , V4(2) , V2(2)];
   box = patch(xVector , yVector , 'blue');
  
   % Set the limits of the axes
   axis(animation,'equal');
   set(animation,'XLim',[P1(1)-a2-1 , max(Sx)+6],'YLim',[-16 , 10]);
   
   % Label the plot
   S_text = text(Sx(1,i),Sy(1)+2,'Slider');
   R_text = text(Rx(1)+1,Ry(1,i),'Rack');
   TimeString = ['Time elapsed: '  num2str(t(i)) ' s'];
   Time = text(-2,15,TimeString);
    
   pause(0.01);
   
   %% Displacement Plot
  
   disp_plot = subplot(1,2,2);
   plot(disp_plot,t(1:i),d1(1:i), 'Color', 'blue'); hold on;
   plot(disp_plot,t(1:i),d2(1:i), 'Color', 'red'); 
   legend('Slider', 'Rack');
   set(disp_plot,'XLim',[0 final_time],'YLim',[-20 20]);
   xlabel(disp_plot, 'Time (s)');
   ylabel(disp_plot, 'Displacement (cm)');
   title(disp_plot,'Rack and Slider Displacement');
   
   grid on;

   if i<length(t)
       delete(P1_circle);
       delete(P2_circle);
       delete(S_circle);
       delete(P5_circle);
       delete(R_circle);
       delete(A1_bar);
       delete(B1_bar);
       delete(A2_bar);
       delete(B2_bar); 
       delete(S_text);
       delete(R_text);
       delete(Time);
       delete(L1);
       delete(L2);
       delete(L3);
       delete(L4);
       delete(box);
   end
   
end

