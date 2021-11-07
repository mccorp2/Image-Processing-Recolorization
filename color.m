classdef color
    %COLOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        red
        green
        blue
        points      
    end
    
    methods
        function obj = color(r, g, b, x, y)
            %COLOR Construct an instance of this class
            %   Detailed explanation goes here
            obj.red = r;
            obj.green = g;
            obj.blue = b;
            obj.points = [x, y];
        end
        
        function obj = addPoint(obj, x, y)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            obj.points = [obj.points; [x, y]];
        end
        
        function returnedColor = returnColor(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            returnedColor = [obj.red, obj.green, obj.blue];
        end
        
        function returnedPoints = returnPoints(obj)
            %METHOD1 Summary of this method goes here
            %   Detailed explanation goes here
            returnedPoints = obj.points;
        end
    end
end

