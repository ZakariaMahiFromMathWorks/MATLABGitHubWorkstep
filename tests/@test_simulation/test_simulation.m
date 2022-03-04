classdef test_simulation < matlab.unittest.TestCase
    %TEST_RUN_SIMULATION Run simulation of the demo

    properties (TestParameter)
        provokeWarning = struct(...
            "doNotProvokeWarning",false,...
            "doProvokeWarning",true);
    end

    properties
        modelName = "sldemo_fuelsys_dd" % Model name to test
        stopTime = '100' % Simulation duration
    end

    methods (TestMethodTeardown)
        function TMT(testCase)
            bdclose(testCase.modelName)
        end
    end

    methods (Test)
        % Run nominal simulation
        runNominal(testCase,provokeWarning)
    end
end