function [endpoint, new_th, new_th_z, new_phase] = func_simulstep190511(R,center,trans,startpoint,th_xy,th_z,totalflight,startphase,G,axis,time,mode3D,sn)

% ��func_simulstep190511
% func_simulstep190403�����ρBMRathon�̂��߁B
% exceeds�̔p�~�B�����˂̔p�~�B�܂��AR��cen���Z���ł͂Ȃ��čs��ŕ\������悤�ɁB�s�������v�f�̐��ɑΉ��B(�e�񂪌ʂ̃p�����[�^�ɑΉ�)
% Height���p�~�B�����͖����ɂ��邱�ƂɁB
% 3D�؂�ւ��i�Ƃ����Ă��A�~����\�����邩�ǂ����ƁAth_z��0�ɌŒ肷�邩�ǂ������������j

%��func_simulstep190403
% func190327������. func_hitobj190403�ɑΉ���phase�v�Z�Ń}���I����(exceeds)�𔽉f�ł���悤��.

% 1step�̋����𑍍��I�Ɍv�Z. MPG�ɂ��ʑ��V�t�g���v�Z. func_endpoint190307��A���I�Ɋ��p��,�ʑ��̏���������.

% �y���͌n�z
% R,center,height -> ���ꂼ��Z��.�@�e�v�f���e�\�����ɑΉ�. �Ώۂ�XY�����̔��a(�萔), ���S([x,y,z]), height(�萔, Z�����̍���(center����̒����Ȃ̂Ŏ��ۂ̍����͂���2�{))
% trans -> �Z��. �Ώۂ̕ǂ̓��ߗ� (�萔)
% startpoint, th_xy, th_z -> �X�^�[�g�n�_(x,y,z), XY�����̎ˏo�p(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi
% totalflight ->����̑S�򋗗�
% startphase -> �J�n���̈ʑ�����. ��]���W�ōl����.
% G -> ����step�ɂ�����X�Ύ���̋���. MPG�����ɂ��������W��̋���1�ɂǂꂾ���̌X�΂����邩. �P�ʂ̓~���e�X��.
% axis -> MPG����(x,y,z). size(axis) = [3,1].
% time -> ����step���ǂꂾ���̎����Ԃɑ������邩. ���[���A���g�����l���邽�߂ȂǂɕK�v. �P�ʂ�msec.

% �y�o�͌n�z
% endpoint ->�I���ʒu(flight���g���؂����ʒu). size(endpoint) = [1,3].
% new_th_xy, new_th_z -> �I�����̎ˏo�p.(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi

endpoint = startpoint;
new_th = th_xy;
new_th_z = th_z;
restflight = totalflight;
new_phase = startphase;

while restflight > sn
    flight = restflight;
    [endpoint, new_th, new_th_z, restflight, centerpoint] = func_findhitobj190511(R,center,trans,endpoint,new_th,new_th_z,flight,mode3D,sn);
    frac = (flight-restflight)/(totalflight+eps);
%    phaseshift = func_phaseshift190511(centerpoint + new_exceeds.*(2*limits) * posratio, G, axis, time*frac);
    phaseshift = func_phaseshift190511(centerpoint, G, axis, time*frac);
    new_phase = mod(new_phase + real(phaseshift), 2*pi);
%     new_exceeds = new_exceeds + add_exceeds; % centerpoint�ɂ͐V����exceeds����^���Ă͂����Ȃ��̂�, ����̕��𑫂��^�C�~���O�͂����ł���ׂ�.    
end
