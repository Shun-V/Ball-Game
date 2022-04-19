%% Setup
set(0, "defaultfigurewindowstyle", "normal");
%% Background
monitor_size = get(0, "ScreenSize");
%% Create Board
board_figure = figure('position', [monitor_size(3:4)*0.3, monitor_size(3:4)*0.4], 'MenuBar','none');
set(board_figure, 'resize', 'off', 'color', 'w');
%% Set axis
board_axes = axes;
set(board_axes, 'position', [0.05, 0.05, 0.9, 0.9], 'color', [150, 200, 200]/255);
set(board_axes, 'xlim', [-1 1], 'ylim', [-1 1], 'xtick', [], 'ytick', []);
hold(board_axes, "on");
%% Plot Edges
plot(repmat(get(board_axes, 'xlim'),2,1), bsxfun(@times, [-1 -1], [1, -1]'), 'r');
plot(repmat(get(board_axes, 'xlim'),2,1), bsxfun(@times, [-1 -1], [1, -1]')', 'r');
%% Draw line test
h(1) = plot(get(board_axes,'xlim'),[0,0],'w--');
h(2) = plot([0,0],get(board_axes,'ylim'),'w--');
%set(h,'color',[200,200,150]/255) %Set line color
%% Set title
text_title = text(0, 1.06, 'Ball Game Example');
set(text_title, 'color', 'k', 'fontsize', 20, 'HorizontalAlignment', 'center');
%% Define Ball
angles = linspace(0.25*pi, 0.75*pi, 100);
%angles = linspace(0, pi, 100);
%polar(angles, ones(1, length(move_angle)), 's')
speed_x = 70;
speed_y = 70;
ball_angle = angles(randi(length(angles), 1));
ball_pos = [0, 0];
global ball_dir
ball_dir = [cos(ball_angle)/speed_x sin(ball_angle)/speed_y];
global t0
t0 = now
ball = plot(ball_pos(1), ball_pos(2),'o');
set(ball, 'markersize', 20, 'markerfacecolor','k');
%% Start
game_over = deal(false)
while true
    % update boundry move direction
    % ball_dir(abs(ball_pos) > 0.98) = - ball_dir(abs(ball_pos) > 0.98);
    if abs(ball_pos(1)) > 0.98
        ball_dir(1) = -ball_dir(1)
    end
    if ball_pos(2) > 0.98
        ball_dir(2) = -ball_dir(2)
    end
    % Set click reaction
    set(board_figure, 'ButtonDownFcn', @func)
    set(board_axes, 'ButtonDownFcn', @func)
    % Set Game Over Condition
    if ball_pos(2) < -0.98
        game_over = true;
        ball_pos = [0 0];
    end
    % update position
    ball_gra = [0 -1e3*(now - t0)];
    ball_pos = ball_pos + ball_dir + ball_gra;
    set(ball, 'xdata', ball_pos(1), 'ydata', ball_pos(2));
    drawnow;
    % Show Game Score
    if game_over
        set(board_axes, 'color', 'r')
        pause(3)
        set(board_axes, 'color', [150, 200, 200]/255)
        game_over = deal(false)
        t0 = now
    end
end
function func(~,~)
    global t0 ball_dir
    t0 = now
    ball_dir(2) = abs(ball_dir(2))
end