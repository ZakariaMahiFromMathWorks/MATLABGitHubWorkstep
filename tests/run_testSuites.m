% Copyright 2021 The MathWorks Inc.
function result = run_testSuites()
% RUN_TESTSUITE run all tests located in hardcoded list of directory.
% function has as an optional input the test class file path. If no
% argument all tests will be run
%
% example of usage: run_testsuite
%                   run_testsuite('fileToTest',which(fileName))
%

%% Initialization
import matlab.unittest.TestSuite;
import matlab.unittest.TestRunner;
import matlab.unittest.plugins.CodeCoveragePlugin;
import matlab.unittest.plugins.codecoverage.CoverageReport;
import matlab.unittest.plugins.TestReportPlugin;
import matlab.unittest.plugins.TAPPlugin;
import matlab.unittest.plugins.ToFile;
import matlab.unittest.plugins.XMLPlugin;

%%
% Define folders
mlProject = currentProject;
resultFolderName = "test_result";
resultFolder = fullfile(mlProject.RootFolder,resultFolderName);
if ~exist(resultFolder,'dir')
    mkdir(resultFolder)
end
testsFolder = fileparts(mfilename('fullpath'));
%% Instantiate test runner
runner = TestRunner.withTextOutput;

%% JUnit Format xml file
resultsFile = "testResults.xml";
% Add to runner
runner.addPlugin(XMLPlugin.producingJUnitFormat(resultsFile))
%%
% * Prepare the hmtl file report
runner.addPlugin(TestReportPlugin.producingHTML(fullfile(resultFolder,"report"),...
    'IncludingCommandWindowText',true,...
    'Verbosity',3))

folderNameToTest = fullfile(mlProject.RootFolder,"tests","@test_simulation");
reportFileName = fullfile(resultFolder,"coverage");
runner.addPlugin(CodeCoveragePlugin.forFolder(folderNameToTest,...
    'IncludingSubfolders',true,...
    'Producing',CoverageReport(reportFileName)));
%%
% Define artifact result folder
runner.ArtifactsRootFolder = resultFolder;
%% Create test suite from defined tests
    ts = TestSuite.fromFolder(testsFolder, 'IncludingSubfolders', true);

%% Run tests

% Track tests execution time
result = runner.run(ts);

%% Output summary in command window
if any(result.table.Failed) || any(result.table.Incomplete)
    result.table
else
    fprintf(1,">> All tests passed.\n");
end
fprintf('Tests executed in %.2f seconds.\n', sum(result.table.Duration));