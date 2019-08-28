classdef waitbar1 < handle
    % WAITBAR1 creats waitbar which does not need to be updated. It runs
    % parallel with any process runing in MATLAB.
    %
    % Object = waitbar1 Creats a waitbar with figure name as "Waitbar1"
    % and bar title as "Please Wait ... ".
    % Object = waitbar1(name,barTitle) Creats a waitbar with give figure
    % name and bar title.
    % 
    % delete(object) deletes the waitbar1 figure;
    
    properties (Hidden);
        fig; % figure handle
        axs; % axes handle
        bord; % border handle
        fll; % plot handle
        barTitle; % bar title
        pos; % waitbar position on axes
        runner; % timer handle
    end
    
    methods (Access = public)
        function object = waitbar1(name,barTitle)
            switch nargin 
                case 0
                    name = 'Waitbar1';
                    barTitle = 'Please Wait ...';
                case 1
                    barTitle = 'Please Wait ...';
            end
            object.creatFigure(name,barTitle);
            object.runner = timer('TimerFcn',@(src,event) runWaitbar1(object,src,event),...
                'ExecutionMode','fixedRate',...
                'Period',0.007,...
                'TasksToExecute',Inf);
            start(object.runner);
        end
        
        function delete(object)
            % delete(object) delete the waitbar1 object;
            stop(object.runner);
            close(object.fig);
            clear class;
        end
        
    end
    
    methods (Access = private)
        function creatFigure(object,name,barTitle)
            % creatFigure(object,name,barTitle) creat waitbar1 figure with
            % given name and barTitle.
            object.barTitle = barTitle;
            scr = get(0,'screensize');
            height = 60;
            width = 350;
            position = [scr(3)/2 - width/2, scr(4)/2 - height/2, width, height];
            object.fig = figure('Name',name,...
                'position',position,...
                'menu','none',...
                'numbertitle','off');
            % axes
            object.axs = axes('parent',object.fig,...
                'units','pixel',...
                'position',[25,15,300,15],...
                'xticklabel',[],...
                'yticklabel',[],...
                'xtick',[],...
                'ytick',[],...
                'xlim',[0 1],...
                'ylim',[0 1],...
                'nextplot','add');
            title(object.barTitle);
            % bar
            object.bord = line([0 1 1 0 0],[0 0 1 1 0],'color',[0 0 0]);
            object.fll = fill([-0.2 0 0 -0.2 -0.2],[0 0 0.98 0.98 0],[0 0.75 0.1]);
            object.pos = 0;
        end
        
        function runWaitbar1(object,~,~)
            % runWaitbar1(object,src,event) updates the waitbar
            if object.pos > 1.2
                object.pos = 0;
                set(object.fll,'xdata',[-0.2 0 0 -0.2 -0.2]);
            else
                object.pos = object.pos + 0.001;
                set(object.fll,'xdata',get(object.fll,'xdata')+0.001.*ones(5,1));
            end
        end
    end

end
