function test_suite=AbstractModel_Test
try % assignment of 'localfunctions' is necessary in Matlab >= 2016
    test_functions=localfunctions();
catch % no problem; early Matlab versions can use initTestSuite fine
end
initTestSuite;


function test_main
testCase.modelObject = qmt_spgr;
testCase.modelObject.st(1) = 0; % do a arbitrary modification
testCase.tempFileName = 'tmp.qMRLab.mat';
if exist(testCase.tempFileName, 'file') == 2
    delete(testCase.tempFileName)
end

save_load_creates_identical_original_object(testCase)

initialized_object_has_correct_version_val(testCase)

save_load_retains_same_version(testCase)

close all


function save_load_creates_identical_original_object(testCase)
%% Prep
%

originalObject = testCase.modelObject;

%% Save
%

testCase.modelObject.saveObj(testCase.tempFileName);

%% Load
%

loadedObject = testCase.modelObject;
loadedObject.loadObj(testCase.tempFileName);

%% Test
%
assertEqual(originalObject, loadedObject, 'Some Properties Mismatch');

function TestTeardown
delete tmp.qmrlab.mat

function initialized_object_has_correct_version_val(testCase)
assertEqual(testCase.modelObject.version, qMRLabVer);


function save_load_retains_same_version(testCase) 
%% Prep
%

originalObject = testCase.modelObject;
originalVersion = originalObject.version;

%% Save
%

testCase.modelObject.saveObj(testCase.tempFileName);

%% Load
%

loadedObject = testCase.modelObject;
loadedObject.loadObj(testCase.tempFileName);
loadedVersion = loadedObject.version;

assertEqual(originalVersion, loadedVersion, 'Some Properties Mismatch');



