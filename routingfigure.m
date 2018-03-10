    %%figure
    fig_position = figure; 
    x= [position(:,2)];
    y= [position(:,3)];
    % plot larger red circles with black edges
    plot(x,y,'o', 'MarkerEdgeColor','k',...      
                  'MarkerFaceColor','r',...
                  'MarkerSize',8);
    hold on
    plot(0,0, 'gs', 'MarkerEdgeColor','b',...
                    'MarkerFaceColor', [0,0,0],...
                    'MarkerSize',8);
    % set the axis limits
    axis([-range/2-1,range/2+1,-range/2-1,range/2+1]);
    title('Node Position')
    hold off 


%%figure
    fig_routing = figure; 
    for i = 2:1:size(routetable,2)
        figtemp = unique(routetable(:,i-1:i),'rows')
        for j = 1:1:size(figtemp,1)
            x= figtemp(j,1)
            y= figtemp(j,2)
            if y ~= 0
                if x == 0
                    plot([0,position(y,3)],[0,position(y,2)]);
                    position(y,2:3)
                else
                    plot([position(x,2),position(y,2)], [position(x,3),position(y,3)]);
                end
            end
            hold on
        end
    end
            
%     % plot larger red circles with black edges
%     plot(x,y,'o', 'MarkerEdgeColor','k',...      
%                   'MarkerFaceColor','r',...
%                   'MarkerSize',8);
%     hold on
%     plot(0,0, 'gs', 'MarkerEdgeColor','b',...
%                     'MarkerFaceColor', [0,0,0],...
%                     'MarkerSize',8);
%     % set the axis limits
%     axis([-range/2-1,range/2+1,-range/2-1,range/2+1]);
    title('Routing')
    hold off