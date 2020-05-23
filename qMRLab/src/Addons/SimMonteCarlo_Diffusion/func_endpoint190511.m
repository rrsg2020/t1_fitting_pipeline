function [endpoint, new_th_xy, new_th_z, restflight, centerpoint] = func_endpoint190511(R,center,trans,startpoint,th_xy, th_z, flight,mode3D,sn) 

% func_endpoint190511.m
% MRathon�p�ɉ��ρBhitstat�̔p�~�Bendopoint��centerpoint�ɃZ�����g���̂�p�~�BExceeds�̔p�~�B���������̂��̂̔p�~�B�ȂǁB
% height������������������Ȃ��̂œ��͂�����폜

% ���Ƃ��ƍזE�O��p��func_extracell190307�Ƃ��č������, ���O�𕪂���K�v���Ȃ��Ȃ����̂�,
% func_endpoint190327�Ɖ���.

% �e�\���ɑ΂��ēK�����邱�Ƃ�z��.�Ȃ̂�, �Ώۂ͂������. �Ώۂ͊ʋl�^��Z�����ɏ㉺�͈̔͂�����~����z��.
% �y���͌n�z
% R,center,height -> �Ώۂ�XY�����̔��a(�萔), ���S([x,y,z]), height(�萔, Z�����̍���(center����̒����Ȃ̂Ŏ��ۂ̍����͂���2�{))
% trans -> �Ώۂ̕ǂ̓��ߗ� (�萔)
% startpoint, th_xy, th_z -> �X�^�[�g�n�_(x,y,z), XY�����̎ˏo�p(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi
% flight ->����̍ő�򋗗� (�Ԃ������炻���܂ł̋���������ď������I���)
% sn -> small number�B�ǂɃg���b�v�����̂�h�����߂ɁA������������B0.000000001���炢�B


% �y�o�͌n�z
% hitstat -> �Ԃ������ʒu, �Ǐ���(1)��������(2)��,���������Ԃ����Ă��Ȃ�(0)��
% endpoint ->����̏I���ʒu(flight���g���؂������ȊO�͊�{�I�ɂԂ������ʒu). size(endpoint) = [1,3]
% new_th_xy, new_th_z -> �Ԃ�������̎ˏo�p.(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi
% restflight -> �c���򋗗�.�萔.
% frac -> ���������򋗗��̊���. �萔.
% centerpoint -> ����̔���̒��S. MPG��������Ƃ��ɕK�v. size(centerpoint) = [1,3]

xx = startpoint(1)-center(1); yy = startpoint(2)-center(2); zz = startpoint(3)-center(3); %��������Ώۍ\�������_���S�ɂ���.
fl_xy = flight * cos(th_z); %�򋗗���xy��������, z���������̑傫��. z���������͕��̒l�ɂȂ蓾��.(th_z�͈̔͂�-0.5pi�`0.5pi�Ȃ̂�)
%fl_z = flight * sin(th_z); ����͓����蔻���p�ɗ��p���Ă��āA�ŏI�I��endpoint��flyA�ŋ��߂Ă���̂�����A����͂�������Ȃ��B�͂��B 
[pos1,~, dist, stat] = func_cross_cir_line190511(xx, yy, th_xy, R); % �Ώۂ�"�̋�"�Ƃ̌�_�����߂�.
% [~,~, distz, statz] = func_cross_line_line190307(sqrt(xx^2+yy^2), zz, th_z, height); % ���E�V��Ƃ̌�_�����߂�. �i�s������z�����Ȃ����ʂōl����(��]���W�ɂȂ�̂Œ���).
frac1a = dist(1)/fl_xy;
% frac1b = dist(2)/fl_xy;
% frac2a = distz(1)/flight;

frac = 1; hitstat = 0;
%tempz = zz + fl_z * frac1a; %�ŏ��̗̈�ǂɂ��������Ƃ���z���W�����߂�.

% if stat == 2 && statz>0 % �̈�O�A���̈�ƌ�_������BZ���������Ȃ��Ƃ��Ⴄ�����ɂ͂����Ă��Ȃ��B
%     if abs(tempz) <= height && frac1a < 1 % �̈�O����ǂɂԂ�����. (�p�ɓ������������܂�)
%         frac = frac1a;
%         hitstat = 1;
%     elseif frac1a < frac2a && frac2a < frac1b && frac2a < 1 %�̈�O���珰���V��ɓ�������
%         frac = frac2a;
%         hitstat = 2;
%     end
%     
% elseif stat == 1 % �̈��
%     if frac2a < frac1a && frac2a < 1 %�̋�or�ʋl�����珰���V��ɓ�������
%         frac = frac2a;
%         hitstat = 2;
%     elseif frac1a < frac2a && abs(tempz) < height && frac1a < 1 % �ʋl������ǂɓ�������
%         frac = frac1a;
%         hitstat = 1;
%     end
% end

% if stat >= 1 && frac1a < 1 % ��_������A���򋗗��ȓ��ł���
%     frac = frac1a;
%     hitstat = 1;
% end
% % �����ȊO�Ȃ�ǂ��ɂ��������Ă��Ȃ��͂��B

new_th_xy = rand()*2*pi; new_th_z = (rand()-0.5)*pi*mode3D; %���̕����̓����_��
% 2D�w��̎���new_th_z���[���ɂȂ�B���˂Ŏ��̕��������܂�Ƃ��́A���߂���Z�����̊p�x���Ȃ��̂Ń[���̂܂܁B

sw = 0;
if rand() > trans &&stat >= 1 && frac1a < 1 % ��_������A���򋗗��ȓ��ł���
    frac = frac1a;
    
    theta = acos(pos1(1)/R); % �~�ɂԂ������ꏊ��X�����牽�x��]�����ʒu��
    theta = theta * sign(pos1(2)); % acos����y�������̗̈悩���̗̈悩��ʂł��Ȃ��̂�, y���̐����ŕ␳.
    pos1r = func_rotate_pos_around_zero190511([xx,yy], -theta); % �~�ɂԂ������_������X����ɗ���悤�ɍ��W�n����].

    % ����pos1r=[x1,y1]����, [R,0]�Ɍ�������Particle����Ԃ��ƂɂȂ�,
    % ��������[x1,-y1]�Ɍ�������particle�����˕Ԃ�. ���̂Ƃ��̊p�x�����߂�, ����Ɍ��̍��W�n�ɖ߂���
    new_th_xy = acos( (pos1r(1)-R)/dist(1) ) * sign(-pos1r(2)) + theta; %th_z�͂��̂܂�
    sw  = -1;

% elseif rand() > trans && hitstat == 2 % ������
%     new_th_z = -th_z; %�p�͂��傤�ǔ��Ό�����. th_xy�͂�����K�v�Ȃ��B
%     sw = -1;
end

[endpoint,centerpoint] = func_flyA([xx,yy,zz], flight*frac+(sn*sw), th_xy, th_z);
restflight = flight*(1-frac);


endpoint = real(endpoint) + center;
centerpoint = real(centerpoint) + center;

    
    
    
  