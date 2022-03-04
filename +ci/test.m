function exitFlag = test()
% ci.test Enable to run test in CI
%%
% Prepare diary file
diary("log.txt");
%%
% Prepare exit flag and load Project in the current folder
exitFlag = -1;
ME = [];
matlab.project.loadProject(pwd);
%%
% Run test
try
    result = run_testSuites();
    exitFlag = nnz([result.Incomplete]');
catch ME
    disp(ME)
end
%%
% Deactivate diary
diary off
end