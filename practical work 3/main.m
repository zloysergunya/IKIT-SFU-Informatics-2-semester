%Инициализация генератора псевдослучайных чисел номером своего варианта var
rand('state',var);

%% 
%Создаем вектор целых чисел, прибавляем к нему номер варианта var и обнуляем
%нечетные элементы вектора с помощью команды mod
vec=10:3:100;
vec=vec+var;
vec(mod(vec,2)==1)=0;

%% 
%Создаём вектор случайных чисел, распределённых равномерно на отрезке [0;2]
r= 2 * rand(1,101*var);
t=0:0.1:2;
f=@(t)(sum(r<t));
figure
plot(t,arrayfun(f,t))
xlabel('t') 
ylabel('r<t') 
axis square

%% 
%Построение графика на плоскости из 6 случайных ломанных с числом верщин 11+var
x=rand(11+var,6);
y=rand(11+var,6);
figure
plot(x,y)
xlabel('x') 
ylabel('y') 
axis square

%% 
%Построение графика в пространстве из 6 случайных ломанных с числом верщин 11+var
x=rand(11+var,6);
y=rand(11+var,6);
z=rand(11+var,6);
figure
plot3(x,y,z)
xlabel('x') 
ylabel('y') 
zlabel('z')
axis square

%% 
%Спираль состоящая из 4+ var витковq
t = 0:0.1:2*(4+var)*pi;
x = t.*cos(t);
y = t.*sin(t);
figure
plot(x, y)
xlabel('x') 
ylabel('y')
axis square

%% График функции z
z=cos(var*x).*x.^3+y.^3
[x, y]=meshgrid(-4:0.1:4, -4:0.1:4);
figure
mesh(x, y, z)
xlabel('x')
ylabel('y')
zlabel('z')

figure
surf(x, y, z)
xlabel('x')
ylabel('y')
zlabel('z')


%%  Вызов функции подбрасывания монеты
% Считать что орёл 1, а решка 0
N=9;
r = coin_flip(N);
  
%%
% Вызов функции подсчитывания выпавшх орлов
h = sum_heads(r);


%% 
%Вызов функции моделирующей nexp экспериментов по nflip монетки
nflip=10*var;
nexp = 999+var;
s=flip_stats(nflip,nexp);

%%
% Построение столбчатой диаграммы для вектора s
nflip=10*var;
nexp = 999+var;
s=flip_stats(nflip,nexp);
s=s/nexp;
figure
bar(s);

%%
% Защита.
x = rand(2)
b=1:2;
t = max(x(b, :)) < 0.5
x(:, t == 1) = []