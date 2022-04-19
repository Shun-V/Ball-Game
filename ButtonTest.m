%% Test 1
f=figure(1);
set(f,'WindowButtonDownFcn',@mytestcallback)
for i = 1:100
    im = rand(500,500);
    imshow(im)
    drawnow();   
end
%% Test 2
f = figure;
ax = axes;
p = patch(rand(1,3),rand(1,3),'g');
l = line([1 0],[0 1]);
set(f,'ButtonDownFcn',@(~,~)disp('figure'),...
   'HitTest','off')
set(ax,'ButtonDownFcn',@(~,~)disp('axes'),...
   'HitTest','off')
set(p,'ButtonDownFcn',@(~,~)disp('patch'),...
   'PickableParts','all','FaceColor','none')
set(l,'ButtonDownFcn',@(~,~)disp('line'),...
   'HitTest','off')
%% Test 3
function [Xsig,Ysig] = GetPoint(Figure)
set(Figure,'ButtonDownFcn', @ExtractPoint) ;
    function ExtractPoint(ClickedPoint,~)
        waitforbuttonpress ;
        Xsig = get(ClickedPoint,'XData') ;
        Ysig = get(ClickedPoint,'YData') ;
    end
end
%% Test 4
x = rand(100,1);                       % generate random data
y = rand(100,1);
h = plot(x,y,'.r');                    % plot data
set([h gcf],'hittest','off')           % turn off hittest 
set(gca ,'buttondownfcn',@func)         % assign function to gca
    function func(hobj,~)
        p  = get(hobj,'currentpoint'); % get coordinates of click
        d = pdist2([x y],p([1 3]));    % find combination of distances
        [~,ix] = min(d);               % find smallest distance
        line(x(ix),y(ix),'linestyle','none','marker','o')
        [x(ix),y(ix)]
    end
