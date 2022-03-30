function runNominal(testCase,provokeWarning)
%RUN Simulate demo models

% Provoke model warning if asked
if provokeWarning
    load_system(testCase.modelName)
    add_block("simulink/Sinks/Scope",testCase.modelName+"/MyScope");
end
% Prepare simulation
in = Simulink.SimulationInput(testCase.modelName);
% Configure simulation
in = in.setModelParameter("StopTime",testCase.stopTime);
in = in.setModelParameter("Profile",'on');
% Run simuation
testCase.assumeWarningFree(@() in.sim);
end