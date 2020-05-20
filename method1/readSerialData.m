function readSerialData(src,~)
  global t;global y; global p; global r;
  global ts; global ys; global ps; global rs;
  global maxn; global avet;
  global ax_bias; global ay_bias; global az_bias; 
  global axs; global ays; global azs;
  global count;

  json = readline(src);
  data = jsondecode(json);

  ax = (data.accX)-ax_bias;
  ay = (data.accY)-ay_bias;
  az = (data.accZ)-az_bias;
  dx = data.magX;
  dy = data.magY;
  dz = data.magZ;

  axs = horzcat(axs, ax);
  ays = horzcat(ays, ay);
  azs = horzcat(azs, az);

  t = data.t;  
  
  r = atan2(ay,az);
  p = atan2(-ax,sqrt(ay^2+az^2));  
  y = atan2((-cos(r)*dy+sin(r)*dz),(cos(p)*dx+sin(p)*sin(r)*dy+sin(p)*cos(r)*dz));

  ts = horzcat(ts,t);
  ys = horzcat(ys,y);
  ps = horzcat(ps,p);
  rs = horzcat(rs,r);
   
  if(length(ts)>maxn)
    ts = ts(2:end);
    rs = rs(2:end);
    ps = ps(2:end);
    ys = ys(2:end);

    axs = axs(2:end);
    ays = ays(2:end);
    azs = azs(2:end);
  end

  subplot(2,1,1);
  plot(ts,axs,'r');
  hold on;
  plot(ts,ays,'b');
  plot(ts,azs,'g');
  legend('ax','ay','az');

  subplot(2,1,2);
  plot(ts,rs*180/pi,'r');
  hold on;
  plot(ts,ps*180/pi,'b');
  plot(ts,ys*180/pi,'g');  
  plot(ts,ones(size(ts))*90,'k--');
  plot(ts,ones(size(ts))*(-90),'k--');
  ylim([-181,181]);
  legend('Roll','Pitch','Yaw');
     
  drawnow;  

disp(count);
count=count+1;
  
end