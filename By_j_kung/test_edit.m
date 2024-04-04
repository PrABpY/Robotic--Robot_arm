L_1 = 11.3;
L_2 = 8.5;
L_3 = 8.5;
L_4 = 10;

%----DH_table-----
L(1) = Revolute('d', 0, 'a', 0, 'alpha', 0);
L(2) = Revolute('d', L_1, 'a', 0, 'alpha', pi/2);
L(3) = Revolute('d', 0, 'a', L_2, 'alpha', 0);
L(4) = Revolute('d', 0, 'a', L_3, 'alpha', 0);
L(4).offset = -pi/2;
L(5) = Revolute('d', 0, 'a', 10, 'alpha', -pi/2);
L(5).offset = -pi/2;

Robot = SerialLink(L);
Robot.name = 'Myrobotic';
Robot

space = 50;
Robot.plot([90 90 90 90 90]*pi/180,'workspace',[-space space -space space 0 space])
Robot.teach
