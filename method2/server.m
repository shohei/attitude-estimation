clear; close all;

global h; global dir;
global r; global p; global y;
global t; global ts; global rs; global ys; global ps;
global axs; global ays; global azs; 
global wxs; global wys; global wzs;
global ax_bias; global ay_bias; global az_bias;
global wx_bias; global wy_bias; global wz_bias;
global g;

g = 9.81; % gravity constant

myMQTT=mqtt('tcp://127.0.0.1');
%mySub = subscribe(myMQTT,'imu', 'Callback','computeAcc');
mySub = subscribe(myMQTT,'imu', 'Callback','computeGyro');

pt = [0 0 0];
dir = [1 0 0 1];
ts=[];
rs = []; ps = []; ys = [];
axs=[]; ays=[];azs=[];
wxs=[];wys=[];wzs=[];
r = 0; p = 0; y = 0;


ax_bias = -0.0096;
ay_bias = 0.0028;
az_bias = 1.065-1.0;
wx_bias = 11.5033;
wy_bias = -14.633;
wz_bias = -6.6056;

subplot(2,2,[1,3]);
h = quiver3(pt(1),pt(2),pt(3), dir(1),dir(2),dir(3));
xlim([-1 1]);
ylim([-1 1]);
zlim([-1 1]);

global maxn; global avet;
maxn = 20; avet=0.1;