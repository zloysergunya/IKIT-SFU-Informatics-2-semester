function model_balls(v1, x1, m1, r1, v2, x2, m2, r2, t, dt, ft)
  %%v1, v2 � ������� �������� ����� � ������ ������� t = 0, �/�;
  %%x1, x2 � ������� ��������� ����� � ������ ������� t = 0, �;
  %%m1, m2 � ����� �����, ��;
  %%r1, r2 � ������� �����, �;
  %%t � ����� ��������� �������������, �;
  %%dt � ��� ���������� �������, � (������� ������ �������� �� ���� ��� �������������);
  %%ft � ������������ ������ �����, c.
  
  figure();
  %����������� ���
  xlabel('X');
  ylabel('Y');
  %%�������� �����
  grid on
  %% ���������� ������� �� ����
  axis equal
  %% ������� ����
  xlim([0,2]);
  ylim([0,2]);
  %%��������� ��������� ������� ���������
  hold on
  flag = 1;
  G = 6.674e-11;
  for i = 0:dt:t
    if norm(x2-x1)<(r1+r2)
      if flag == 1
        [v1, v2] = collide_balls(v1, x1, m1, v2, x2, m2);
        flag = 0;
      end
    else
      flag = 1;
    end
    
    vg = x2 - x1;
    vgl = norm(vg); %������� norm(vg) ��������� ����� ������� vg, 
    %|| vg ||2 = sum(abs(vg).^2)^1/2.
    vgn = Normalize(vg);

    %  ������� �� ��������� "������ ����� ����� ��������� ������� ����:�
    g1 = G * vgn * m1 * m2 / vgl^2;
    g2 = G * -vgn * m1 * m2 / vgl^2;
      
    a1 = boost(x1, x2, m2);
    a2 = boost(x2, x1, m1);
    B1 = draw_ball(x1, r1, 'r-');
    B2 = draw_ball(x2, r2, 'g-');

    pause(ft);
    delete(B1);
    delete(B2);
    
    v1 = v1 + a1 * dt;
    x1 = x1 + v1 * dt;

    v2 = v2 + a2 * dt;
    x2 = x2 + v2 * dt;
    
      
    title(sprintf('t = %.4f', i));
  end
end

function a = boost(x1, x2, m)
    r = sqrt(sum((x1 - x2).^2));    %���������� ����� �������� �����
    e = (x2 - x1)/r;                %��������� ������, �������� ����������� ���������
    G = 6.6720e-11;
    a = e * G*m/r;
end

%��������a ����
function h = draw_ball(x, r, format)
  A = linspace(0,2*pi,64);
  x1 = cos(A).*r+x(1);
  y1 = sin(A).*r+x(2);
  h = plot(x1(:), y1(:), format);
end

%��������� ������;
function vec = Normalize(x)
  vec = x / norm(x);
end

%������ ��������� ����� ����� ������������
function [v1, v2] = collide_balls(v01, x1, m1, v02, x2, m2)
  R = x2-x1;                 	 
  R=Normalize(R);	 
  S = [-R(2),R(1)];
  %����� - � - ��������������� ������ �� ���� � �������, 
  %Y - ������������� � ����.
  
 % ������� ��������� ������� ���� � ������� rCs
  v01(1)=dot(v01,R);
  v01(2)=dot(v01,S);
  
 % ������� ��������� � ������� rCs ��� ������� ����
  v02(1)=dot(v02,R);  
  v02(2)=dot(v02,S);
  
 % �������� ���������, ��� ���������� ������� ����
  U1 = v01(1);
  U2 = v02(1);
  
  % ������� � ����������� ���������, ���������� ������������� a,b,c.
  a = 1 + m2/m1;
  b = -2 * (U1 + m2/m1*U2);
  c = 2*U1*U2 + m2/m1*(U2^2) - U2^2;
  
  % ���������� ������ ��������� � ������� roots()
  sol = roots([a b c]);
  
  %������ ������������ �������
  %V1 � V2 -�������� ���������, ��� � U1-2, �� ��� ����� ��� �������� ��������� ���.
  if(abs(sol(1) - U2) > abs(sol(2) - U2))
  V2 = sol(1);
else
  V2 = sol(2);
end
V1 = (m1*U1 + m2*U2 - m2*V2)/m1;

%�������������� ��������� �������� ��������
v2 = R*V2 + S*v02(2);
v1 = R*V1 + S*v01(2);
end