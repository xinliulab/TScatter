function fig = routingfigure(range, position, routetable)  
 
    fig = figure; 
   
    %% Position figure
    id = [position(:,1)]
    x= [position(:,2)];
    y= [position(:,3)];
    % plot larger red circles with black edges
    plot(x,y,'o', 'MarkerEdgeColor','k',...      
                  'MarkerFaceColor','w',...
                  'MarkerSize',8);        
    hold on
    
    for i=1:length(position)
        text(position(i,2)+0.1,position(i,3), num2str(position(i,1)),'FontSize',15,'Color','r');
    end
    %text(xd, yd, nl, ...
    %'FontSize',18, ...
    %'FontWeight','bold',...
    %'HorizontalAlignment','left', ...
    %'VerticalAlignment','middle')
    hold on
    
    plot(0,0, 'gs', 'MarkerEdgeColor','b',...
                    'MarkerFaceColor', 'r',...
                    'MarkerSize',8);
    % set the axis limits
    axis([-range/2-1,range/2+1,-range/2-1,range/2+1]);
    hold on

    c=['b','g','m','c','r','k'];
    for i = 2:1:size(routetable,2)
        figtemp = unique(routetable(:,i-1:i),'rows');
        for j = 1:1:size(figtemp,1)
            x= figtemp(j,1);
            y= figtemp(j,2);
            if y ~= 0
                if x == 0
                    plot([0,position(y,2)],[0,position(y,3)],'Color',c(i));
                else
                    plot([position(x,2),position(y,2)], [position(x,3),position(y,3)],'Color','b');
                end
            end
            hold on
        end
    end
    
    title('Routing')
    hold off
end