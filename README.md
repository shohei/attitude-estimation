# Attitude Estimation


## Method 1. Accelerometer (3axis) + Digital Compass (3axis)

$a_x, a_y, a_z$: Acceleration to x, y, z axis

$d_x, d_y, d_z$: x, y, z value of magnetic vector

$\rm{Roll} = \arctan\left( \dfrac{a_y}{a_z}\right)$

$\rm{Pitch} = \arctan \left( \dfrac{-a_x}{\sqrt{a_y^2+a_z^2}}\right)$

$\rm{Yaw} = \arctan\left(-\dfrac{C_r d_y - S_r d_z}{C_p d_x + S_p S_r d_y + S_p C_r d_z}\right)$

## Method 2. Gyroscope (3axis)
### Roll-Pitch-Yaw (X-Y-Z Euler Angle)

$dr$: Roll, $\ dp$: Pitch, $\ dy$: Yaw

### Angular Rate from Gyroscope sensor

$d\phi = \omega_x dt, \ \ d\theta = \omega_y dt, \ \ d\psi = \omega_z dt$


$\begin{bmatrix} dr \\dp\\dy\end{bmatrix} = \begin{bmatrix}  1&S_r \dfrac{S_p}{C_p} & C_r\dfrac{S_p}{C_p}\\ 0 & C_r & -S_r \\ 0 & S_r \dfrac{1}{C_p} & C_r \dfrac{1}{C_p} \end{bmatrix} \begin{bmatrix} d\phi \\d\theta \\d\psi \end{bmatrix}$ 


## Todo: 
###1. Use Quaternion

###2. Sensor fusion of 9DOF sensors

