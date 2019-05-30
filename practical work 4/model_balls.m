% ��������� ������� model_balls:
% v1, v2 - ��������� �������� �����
% x1, x2 - ��������� ���������� �����
% r1, r2 - ������� �����
% m1, m2 - ����� �����
% t - ����� �������������
% dt - ��� �������
% ft - ����� ������ ������ �����

function model_balls(v1, x1, m1, r1, v2, x2, m2, r2, t, dt, ft)
    % ������� �������
    bounds = [0 0; 2 2];
    
    % �������� � ��������� ������� ���������
    figure;
    ah = axes;
    axis(ah, 'equal');
    xlim(ah, bounds(:, 1));
    ylim(ah, bounds(:, 2));
    grid(ah, 'on');
    hold(ah, 'on');
    
    % ��������� �����
    h1 = draw_ball(x1, r1, '-b');
    h2 = draw_ball(x2, r2, '-r');
    
    for i = 0:dt:t
        title(ah, sprintf('t = %.4f', i));
        
        %�������� ����� � ����
        delete(h1);
        delete(h2);
        
        %���������� ����� �������� �����
        d = sqrt(sum((x1 - x2).^2));
        
        if d <= (r1 + r2)
            %������ ������������ �����
            [v1, v2] = collide_balls(v1, x1, m1, v2, x2, m2);
        end
        
        %������ ��������� �����
        a1 = gravitation(x1, x2, m2);
        a2 = gravitation(x2, x1, m1);
        %������ ��������
        v1 = v1 + a1 * dt;
        v2 = v2 + a2.* dt;
        
        %������ ����� ��������� ������� �����
        x1 = x1 + v1 .* dt;
        x2 = x2 + v2 .* dt;
        
        %��������� �����
        h1 = draw_ball(x1, r1, '-b');
        h2 = draw_ball(x2, r2, '-r');
        
        pause(ft);
    end
end

%������ ���������
%x1 - ���������� ����, �� ������� ��������� ����
%x2 - ���������� ����, ������� ��������� ���� �� ������
function a = gravitation(x1, x2, m)
    r = sqrt(sum((x1 - x2).^2));    %���������� ����� �������� �����
    e = (x2 - x1)/r;                %��������� ������, �������� ����������� ���������
    G = 6.6720e-11;
    a = e * G*m/r;
end

%x - ���������� ������ ����
%r - ������ ����
%format � ������ ������� �����
function h = draw_ball(x, r, format)
    t = linspace(0, 2 * pi);
    h = plot(x(1) + r * sin(t), x(2) + r * cos(t), format, 'LineWidth', 1.5);
end

function [v1, v2] = collide_balls(v01, x1, m1, v02, x2, m2)
    %�����
    er = (x1 - x2)/sqrt(sum((x1 - x2).^2));
    es = [-er(2) er(1)];
    %���������� ��������� � ������
    vr01 = sum(v01.*er);
    vs1 = sum(v01.*es);
    vr02 = sum(v02.*er);
    vs2 = sum(v01.*es);
    
    %������� ��������� ������������ vr2
    c1 = m2/m1+1;
    c2 = -2*vr01-2*m2/m1*vr02;
    c3 = 2*vr01*vr02+m2/m1*vr02^2-vr02^2;
    vx = roots([c1 c2 c3]);
    
    %����� ������� �����
    d = abs(vx - vr02);
    [m,i] = max(d);
    vr2 = vx(i);
    %���������� vr1
    vr1 = vr01+m2/m1*(vr02-vr2);
    %����������� � �������� ������� ���������
    v1 = vr1*er+vs1*es;
    v2 = vr2*er+vs2*es;
end