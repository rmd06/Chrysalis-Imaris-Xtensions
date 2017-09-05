function manuallimits3(hObject, eventData, figSortomatoGraph)
    % MANUALLIMITS3 Toggle manual axes limits
    %   Detailed explanation goes here
    %
    
    %% Check for an existing limit adjustment figure.
    guiLimits = getappdata(figSortomatoGraph, 'guiLimits');

    % If the adjustment window exists, raise it and return.
    if ~isempty(guiLimits)
        figure(guiLimits)
        return
    end
    
    %% Set the figure and font colors.
    if all(get(figSortomatoGraph, 'Color') == [0 0 0])
        bColor = 'k';
        fColor = 'w';

    else
        bColor = 'w';
        fColor = 'k';
        
    end % if
    
    %% Create the adjustment figure.
    % Get the parent figure position.
    graphPos = get(figSortomatoGraph, 'Position');

    guiWidth = 230;
    guiHeight = 214;
    guiPos = [graphPos(1) + graphPos(3)/2 - guiWidth/2, ...
        graphPos(2) + graphPos(4)/2 - guiHeight/2, ...
        guiWidth, ...
        guiHeight];
                
    % Create the figure.
    guiLimits = figure(...
        'Color', bColor, ...
        'CloseRequestFcn', {@closerequestfcn, figSortomatoGraph}, ...
        'MenuBar', 'none', ...
        'Name', 'Axes limits', ...
        'NumberTitle', 'off', ...
        'Position', guiPos, ...
        'Resize', 'off', ...
        'Tag', 'guiLimits');
    
    %% Create the adjustment edit boxes.
    axesGraph = findobj(figSortomatoGraph, 'Tag', 'axesGraph');
    
    % Z adjustment boxes:
    uicontrol(...
        'Background', bColor, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'HorizontalAlign', 'Left', ...
        'Position', [10 16 50 24], ...
        'Parent', guiLimits, ...
        'String', 'Z Range', ...
        'Style', 'text', ...
        'Tag', 'textZRange');

    zInitial = get(axesGraph, 'ZLim');
    editZMin = uicontrol(...
        'Background', bColor, ...
        'Callback', @setzlim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [75 20 50 24], ...
        'String', zInitial(1), ...
        'Style', 'edit', ...
        'Tag', 'editYMin');

    editZMax = uicontrol(...
        'Background', bColor, ...
        'Callback', @setzlim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [165 20 50 24], ...
        'String', zInitial(2), ...
        'Style', 'edit', ...
        'Tag', 'editYMax');

    % Y adjustment boxes:
    uicontrol(...
        'Background', bColor, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'HorizontalAlign', 'Left', ...
        'Position', [10 66 50 24], ...
        'Parent', guiLimits, ...
        'String', 'Y Range', ...
        'Style', 'text', ...
        'Tag', 'textYRange');

    yInitial = get(axesGraph, 'YLim');
    editYMin = uicontrol(...
        'Background', bColor, ...
        'Callback', @setylim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [75 70 50 24], ...
        'String', yInitial(1), ...
        'Style', 'edit', ...
        'Tag', 'editYMin');

    editYMax = uicontrol(...
        'Background', bColor, ...
        'Callback', @setylim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [165 70 50 24], ...
        'String', yInitial(2), ...
        'Style', 'edit', ...
        'Tag', 'editYMax');

    % X adjustment boxes:
    uicontrol(...
        'Background', bColor, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'HorizontalAlign', 'Left', ...
        'Parent', guiLimits, ...
        'Position', [10 116 50 24], ...
        'String', 'X Range', ...
        'Style', 'text', ...
        'Tag', 'textXRange');

    xInitial = get(axesGraph, 'XLim');
    editXMin = uicontrol(...
        'Background', bColor, ...
        'Callback', @setxlim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [75 120 50 24], ...
        'String', xInitial(1), ...
        'Style', 'edit', ...
        'Tag', 'editXMin');

    editXMax = uicontrol(...
        'Background', bColor, ...
        'Callback', @setxlim, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [165 120 50 24], ...
        'String', xInitial(2), ...
        'Style', 'edit', ...
        'Tag', 'editXMax');

    %% Create the min/max labels.
    uicontrol(...
        'Background', bColor, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [70 144 60 24], ...
        'String', 'Minimum', ...
        'Style', 'text', ...
        'Tag', 'textMinimum');

    uicontrol(...
        'Background', bColor, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'Parent', guiLimits, ...
        'Position', [160 144 60 24], ...
        'String', 'Maximum', ...
        'Style', 'text', ...
        'Tag', 'textMaximum');

    %% Create a checkbox to activate manual editing.
    if strcmp(get(axesGraph, 'XLimMode'), 'auto')
        currentLimMode = 1;
        
    else
        currentLimMode = 0;
        
    end % if

    checkAutoLimits = uicontrol(...
        'Background', bColor, ...
        'Callback', {@checkmanuallimits}, ...
        'FontSize', 10, ...
        'Foreground', fColor, ...
        'HorizontalAlign', 'Left', ...
        'Position', [10 170 210 24], ...
        'Parent', guiLimits, ...
        'String', 'Automatic limits', ...
        'Style', 'checkbox', ...
        'Tag', 'checkAutoLimits', ...
        'Value', currentLimMode);
    
    %% Set the stack order to make the tab sequence logical.
    uistack(editYMax, 'bottom')
    uistack(editYMin, 'bottom')
    uistack(editXMax, 'bottom')
    uistack(editXMin, 'bottom')
    uistack(checkAutoLimits, 'bottom')
    
    %% Store the adjustment figure's handle in the appdata of the main figure.
    setappdata(figSortomatoGraph, 'hLimits', guiLimits)

    %% Attach listeners to the axes to update the limits on a limit change.
    addlistener(axesGraph, 'XLim', 'PostSet', ...
        @(hSrc, eventData)limitsync(hSrc, eventData, editXMin, editXMax));
    addlistener(axesGraph, 'YLim', 'PostSet', ...
        @(hSrc, eventData)limitsync(hSrc, eventData, editYMin, editYMax));
    addlistener(axesGraph, 'ZLim', 'PostSet', ...
        @(hSrc, eventData)limitsync(hSrc, eventData, editZMin, editZMax));

    %% Nested function to activate manual limit adjustment
    function checkmanuallimits(varargin)
        %
        %
        %
        
        %% Respond to the check state.
        if get(checkAutoLimits, 'Value')
            axis(axesGraph, 'auto')
                
        else
            axis(axesGraph, 'manual')
                
        end % if
    end
    
    %% Nested functions for axes limit adjustments
    function setxlim(varargin)
        %% Get the current x limits.
        currentXLim = get(axesGraph, 'XLim');

        %% Get the desired range.
        xMin = str2double(get(editXMin, 'String'));
        xMax = str2double(get(editXMax, 'String'));

        %% Test for a valid range, then update or reset.
        if get(checkAutoLimits, 'Value') || any(isnan([xMin, xMax])) || xMin >= xMax
            % Reset the x editbox values.
            set(editXMin, 'String', currentXLim(1))
            set(editXMax, 'String', currentXLim(2))

        else
            % Update the axes range.
            set(axesGraph, 'XLim', [xMin xMax])

        end % if
    end % setxlim

    function setylim(varargin)
        %% Get the current y limits.
        currentYLim = get(axesGraph, 'YLim');

        %% Get the desired range.
        yMin = str2double(get(editYMin, 'String'));
        yMax = str2double(get(editYMax, 'String'));

        %% Test for a valid range, then update or reset.
        if get(checkAutoLimits, 'Value') || any(isnan([yMin, yMax])) || yMin >= yMax
            % Reset the y editbox values.
            set(editYMin, 'String', currentYLim(1))
            set(editYMax, 'String', currentYLim(2))

        else
            % Update the axes range.
            set(axesGraph, 'YLim', [yMin yMax])

        end % if
    end % setylim
    
    function setzlim(varargin)
        %% Get the current y limits.
        currentYLim = get(axesGraph, 'ZLim');

        %% Get the desired range.
        zMin = str2double(get(editZMin, 'String'));
        zMax = str2double(get(editZMax, 'String'));

        %% Test for a valid range, then update or reset.
        if get(checkAutoLimits, 'Value') || any(isnan([zMin, zMax])) || zMin >= zMax
            % Reset the y editbox values.
            set(editZMin, 'String', currentYLim(1))
            set(editZMax, 'String', currentYLim(2))

        else
            % Update the axes range.
            set(axesGraph, 'ZLim', [zMin zMax])

        end % if
    end % setzlim
end % manuallimits3


%% Sync function for the adjustment figure
function limitsync(~, eventData, editMin, editMax)
    %
    %
    %

    if ishandle(editMin)
        %% Get the limits.
        limitValue = eventData.NewValue;

        %% Set the edit min and max boxes.
        set(editMin, 'String', limitValue(1))
        set(editMax, 'String', limitValue(2))
    end % if
end % limitsync

        
function closerequestfcn(hObject, ~, figSortomatoGraph)
    % Close sortomato sub-GUIs
    %
    %
    
    %% Remove the GUI handle appdata and delete.
    rmappdata(figSortomatoGraph, 'guiLimits')
    delete(hObject);
end % closerequestfcn