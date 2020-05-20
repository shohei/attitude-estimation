clear;  close all;

global h; global dir;
global r; global p; global y;
global t; global ts; global rs; global ys; global ps;
global axs; global ays; global azs; 
global wxs; global wys; global wzs;
global ax_bias; global ay_bias; global az_bias;
global wx_bias; global wy_bias; global wz_bias;
global dxs; global dys; global dzs;
global g;
global count;

g = 9.81; % gravity constant
count=0;

s = serialport("/dev/cu.SLAB_USBtoUART",115200);
configureTerminator(s,"CR/LF");
configureCallback(s,"terminator",@readSerialData)

pt = [0 0 0];
dir = [1 0 0 1];
ts=[];
rs = []; ps = []; ys = [];
axs=[]; ays=[];azs=[];
wxs=[];wys=[];wzs=[];
dxs=[];dys=[];dzs=[];
r = 0; p = 0; y = 0;

wx_bias = 10.8236;
wy_bias = -14.1968;
wz_bias = -6.4555;
ax_bias = -0.0003337;
ay_bias = 0.0258;
az_bias = 1.06-1.0;

global maxn; global avet;
maxn = 20; avet=0.1;