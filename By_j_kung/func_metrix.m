clear
clc

R = [0.7 -0.4 0.6 ; 0.7 0.2 -0.7 ; 0.2 0.9 0.4]
T = [R [0;0;0] ; 0 0 0 1]

ang1 = pi/2     % 90*
ang2 = pi/3     % 60*
ang3 = pi/4     % 30*
xvec = [1;0;0]  % unit vector x axis
yvec = [0;1;0]
zvec = [0;0;1]

Rx = rotx(ang2)
Ry = roty(ang2)
Rz = rotz(ang2)
Tx = trotx(ang2)
Ty = troty(ang2)
Tz = trotz(ang2)
Tt = transl(10,20,30)

Tn = r2t(R)
Rn = t2r(T)
Ra = angvec2r(ang2,xvec)      % ang with x-axis to R
Ta = angvec2tr(ang2,xvec)     % ang with x-axit to T
[A,V] = tr2angvec(Ta)
Re = eul2r(ang1,ang2,ang3)
Te = eul2tr(ang1,ang2,ang3)
Eu = tr2eul(Te)