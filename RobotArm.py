import numpy as np
import math as mt

theta1 = 90
theta2 = 100
theta3 = 90
theta4 = 90
theta5 = 90

theta1 = theta1-90
theta3 = theta3-90

def ForwardT05(theta1, theta2, theta3, theta4, theta5):
    T01 = np.array([[mt.cos(mt.radians(theta1)), -1 * mt.sin(mt.radians(theta1)), 0, 0],
                    [mt.sin(mt.radians(theta1)), mt.cos(mt.radians(theta1)), 0, 0],
                    [0, 0, 1, 11],
                    [0, 0, 0, 1]])

    T12 = np.array([[mt.cos(mt.radians(theta2)), -1 * mt.sin(mt.radians(theta2)), 0, 0],
                    [0, 0, -1, 0],
                    [mt.sin(mt.radians(theta2)), mt.cos(mt.radians(theta2)), 0, 0],
                    [0, 0, 0, 1]])

    T23 = np.array([[mt.cos(mt.radians(theta3)), -1 * mt.sin(mt.radians(theta3)), 0, 8.5],
                    [mt.sin(mt.radians(theta3)), mt.cos(mt.radians(theta3)), 0, 0],
                    [0, 0, 1, 0],
                    [0, 0, 0, 1]])

    T34 = np.array([[mt.cos(mt.radians(theta4)), -1 * mt.sin(mt.radians(theta4)), 0, 8.5],
                    [mt.sin(mt.radians(theta4)), mt.cos(mt.radians(theta4)), 0, 0],
                    [0, 0, 1, 0],
                    [0, 0, 0, 1]])

    T45 = np.array([[mt.cos(mt.radians(theta5)), -1 * mt.sin(mt.radians(theta5)), 0, 0],
                    [0, 0, -1, -12],
                    [mt.sin(mt.radians(theta5)), mt.cos(mt.radians(theta5)), 0, 0],
                    [0, 0, 0, 1]])

    T02 = np.dot(T01, T12)
    T03 = np.dot(T02, T23)
    T04 = np.dot(T03, T34)
    T05 = np.dot(T04, T45)

    return T05


T05 = ForwardT05(theta1, theta2, theta3, theta4, theta5)
px = T05[0][3]
py = T05[1][3]
pz = T05[2][3]

r11 = T05[0][0] ; r12 = T05[0][1] ; r13 = T05[0][2]
r21 = T05[1][0] ; r22 = T05[1][1] ; r23 = T05[1][2]
r31 = T05[2][0] ; r32 = T05[2][1] ; r33 = T05[2][2]

r06 = T05[:-1,:-1]
print(px,py,pz)

def inv_theta1(p_x,p_y,p_z):
    w_x = p_x - (12)*r13
    w_y = p_y - (12)*r23
    w_z = p_z - (12)*r33

    theta_1 = mt.atan(w_y/w_x)

    return theta_1

def inv_theta2(p_x,p_y,p_z,theta_3r):
    w_x = p_x - (12)*r13
    w_y = p_y - (12)*r23
    w_z = p_z - (12)*r33

    s = w_z-11
    r = mt.sqrt((w_x**2)+(w_y**2))
    s3 = mt.sin(theta_3r)
    c3 = mt.cos(theta_3r)
    beta = mt.atan(s/r)
    pheta = mt.atan((8.5*mt.sin(theta_3r))/(8.5+(8.5*mt.cos(theta_3r))))

    theta_2 = (mt.atan(s/r)+mt.atan((8.5*s3) / (8.5+(8.5*c3))))
    return theta_2

def inv_theta3(p_x,p_y,p_z):
    w_x = p_x - (12)*r13
    w_y = p_y - (12)*r23
    w_z = p_z - (12)*r33
    s = w_z-11
    r = mt.sqrt((w_x**2)+(w_y**2))
    c3 = ((r**2)+(s**2)-(8.5**2)-(8.5**2)) / (2*8.5*8.5)
    print(r,((r**2)+(s**2)-(8.5**2)-(8.5**2)))
    s3 = mt.sqrt(1-c3**2)
    theta_3 = mt.atan(s3/c3)

    return theta_3

theta_1r = inv_theta1(px,py,pz)
theta_1 = mt.degrees(theta_1r)

theta_3r = inv_theta3(px,py,pz)
theta_3 = mt.degrees(theta_3r)

theta_2r = inv_theta2(px,py,pz,theta_3r)
theta_2 = mt.degrees(theta_2r)

print(theta_1+90,theta_2,theta_3+90)