    % mdl_twolink14 Create model of Two link planar robot for assignmet for
    % robotics 5425
    %
    % mdl_twolink14 script creates that creates a the workspace variable p560 which
    % describes the kinematic and dynamic characteristics of a two link planar robot
    % using DH parameters measured from the mounted 2 link robot. 
    %
    % Also define the workspace vectors:
    %   qz         zero joint angle configuration with respect to y axis
    %   qr         right most position of the robot
    %   ql         left most position of the robot
    %   qn,qs      random joint angles
    %
    % Notes::
    % - SI units are used.
    % - The model includes armature inertia and gear ratios.

    clear L % clearing variable that will coontain the link parameters
    deg = pi/180;

    % Making a revolute joint with the some parameters and returns 
    % link object(as revolute class is a child class of link class) to L(1)
    L(1) = Revolute('d', 0,     'a', 10.878, 'alpha', 0, ...
        'qlim', [140 -57]*deg );
    % calling revolute function for the second joint
    L(2) = Revolute('d', 2.5, 'a', 10.8, 'alpha', 0, ...
        'qlim', [-25 -175]*deg ); % specifying the joint limits with respec to Y axis


    % attaching the 
    l214 = SerialLink(L, 'name', 'TwoLink_14', ...
        'manufacturer', 'ece5425', 'ikine', 'puma', 'comment', 'Planar Robot, project 1');

    %p560 = SerialLink(L, 'name', 'Puma 560', ...
     %   'manufacturer', 'Unimation', 'ikine', 'puma', 'comment', 'viscous friction; params of 8/95');


    l214.model3d = 'UNIMATE/puma560';

    % some useful poses
    qz = [0 -25*deg]; % zero angles, Stright line pose aligned with Y axis
    qs = [0 -pi/2]; 
    qn = [0 -pi/4];
    ql = [30*pi/180 -100*pi/180]; %left most pose
    qr = [-170*pi/180 -90*pi/180]; % right most pose

    %clear L