function [pos2] = func_rotate_pos_around_zero190511(pos1, theta)

% ���͍��W�����_���S��theta��]���������W���o�͂���(XY����)

% �y���͌n�z
%   pos1 -> ���͂̍��W. size(pos1) = [1,2]
%   theta -> ��]����p�x(radian). �萔
% �y�o�͌n�z
%   pos2 -> �o�͂̍��W. size(pos2) = [1,2]

    matrix = [cos(theta), -sin(theta); sin(theta), cos(theta)];
    pos2 = (matrix * pos1(:))';
    