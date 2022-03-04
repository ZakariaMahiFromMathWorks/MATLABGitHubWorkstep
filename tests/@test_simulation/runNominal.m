function runNominal(testCase)
%RUN Simulate demo models

% Prepare simulation
in = Simulink.SimulationInput("'sldemo_fuelsys_dd");
% Configure simulation
in = in.setModelParameter("SimulationMode",'accelerator');
in = in.setModelParameter("Profile",'on');
% Run simuation
out = testCase.verifyWarningFree(@() in.sim);
end