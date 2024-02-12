classdef Bot_Pioneer < handle
    properties (Access = private)
        CoppeliaSim = [];
        ClientID = [];
        
        Pioneer = [];
        motorL = [];
        motorR = [];

        camera = [];
        
        wl = -2.5*ones(2,1);
        wu = 2.5*ones(2,1);
    end
    
    methods
        function obj = Bot_Pioneer()
            obj.CoppeliaSim = remApi('remoteApi');
            obj.CoppeliaSim.simxFinish(-1);
            disp('Connecting to robot....')
            obj.ClientID = obj.CoppeliaSim.simxStart('127.0.0.1',19999,true,true,5000,5); 
            
            if obj.ClientID==0
                [~,obj.Pioneer] = obj.CoppeliaSim.simxGetObjectHandle(obj.ClientID,'/PioneerP3DX',obj.CoppeliaSim.simx_opmode_oneshot_wait);
                [~,obj.motorL] = obj.CoppeliaSim.simxGetObjectHandle(obj.ClientID,'/PioneerP3DX/leftMotor',obj.CoppeliaSim.simx_opmode_oneshot_wait);
                [~,obj.motorR] = obj.CoppeliaSim.simxGetObjectHandle(obj.ClientID,'/PioneerP3DX/rightMotor',obj.CoppeliaSim.simx_opmode_oneshot_wait);

                [~,obj.camera] = obj.CoppeliaSim.simxGetObjectHandle(obj.ClientID,'/PioneerP3DX/kinect/rgb',obj.CoppeliaSim.simx_opmode_oneshot_wait);
                [~,~] = obj.CoppeliaSim.simxGetStringSignal(obj.ClientID,'measuredDataAtThisTime',obj.CoppeliaSim.simx_opmode_streaming);
                pause(1)

                disp(' done.')
            else
                error(' robot not connected...')
            end
        end
        
        function p = Get_Pose (obj)
            aux = ones(2,1);

            while sum(aux)~=0
                if obj.CoppeliaSim.simxGetConnectionId(obj.ClientID)==1
                    [aux(1),position] = obj.CoppeliaSim.simxGetObjectPosition(obj.ClientID,obj.Pioneer,-1,obj.CoppeliaSim.simx_opmode_streaming);
                    [aux(2),orientation] = obj.CoppeliaSim.simxGetObjectOrientation(obj.ClientID,obj.Pioneer,-1,obj.CoppeliaSim.simx_opmode_streaming);
                    
                    p = double([position(1) position(2) orientation(3)]');
                else
                    error(' connection lost...')
                end
            end
        end

        function img = Get_Image (obj)
            aux = 1;
            
            while aux~=0
                if obj.CoppeliaSim.simxGetConnectionId(obj.ClientID)==1
                    [aux,~,img] = obj.CoppeliaSim.simxGetVisionSensorImage2(obj.ClientID,obj.camera,0,obj.CoppeliaSim.simx_opmode_streaming);
                else
                    error(' connection lost...')
                end
            end
        end
        
        function [Angles,Ranges] = Get_LaserScans (obj)
            if obj.CoppeliaSim.simxGetConnectionId(obj.ClientID)==1
                [result,data] = obj.CoppeliaSim.simxGetStringSignal(obj.ClientID,'measuredDataAtThisTime',obj.CoppeliaSim.simx_opmode_streaming);

                if result~=0
                    error(' error in reading laser scan...');
                else
                    laserData = obj.CoppeliaSim.simxUnpackFloats(data);
                    laserDataX = double(laserData(1:2:end-1));
                    laserDataY = double(laserData(2:2:end));
                    [Angles,Ranges] = cart2pol(laserDataX,laserDataY);
                end
            else
                error(' connection lost...')
            end
        end
        
        function obj = Set_Joint_Velocity (obj,w)
            if obj.CoppeliaSim.simxGetConnectionId(obj.ClientID)==1
                w = max(w,obj.wl); w = min(w,obj.wu);
                
                obj.CoppeliaSim.simxSetJointTargetVelocity(obj.ClientID,obj.motorR,w(1),obj.CoppeliaSim.simx_opmode_streaming);
                obj.CoppeliaSim.simxSetJointTargetVelocity(obj.ClientID,obj.motorL,w(2),obj.CoppeliaSim.simx_opmode_streaming);
            else
                error(' connection lost...')
            end
        end

        function s = Connection(obj)
            s = obj.CoppeliaSim.simxGetConnectionId(obj.ClientID);
        end

        function Stop_Simulation (obj)
            obj.CoppeliaSim.simxStopSimulation(obj.ClientID,obj.CoppeliaSim.simx_opmode_oneshot_wait);
        end
    end
end