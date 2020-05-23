function [pos1, pos2, dist, stat] = func_cross_cir_line190511(x,y,th,R)

% ���_���S, ���aR�̉~��, �_x,y��ʂ�,�p�xth�̒����Ƃ̌�_, ��_�܂ł̋��������߂�. (xy���ʂł̉��Z)

% �y���͌n�z
% x,y -> �����̒ʂ�_�̍��W. ���ꂼ��萔.
% th -> �����̌X����X������̉�]�p(rad)�ŕ\��.
% R -> ���_���S�̉~�̔��a. �萔
% inv -> 1�Ȃ�߂��ق��𖳎�����B(�ǂ̒���(��)�ɂ���P�[�X)

% �y�o�͌n�z
% pos1, pos2 -> [x,y]����th�����ɐi�񂾂Ƃ��̋߂���, �������̌�_��xy���W. ���ꂼ�꒷��2�̃x�N�g��.
% ��_���Ȃ��Ƃ��̓[��. size = [1,2]
% dist -> [x,y]����߂���, �������̌�_�܂ł̋���. ����2�̃x�N�g��. �v�f�͐��̐�. size = [1,2]
% stat -> �ړ_��2�Ȃ�, ���邢��,�����Ƃ��t�����ɂ���΃[��. �����i�s�����ɂ����2. ������i�s�����̔��Α�(�~�̓����ɂ���ꍇ)��1. �萔


% ���̂Ƃ������̎���: Y = tan(th)*X + (y - tan(th)*x)

D1 = abs(y -tan(th)*x) / sqrt(tan(th)^2 + 1); % �����ƌ��_�̋���

if D1 < R % �Ԃ���\������(�ڂ��Ă���Ƃ��͂Ԃ���Ȃ��ƍl����)
    al = tan(th)^2 + 1; be = tan(th) * (y-tan(th)*x); ga = (y - tan(th)*x)^2 - R^2;
    % �~�ƒ����̌�_�����߂邽�߂�2�����c�̊e����: (al)+x^2 + 2*(be)*x + ga = 0 
    t = sqrt(be^2 - (al*ga));
    
    xpos = [ (-be+t)/al, (-be-t)/al]; ypos = tan(th)*xpos + (y - tan(th)*x);
    
    % �ǂ��炪�i�s�����ɑ΂��ċ߂��ɂ��邩��m�肽��. (���Ȃ甽�Ε���)
    Dx = (xpos - x)/sign(cos(th)+eps); % size(Dx) = [1,2];
    Dy = (ypos - y)/sign(sin(th)+eps);
    D = sqrt(Dx.^2 + Dy.^2);
    
    temp = sign(sum([Dx;Dy],1)); % Dx(n),Dy(n)�������Ƃ���,���邢�͕Е������Ȃ�i�s�����Ɍ�_������.
    stat = sum(temp>0);
    
    if stat==0 %���S�ɔ��Ε����Ɍ������Ă���
        pos1 = NaN; pos2 = NaN; dist = [NaN,NaN];
    else
        temp = 1./(Dx+Dy-eps); % �t���ɂ��邱�Ƃŋ�����������(�߂�),�l����(�i�s����)�̂��̂��ł��傫�Ȑ��ɂȂ�.�ɏ��l�������Ă���͕̂Ǐ�̋����[���𕉂ɂ��Ă͂�������.
        sel = find(temp==max(temp),1); % �ڂ��Ă���ꍇ�͌�_�Ȃ��̈����ɂȂ��Ă���͂�����, �O�̂��ߕ����I������Ȃ��悤��.

        pos1 = [xpos(sel),ypos(sel)];
        pos2 = [xpos(3-sel),ypos(3-sel)]; % sel��1��2�Ȃ̂�
        dist = [D(sel), D(3-sel)];
           
    end
else
    pos1 = NaN; pos2 = NaN; dist = [NaN,NaN]; stat = 0;
end
