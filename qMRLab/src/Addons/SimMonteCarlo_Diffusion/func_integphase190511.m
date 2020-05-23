function [magnitude, integphase] = func_integphase190511(phase)

% �y���́z
%  phase -> �x�N�g��. n��phase(radian)����ׂ��x�N�g��. (�S�Ă��P�ʃx�N�g����z��)

% �y�o�́z
%  magnitude -> ���������x�N�g���̑傫��
%�@integphase -> ���������x�N�g����phase.

numelmol = size(phase,1);

X = sum(cos(phase),1)/numelmol;
Y = sum(sin(phase),1)/numelmol;

magnitude = sqrt(X.^2+Y.^2);
integphase = acos(X/(magnitude)) .* sign(Y);
