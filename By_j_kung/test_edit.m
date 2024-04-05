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
Robot.name = '   Robot_Green';
Robot

space = 50;
Robot.plot([90 90 90 90 90]*pi/180,'workspace',[-space space -space space 0 space])
%Robot.teach
