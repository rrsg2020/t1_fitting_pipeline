function [newpos,centerpos] = func_flyA(pos,flight,th_xy,th_z)

% �ǂȂǋC�ɂ���, �P���ɃX�^�[�g�n�_������̕����Ɉ������i�߂��Ƃ��̍��W��Ԃ�.
% �y���͌n�z
%   pos -> x,y,z���W. size(pos) = [1,3]
%   flight -> �򋗗�. �萔.
%   th_xy, th_z -> X������̉�]�p, XY���ʂ���̋p. �萔. ��҂�-0.5pi�`0.5pi.

% �y�o�͌n�z
%   newpos -> x,y,z���W. size(pos) = [1,3]
%   centerpos -> x,y,z���W. size(pos) = [1,3]. ����̒��ԓ_

fl_z = flight * sin(th_z);
fl_x = (flight * cos(th_z)) * cos(th_xy);
fl_y = (flight * cos(th_z)) * sin(th_xy);

newpos = pos + [fl_x, fl_y, fl_z];
centerpos = pos + [fl_x, fl_y, fl_z]*0.5;

