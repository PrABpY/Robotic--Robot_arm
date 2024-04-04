L_1 = 5;
L_2 = 8.5;
L_3 = 8.5;
L_4 = 10;

%----DH_table-----
L(1) = Link([0 L_1 0 pi/2]);
L(2) = Link([0 0 L_2 0]);
L(3) = Link([0 0 L_3 0]);
L(4) = Link([0 0 0 pi/2]);
L(5) = Link([0 L_4 0 0]);
L(1).offset = -pi/2;
L(2).offset = 0;
L(3).offset = -pi/2;
L(4).offset = 0;

Robot = SerialLink(L);
Robot.name = 'Myrobotic';
Robot

qi = [pi/3 pi/4 pi/5 pi/6];
qd = [2*pi/3 2*pi/4 2*pi/5 2*pi/6];

%Ti = fkine(Robot,qi)
%Td = fkine(Robot,qd)

%Robot.plot(qi);

space = 40
Robot.plot([0 0 0 0 0],'workspace',[-space space -space space 0 space])
Robot.teach
