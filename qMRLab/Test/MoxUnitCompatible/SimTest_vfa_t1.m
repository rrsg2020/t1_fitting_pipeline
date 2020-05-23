function test_suite=SimTest_vfa_t1
try % assignment of 'localfunctions' is necessary in Matlab >= 2016
test_functions=localfunctions();
catch % no problem; early Matlab versions can use initTestSuite fine
end
initTestSuite;

function TestSetup
setenv('ISDISPLAY','0') % go faster! Fit only 2 voxels in FitData.m

function test_Sim
disp('===========================================')
disp('Running simulation test for vfa_t1');
disp('testing Simulation Single Voxel Curve...');


Model = str2func('vfa_t1'); Model = Model();
savedModel_fname = 'vfa_t1.qmrlab.mat';
if ~exist(savedModel_fname,'file')
Model.saveObj(savedModel_fname);
else
Model = Model.loadObj(savedModel_fname);
end

disp(class(Model))
try Opt = button2opts(Model.Sim_Single_Voxel_Curve_buttons,1); end
try st = Model.st; catch, try st = mean([Model.lb(:),Model.ub(:)],2); catch, st = ones(length(Model.xnames),1); end; end
if exist('Opt','var') && length(Opt)>1
[Opt(:).SNR] = deal(1000);
else
Opt.SNR=1000;
end
for iopt=1:length(Opt) % Test all simulation options
disp(['Testing ' class(Model) ' simulation option:'])
disp(Opt(iopt))
FitResults = Model.Sim_Single_Voxel_Curve(st,Opt(iopt));
% Compare inputs and outputs
fnm=fieldnames(FitResults);
FitResults = rmfield(FitResults,fnm(~ismember(fnm,Model.xnames))); fnm=fieldnames(FitResults);
[~,FitResults,GroundTruth]=comp_struct(FitResults,mat2struct(st,Model.xnames),[],[],.30);
assertTrue(isempty(FitResults) & isempty(GroundTruth),evalc('FitResults, GroundTruth'))
end
disp ..ok


function TestTeardown
setenv('ISDISPLAY','') % go faster! Fit only 2 voxels in FitData.m
