% Параметры функции model_balls:
% v1, v2 - начальные скорости шаров
% x1, x2 - начальные координаты шаров
% r1, r2 - радиусы шаров
% m1, m2 - массы шаров
% t - время моделирования
% dt - шаг аремени
% ft - время показа одного кадра

function model_balls(v1, x1, m1, r1, v2, x2, m2, r2, t, dt, ft)
    % Границы области
    bounds = [0 0; 2 2];
    
    % Создание и настройка системы координат
    figure;
    ah = axes;
    axis(ah, 'equal');
    xlim(ah, bounds(:, 1));
    ylim(ah, bounds(:, 2));
    grid(ah, 'on');
    hold(ah, 'on');
    
    % рисование шаров
    h1 = draw_ball(x1, r1, '-b');
    h2 = draw_ball(x2, r2, '-r');
    
    for i = 0:dt:t
        title(ah, sprintf('t = %.4f', i));
        
        %удаление шаров с поля
        delete(h1);
        delete(h2);
        
        %расстояние между центрами шаров
        d = sqrt(sum((x1 - x2).^2));
        
        if d <= (r1 + r2)
            %расчет столкновения шаров
            [v1, v2] = collide_balls(v1, x1, m1, v2, x2, m2);
        end
        
        %расчет ускорения шаров
        a1 = gravitation(x1, x2, m2);
        a2 = gravitation(x2, x1, m1);
        %расчет скорости
        v1 = v1 + a1 * dt;
        v2 = v2 + a2.* dt;
        
        %расчет новых координат центров шаров
        x1 = x1 + v1 .* dt;
        x2 = x2 + v2 .* dt;
        
        %рисование шаров
        h1 = draw_ball(x1, r1, '-b');
        h2 = draw_ball(x2, r2, '-r');
        
        pause(ft);
    end
end

%расчет ускорения
%x1 - координаты шара, на который действует сила
%x2 - координаты шара, который оказывает силу на первый
function a = gravitation(x1, x2, m)
    r = sqrt(sum((x1 - x2).^2));    %расстояние между центрами шаров
    e = (x2 - x1)/r;                %единичный вектор, задающий направление ускорения
    G = 6.6720e-11;
    a = e * G*m/r;
end

%x - координаты центра шара
%r - радиус шара
%format — строка формата линии
function h = draw_ball(x, r, format)
    t = linspace(0, 2 * pi);
    h = plot(x(1) + r * sin(t), x(2) + r * cos(t), format, 'LineWidth', 1.5);
end

function [v1, v2] = collide_balls(v01, x1, m1, v02, x2, m2)
    %базис
    er = (x1 - x2)/sqrt(sum((x1 - x2).^2));
    es = [-er(2) er(1)];
    %координаты скоростей в базисе
    vr01 = sum(v01.*er);
    vs1 = sum(v01.*es);
    vr02 = sum(v02.*er);
    vs2 = sum(v01.*es);
    
    %решение уравнения относительно vr2
    c1 = m2/m1+1;
    c2 = -2*vr01-2*m2/m1*vr02;
    c3 = 2*vr01*vr02+m2/m1*vr02^2-vr02^2;
    vx = roots([c1 c2 c3]);
    
    %выбор нужного корня
    d = abs(vx - vr02);
    [m,i] = max(d);
    vr2 = vx(i);
    %нахождение vr1
    vr1 = vr01+m2/m1*(vr02-vr2);
    %возвращение к основной системе координат
    v1 = vr1*er+vs1*es;
    v2 = vr2*er+vs2*es;
end