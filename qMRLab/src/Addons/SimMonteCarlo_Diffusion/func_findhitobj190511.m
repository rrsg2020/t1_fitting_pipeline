function [endpoint, new_th, new_th_z, restflight, centerpoint] = func_findhitobj190511(R,center,trans,startpoint,th_xy,th_z,flight,mode3D,sn)

%�� func_findhitobj190511
%  func_findhitobj190403�����ρBMRathon�p�ɁA������Exceeds���O���B
%
%�܂��AR�Acenter�Atrans���Z���ł͂Ȃ��čs��ŕ\�������悤�ɑS�̂ɉ��ς��Ă���B�����˂�V�䔽�˂��s�v�Ȃ̂ō폜�Bhight�����͂�s�v�B

%�� func_findhitobj190403
% func_findhitobj190327������.
% ���܂����͈͂𒴂���ƃ}���I�ړ�(���ɗ�����Əォ��o�Ă���)����悤��.

% �y���͌n�z
% R,center,height -> center�̓Z��.�@�e�v�f���e�\�����ɑΉ�. �Ώۂ�XY�����̔��a(�萔), ���S([x,y,z]), height(�萔, Z�����̍���(center����̒����Ȃ̂Ŏ��ۂ̍����͂���2�{))
% trans -> �Z��. �Ώۂ̕ǂ̓��ߗ� (�萔)
% startpoint, th_xy, th_z -> �X�^�[�g�n�_(x,y,z), XY�����̎ˏo�p(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi
% totalflight ->����̑S�򋗗�
% startphase -> �J�n���̈ʑ�����. ��]���W�ōl����.
% G -> ����step�ɂ�����X�Ύ���̋���. MPG�����ɂ��������W��̋���1�ɂǂꂾ���̌X�΂����邩. �P�ʂ̓~���e�X��.
% axis -> MPG����. [th_xy, th_z]�̂悤��x������̊p�x�Ƌp�ŕ\�����邱�Ƃɂ���.
% time -> ����step���ǂꂾ���̎����Ԃɑ������邩. ���[���A���g�����l���邽�߂ȂǂɕK�v. �P�ʂ�microsec.

% limits -> length(limits) = 3. [-x,x],[-y,y],[-z,z]�͈̔͂𒴂���Ɣ��Α�����o�Ă���.

% �y�o�͌n�z
% endpoint ->���ꂼ���object��z�肵���Ƃ��̏I���ʒu. size(endpoint) = [1,3]
% new_th_xy, new_th_z -> �I�����̎ˏo�p.(�萔), Z�����̎ˏo�p(�p)(�萔). �p��-0.5pi�`0.5pi
% restflight -> �c���򋗗�

% exceeds -> length(exceeds) = 3; x,y,z��limit�����ɍ���̏����ŉ�����E�˔j������. �������Ȃ�+1,
% �������Ȃ�-1������.���E�˔j�����Ƃ���ň�x�~�܂�̂�2�ȏ�̐��͓���Ȃ�.


numelobj = size(center,1);
% endpoint_ = cell(numelobj+1,1); % +1��xyz���E(�̂�����ԋ߂�����)�����ɓ���邽��
% centerpoint_ = cell(numelobj+1,1);
% results = zeros(numelobj+1,3); % new_th, new_th_z, restflight
% exceeds_ = zeros(numelobj+1,3); 

endpoint_ = zeros(numelobj,3);
centerpoint_ = zeros(numelobj,3);
results = zeros(numelobj,3); % new_th, new_th_z, restflight
for r = 1:numelobj
%     [endpoint_{r},~,results(r,1), results(r,2), results(r,3), centerpoint_{r}] =...
%         func_endpoint190327(R(r),center{r},height(r),trans(r),startpoint,th_xy,th_z,flight,sn);

[endpoint_(r,:), results(r,1), results(r,2), results(r,3), centerpoint_(r,:)] =...
        func_endpoint190511(R(r),center(r,:),trans(r),startpoint,th_xy,th_z,flight,mode3D,sn);
   
end

% % x,y,z���E�ɒB�����ꍇ�̎c��flight�����߂�.
% flight_lims = flight * [cos(th_z) * cos(th_xy), cos(th_z) * sin(th_xy), sin(th_z)]; % x,y,z�����ւ̎c���򋗗�(�����t��)
% fracs = (sign(flight_lims) .* limits - startpoint)./flight_lims; % length(fracs) = 3�ƂȂ�. ���ꂼ��̐i�s�����̌��E�܂ł̋������c���򋗗��̉��{�ɂȂ邩.
% fracs(isinf(fracs)) = intmax;
% limid = false(1,3);
% limid(find(fracs==min(fracs),1)) = true; % e.g.) limid = [1,0,0]
% 
% [temp, centerpoint_{end}] = func_flyA(startpoint, flight*fracs(limid), th_xy, th_z); %���E�˔j�����Ƃ���Ŏ~�܂�̂�, centerpoint�͂��̂܂܂ŗǂ�.
% endpoint_{end} = temp + abs(limits)*2 .* limid .* -sign(flight_lims); % endpoint�̓}���I����. ���E�˔j�������ɂ���, �i�s�����̋t��limit��2�{�ړ�����, �Ƃ�������.
% 
% results(end,:) = [th_xy, th_z, flight*(1-fracs(limid))];
% exceeds_(end,:) = limid .* sign(flight_lims); % �{���ȊO�͂ǂ����[��
% 
% hitid = find(results(:,3) == max(results(:,3)),1); % ���ԓI��,���E�˔j�ƃq�b�g�������Ȃ�, �q�b�g���D�悳���.

hitid = find(results(:,3) == max(results(:,3)),1);
endpoint = endpoint_(hitid,:);
new_th = results(hitid,1); new_th_z = results(hitid,2); restflight = results(hitid,3);
centerpoint = centerpoint_(hitid,:);
%exceeds = exceeds_(hitid,:);


    
        

