L_1 = 11.1;
L_2 = 8.2;
L_3 = 8.2;
L_4 = 12;

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

L(1).qlim = [0 pi];
L(2).qlim = [0 pi];
L(3).qlim = [0 pi];
L(4).qlim = [pi/2 pi];
L(5).qlim = [0 pi];

Robot = SerialLink(L);
Robot.name = 'Myrobotic';
Robot

%Robot.plot(qi);

space = 30
degree = 90
Robot.plot([degree degree degree degree degree]*pi/180,'workspace',[-space space -space space -space space])
Robot.teach
