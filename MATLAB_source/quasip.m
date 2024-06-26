% program : quasip.m
%

function quasip()
    close all
    clear all

    global h alpha beta gamma A B Omega Picture Map
    
    animsteps = 32;
   
    
% Choose first between map and ode 
fprintf('Choose Map=1 for the map and Map=0 for the differential equation \n')
Map = input('Map =' );
fprintf('Give now the desired parameters. Pressing enter will set the standard parameters \n')
if( isempty(Map) )  
    error('you have to set Map to 0 or 1') 
end

if(Map==0)   
    alpha     = input('alpha = '); 
    beta      = input('beta  = ');         % units ?
    gamma     = input('gamma = ');
    A         = input('A = ');
    B         = input('B = ');
    Omega     = input('Omega = ');
    Picture   = input('Picture = ');
  
    if( isempty(alpha) )    alpha = 1;     end
    if( isempty(beta) )     beta = 1.576;  end
    if( isempty(gamma) )    gamma = 1;     end    
    if( isempty(A) )        A = 1.4;       end
    if( isempty(B) )        B = 1;         end
    if( isempty(Omega) )    Omega = 1.76;  end
    if( isempty(Picture) )  Picture = 1;   end
else
    Omega     = input('Omega = ');
    k         = input('k = ');
    b         = input('b = ');
    Picture   = input('Picture = ');

    if( isempty(Omega) )    Omega = 0.292;  end
    if(isempty(k))          k     = 1;      end
    if(isempty(b))          b     = 0.25;   end
    if( isempty(Picture) )  Picture = 1;    end
end

    fprintf('Press stop button to quit this run\n');

    h = 2*pi/(animsteps*Omega);         %step size
     
    xc = [0.3*2*pi 0.3 0];
    yy = xc(1)/(2*pi);
    tn = yy;
    rn =  0.3;
    t=0;
   % warning if Map is on in combination with picture 3
   if(Map==1 && Picture==3)
      fprintf('The option Map is not compatible with Picture option 3, Picture option is set to 1 \n');
      Picture = 1;
   end
%
H = init_figure();
    
nit = 20;
n = 1;
 while (n<nit)
        
    if(Map==0)
            b1 =  sin(xc(1));
            b2 = -cos(xc(1));
            
            % plot the current orientaion of the pendulum
            to = tn;
            xx = 0;
            h1=subplot(1,2,1);
            
           for i = 1:animsteps
                t = t + h;
                xc = Runge(xc);
                
               % plot pendulum
                cla(h1);
                b1 =  sin(xc(1));
                b2 = -cos(xc(1));
                plot(0, 0, '+', 'MarkerSize',10);
                plot([0 b1],[0 b2], 'b-');
                plot(b1, b2, 'r.', 'MarkerSize',25);
                pause(0.01)
            
               
              if(Picture==3)
                    % plot 2d-torus (theta vs time)
                    tn = xc(1)/(2*pi);
                    yy(2) = mod(tn,1);
                    xx(2) = xx(1)+h*Omega/(2*pi);
         
                    if(yy(2)<0) yy(2) = yy(2) + 1.0; end

                    %periodic bc
                    if( yy(2) > (yy(1)+0.5) )
                          xtemp = xx(1) - yy(1) * (xx(2) - xx(1)) / (yy(2)-1-yy(1));
                          xline(1) = xx(1);
                          xline(2) = xtemp;
                          yline(1) = yy(1);
                          yline(2) = 0;
                          subplot(1,2,2);
                          plot(xline,yline,'-k');
                          xx(1) = xtemp;
                          yy(1) = 1;
                    elseif(yy(2) < (yy(1)-0.5))
                          xtemp = xx(1) + (1-yy(1)) * (xx(2)-xx(1)) / (yy(2)+1-yy(1));
                          xline(1) = xx(1);
                          xline(2) = xtemp;
                          yline(1) = yy(1);
                          yline(2) = 1;
                          subplot(1,2,2);
                          plot(xline,yline,'-k');
                          xx(1) = xtemp;
                          yy(1) = 0;
                    end

                    xline = xx;
                    yline = yy;
                    subplot(1,2,2);
                    plot(xline,yline,'-k');
                    subplot(1,2,1);
                    xx(1) = xx(2);
                    yy(1) = yy(2);
        
              end
          
        end
        
             tn = xc(1)/(2*pi);  
             rn = xc(2);

    else % Map is switched on
       ro = rn;
       to = tn;
       rn = b*ro - k / (2*pi) * sin(2*pi*mod(to,1));
       
       tn = to + Omega + rn;    
    end   
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    if(Picture==1)
        % plot 1d map
        yy = mod(tn,1);
        xx = mod(to,1);
        if(Map==0) subplot(1,2,2);  end
        plot(xx,yy,'.k');
        % xx
        pause(0.01)
    elseif(Picture==2)
            % plot theta_dot vs theta
        yy = rn;
        xx = mod(tn,1);
        if(Map==0) subplot(1,2,2);  end
        plot(xx,yy,'.k');  
        yy
        pause(0.01)
    end
   
    n = n+1;
 end
    

 error('you pressed stop :( ')

 end



function H = init_figure()
    global Picture Map
    
    clf;
    H = uicontrol('Style', 'PushButton', ...
                    'String', 'Stop', ...
                    'Callback',@stopf);
                
if(Map==0)    
    
    subplot(1,2,1)
    axis([-1.5 1.5 -1.5 1.5]);
    axis('square');
    hold on
    xlabel('x');
    ylabel('y');
    title('Pendanim');

    subplot(1,2,2)
end
    axis([0 1 0 1])
    axis('square');
    hold on
    
    if(Picture==1)
    xlabel('$\theta_n$','interpreter','latex');
    ylabel('$\theta_{n+1}$','interpreter','latex');
    elseif(Picture==2)
    xlabel('$\theta_n$','interpreter','latex');
    ylabel('$\dot{\theta_n}$','interpreter','latex');
    if(Map==0)
    axis([0 1 -3 3])
    else
    axis([0 1 -0.5 0.5])
    end
    elseif(Picture==3)
    xlabel('t mod (2\pi / \Omega)');   
    ylabel('\theta mod 2\pi');    
    end
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 0.5 0.5]);
    commandwindow();  % Open Command Window, or select it if already open

end


function f = equations(x)
    global alpha beta gamma A B Omega
    f = zeros(3,1);
    f(1) = x(2);
    f(2) = 1/alpha * (-beta*x(2) - gamma*sin(x(1)) + A + B*cos(Omega*x(3)));
    f(3) = 1;
end


function xc = Runge(xc)
   global h
   
   x  = zeros(size(xc));
   c1 = zeros(size(xc));
   c2 = zeros(size(xc));
   c3 = zeros(size(xc));
   c4 = zeros(size(xc));

   n = length(xc);
   for i = 1:n; x(i) = xc(i); end
   f = equations(x);
   for i = 1:n; c1(i) = h*f(i); end

   for i = 1:n; x(i) = xc(i) + c1(i)/2; end
   f = equations(x);
   for i = 1:n; c2(i) = h*f(i); end

   for i = 1:n;  x(i) = xc(i) + c2(i)/2; end
   f = equations(x);
   for i = 1:n;  c3(i) = h*f(i); end

   for i = 1:n;  x(i) = xc(i) + c3(i); end
   f = equations(x);
   for i = 1:n;  c4(i) = h*f(i); end
   
   for i = 1:n
       xc(i) = xc(i) + (c1(i) + 2*c2(i) + 2*c3(i) + c4(i))/6;
   end
end   

function stopf(ObjectH, EventData)
delete(ObjectH);
end

