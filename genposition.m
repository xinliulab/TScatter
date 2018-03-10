function position = genposition(number, range)
    position = [[1:number]',rand(number,2)*range - range/2]; 
    
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
end