function Mousecallback(figHandle,varargin)
    % maximum distance allowed to consider a graphics object selected (arbitrary)
    DISTANCE_THRESHOLD = 2;
    % get the handles structure
    handles = guidata(figHandle);
    % get the position where the mouse button was pressed (not released)
    % within the GUI
    currentPoint = get(figHandle, 'CurrentPoint');
    x            = currentPoint(1,1);
    y            = currentPoint(1,2);
    % get the position of the axes within the GUI
    axesPos = get(handles.axes1,'Position');
    minx    = axesPos(1);
    miny    = axesPos(2);
    maxx    = minx + axesPos(3);
    maxy    = miny + axesPos(4);
    % is the mouse down event within the axes?
    if x>=minx && x<=maxx && y>=miny && y<=maxy 
        % do we have graphics objects?
        if isfield(handles,'plotHandles')
            % get the position of the mouse down event within the axes
            currentPoint = get(handles.axes1, 'CurrentPoint');
            x            = currentPoint(2,1);
            y            = currentPoint(2,2);
            % we are going to use the x and y data for each graphic object
            % and determine which one is closest to the mouse down event
            minDist      = Inf;
            minHndlIdx   = 0;
           for k=1:length(handles.plotHandles)
               xData = get(handles.plotHandles(k),'XData');
               yData = get(handles.plotHandles(k),'YData');
               dist  = min((xData-x).^2+(yData-y).^2); 
               if dist<minDist && dist<DISTANCE_THRESHOLD
                   minHndlIdx = k;
                   minDist = dist;
               end
           end
           % if we have a graphics handle that is close to the mouse down
           % event/position, then save its index into the plotHandles array
           if minHndlIdx~=0
               handles.graphicToDeleteHandleIdx = minHndlIdx;
           else
               handles.graphicToDeleteHandleIdx = [];
           end
           % change the line style of the selected object
           for k=1:length(handles.plotHandles)
               if k==minHndlIdx
                   set(handles.plotHandles(k),'LineStyle',':');
               else
                   set(handles.plotHandles(k),'LineStyle','-');
               end
           end
           guidata(figHandle,handles);
        end
    end