%----Create Link------
clc;
L_1 = 11;
L_2 = 8.5;
L_3 = 8.5;
L_4 = 12;

L(1) = Link([0 L_1 0 pi/2]);
L(2) = Link([0 0 L_2 0]);
L(3) = Link([0 0 L_3 0]);
L(4) = Link([0 0 0 pi/2]);
L(5) = Link([0 L_4 0 0]);

L(1).qlim = [0 pi];
L(2).qlim = [0 pi];
L(3).qlim = [0 pi];
L(4).qlim = [pi/2 pi];
L(5).qlim = [0 pi];
L(3).offset = -pi/2;

Robot = SerialLink(L);

ang = [48*pi/180 55*pi/180 45*pi/180 43*pi/180 pi/2];

for i = 1:11
    J = jacob0(Robot,ang)
    J_pinv = pinv(J);
    ans = ang'-(J_pinv*[1;1;1;1;1;1])
    ang = ans'
end
ang*180/pi

