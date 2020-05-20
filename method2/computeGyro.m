function computeGyro(~,json)
  global t;global y; global p; global r;
  global ts; global ys; global ps; global rs;
  global wxs; global wys; global wzs;
  global h; global dir;
  global maxn; global avet;
  global g;
  global ax_bias; global ay_bias; global az_bias; 
  global wx_bias; global wy_bias; global wz_bias; 

  json = strrep(json,"'",'"');
  json =eraseBetween(json,1,1);
  json = eraseBetween(json,strlength(json),strlength(json));
  data = jsondecode(json); 
  wx = (data.wx-wx_bias)*pi/180;
  wy = (data.wy-wy_bias)*pi/180;
  wz = (data.wz-wz_bias)*pi/180;
  tnext = data.t;
  tnext = tnext/1000;
  dt = tnext-t;
  t = tnext;
  ts = horzcat(ts, t);
  R = [1 sin(r)*sin(p)/cos(p) cos(r)*sin(p)/cos(p);
       0 cos(r) -sin(r);
       0 sin(r)/cos(p) cos(r)/cos(p)];
  drpy = R*[wx wy wz]';
  dr = drpy(1);
  dp = drpy(2);
  dy = drpy(3);
  r = r + dr*dt;
  p = p + dp*dt;
  y = y + dy*dt;
  rs = horzcat(rs, r); 
  ps = horzcat(ps, p); 
  ys = horzcat(ys, y);
  wxs = horzcat(wxs, wx); 
  wys = horzcat(wys, wy); 
  wzs = horzcat(wzs, wz);
  
  subplot(2,2,[1,3]);
  xfm = makehgtform('xrotate',r,'yrotate',p,'zrotate',y);
  newdir = xfm * dir';
  h.UData = newdir(1);
  h.VData = newdir(2);
  h.WData = newdir(3);
  
  if(length(ts)>maxn)
    ts = ts(2:end);
    rs = rs(2:end);
    ps = ps(2:end);
    ys = ys(2:end);
    wxs = wxs(2:end);
    wys = wys(2:end);
    wzs = wzs(2:end);    
  end

  subplot(2,2,2);
  gca;
  plot(ts,rs,'r');
  hold on;
  plot(ts,ps,'b');
  plot(ts,ys,'g');
  xlim([ts(1),ts(end)]);
  legend('Roll','Pitch','Yaw');
  
  subplot(2,2,4);
  gca;
  plot(ts,wxs,'c');
  hold on;
  plot(ts,wys,'m');
  plot(ts,wzs,'k');   
  xlim([ts(1),ts(end)]);
  legend('ωx','ωy','ωz');
  drawnow;
  
end