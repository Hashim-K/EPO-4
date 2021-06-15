classdef Beacon
    %BEACON Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    Fs; %Sampling Frequency
    Fb; %Bit Frequency
    Fc; %Carrier Frequency
    Rc; %Repetition Counter
    C; %Code
    end
    
    methods
        function obj = Beacon(Fsample, Fbit, Fcarrier, Rcount, Code)
            obj.Fs = Fsample; %Sampling Frequency
            obj.Fb=Fbit; %Bit Frequency
            obj.Fc=Fcarrier; %Carrier Frequency
            obj.Rc=Rcount; %Repetition Counter
            obj.C=Code; %Code
        end
        
        %set methods
        function obj = set.Fs(obj,Fsample)
            obj.Fs = Fsample;
        end
    
        function obj = set.Fb(obj,Fbit)
            obj.Fb = Fbit;
        end
        
        function obj = set.Fc(obj,Fcarrier)
            obj.Fc = Fcarrier;
        end
    
        function obj = set.Rc(obj,Rcount)
            obj.Rc = Rcount;
        end
        
        function obj = set.C(obj,Code)
            obj.C = Code;
        end
        
        
        %get methods
        function Fsample = get.Fs(obj)
            Fsample = obj.Fs;
        end
        
        function Fbit = get.Fb(obj)
            Fbit = obj.Fb;
        end
        
        function Fcarrier = get.Fc(obj)
            Fcarrier = obj.Fc;
        end
        
        function Rcount = get.Rc(obj)
            Rcount = obj.Rc;
        end
        
        function Code = get.C(obj)
            Code = obj.C;
        end
    end
end

