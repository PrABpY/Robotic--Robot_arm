L_0 = 3;
L_1 = 3;
L_2 = 2;
L_3 = 5;

%----DH_table-----
L(1) = Link([0 L_0 0 pi/2]);
L(2) = Link([0 L_2 0 -pi/2]);
L(3) = Link([0 L_1 L_3 0]);
L
Robot = SerialLink(L);
Robot.name = 'PeePrab';

qi = [pi/3 pi/4 pi/5];
qd = [2*pi/3 2*pi/4 2*pi/5];

Ti = fkine(Robot,qi)
Td = fkine(Robot,qd)

%Robot.plot(qi);

L(1).qlim = [-pi/4,pi/4];
L(2).qlim = [0,pi];
L(3).qlim = [-pi/4,pi/4];

Robot.plot([0 0 0],'workspace',[-10 10 -10 10 -10 10])
Robot.teach
