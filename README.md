# Attitude Estimation


## Method 1. Accelerometer (3axis) + Digital Compass (3axis)

ax, ay, az: Acceleration to x, y, z axis

dx, dy, dz: x, y, z value of magnetic vector

<a href="https://www.codecogs.com/eqnedit.php?latex=\rm{Roll}&space;=&space;\arctan\left(&space;\dfrac{a_y}{a_z}\right)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\rm{Roll}&space;=&space;\arctan\left(&space;\dfrac{a_y}{a_z}\right)" title="\rm{Roll} = \arctan\left( \dfrac{a_y}{a_z}\right)" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\rm{Pitch}&space;=&space;\arctan&space;\left(&space;\dfrac{-a_x}{\sqrt{a_y^2&plus;a_z^2}}\right)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\rm{Pitch}&space;=&space;\arctan&space;\left(&space;\dfrac{-a_x}{\sqrt{a_y^2&plus;a_z^2}}\right)" title="\rm{Pitch} = \arctan \left( \dfrac{-a_x}{\sqrt{a_y^2+a_z^2}}\right)" /></a>

<a href="https://www.codecogs.com/eqnedit.php?latex=\rm{Yaw}&space;=&space;\arctan\left(-\dfrac{C_r&space;d_y&space;-&space;S_r&space;d_z}{C_p&space;d_x&space;&plus;&space;S_p&space;S_r&space;d_y&space;&plus;&space;S_p&space;C_r&space;d_z}\right)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\rm{Yaw}&space;=&space;\arctan\left(-\dfrac{C_r&space;d_y&space;-&space;S_r&space;d_z}{C_p&space;d_x&space;&plus;&space;S_p&space;S_r&space;d_y&space;&plus;&space;S_p&space;C_r&space;d_z}\right)" title="\rm{Yaw} = \arctan\left(-\dfrac{C_r d_y - S_r d_z}{C_p d_x + S_p S_r d_y + S_p C_r d_z}\right)" /></a>

<!--
$\rm{Roll} = \arctan\left( \dfrac{a_y}{a_z}\right)$

$\rm{Pitch} = \arctan \left( \dfrac{-a_x}{\sqrt{a_y^2+a_z^2}}\right)$

$\rm{Yaw} = \arctan\left(-\dfrac{C_r d_y - S_r d_z}{C_p d_x + S_p S_r d_y + S_p C_r d_z}\right)$
-->

## Method 2. Gyroscope (3axis)
### Roll-Pitch-Yaw (X-Y-Z Euler Angle)

dr: Roll, dp: Pitch, dy: Yaw

### Angular Rate from Gyroscope sensor

<!--- 
$d\phi = \omega_x dt, \ \ d\theta = \omega_y dt, \ \ d\psi = \omega_z dt$
-->
<a href="https://www.codecogs.com/eqnedit.php?latex=d\phi&space;=&space;\omega_x&space;dt,&space;\&space;\&space;d\theta&space;=&space;\omega_y&space;dt,&space;\&space;\&space;d\psi&space;=&space;\omega_z&space;dt" target="_blank"><img src="https://latex.codecogs.com/gif.latex?d\phi&space;=&space;\omega_x&space;dt,&space;\&space;\&space;d\theta&space;=&space;\omega_y&space;dt,&space;\&space;\&space;d\psi&space;=&space;\omega_z&space;dt" title="d\phi = \omega_x dt, \ \ d\theta = \omega_y dt, \ \ d\psi = \omega_z dt" /></a>
<!--- 
$\begin{bmatrix} dr \\dp\\dy\end{bmatrix} = \begin{bmatrix}  1&S_r \dfrac{S_p}{C_p} & C_r\dfrac{S_p}{C_p}\\ 0 & C_r & -S_r \\ 0 & S_r \dfrac{1}{C_p} & C_r \dfrac{1}{C_p} \end{bmatrix} \begin{bmatrix} d\phi \\d\theta \\d\psi \end{bmatrix}$ 
 --->
<a href="https://www.codecogs.com/eqnedit.php?latex=\begin{bmatrix}&space;dr&space;\\dp\\dy\end{bmatrix}&space;=&space;\begin{bmatrix}&space;1&S_r&space;\dfrac{S_p}{C_p}&space;&&space;C_r\dfrac{S_p}{C_p}\\&space;0&space;&&space;C_r&space;&&space;-S_r&space;\\&space;0&space;&&space;S_r&space;\dfrac{1}{C_p}&space;&&space;C_r&space;\dfrac{1}{C_p}&space;\end{bmatrix}&space;\begin{bmatrix}&space;d\phi&space;\\d\theta&space;\\d\psi&space;\end{bmatrix}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\begin{bmatrix}&space;dr&space;\\dp\\dy\end{bmatrix}&space;=&space;\begin{bmatrix}&space;1&S_r&space;\dfrac{S_p}{C_p}&space;&&space;C_r\dfrac{S_p}{C_p}\\&space;0&space;&&space;C_r&space;&&space;-S_r&space;\\&space;0&space;&&space;S_r&space;\dfrac{1}{C_p}&space;&&space;C_r&space;\dfrac{1}{C_p}&space;\end{bmatrix}&space;\begin{bmatrix}&space;d\phi&space;\\d\theta&space;\\d\psi&space;\end{bmatrix}" title="\begin{bmatrix} dr \\dp\\dy\end{bmatrix} = \begin{bmatrix} 1&S_r \dfrac{S_p}{C_p} & C_r\dfrac{S_p}{C_p}\\ 0 & C_r & -S_r \\ 0 & S_r \dfrac{1}{C_p} & C_r \dfrac{1}{C_p} \end{bmatrix} \begin{bmatrix} d\phi \\d\theta \\d\psi \end{bmatrix}" /></a>

## Todo: 
### 1. Use Quaternion

### 2. Sensor fusion of 9DOF sensors

