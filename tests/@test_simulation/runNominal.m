function runNominal(testCase)
%RUN Simulate demo models

% Prepare simulation
in = Simulink.SimulationInput("sldemo_fuelsys_dd");
% Configure simulation
in = in.setModelParameter("StopTime",testCase.stopTime);
in = in.setModelParameter("Profile",'on');
% Run simuation
testCase.verifyWarningFree(@() in.sim);
end