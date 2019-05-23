%% ���������������� ��������� ��������������� ����� MATLAB ������� ������ ��������.
rand('state', 104);

%% �������� �������, �������������� �������� ��������� ��������:
%% h = alph_entropy(P), ��� P � ������ ������������ �������� ��������; h � �������� � �����.

%% �������� �������, �������������� ������������ ��������� ��������:
%% r = alph_redundancy(P), ��� P � ������ ������������ �������� ��������; r � ������������.

%% ��������� ������� rand(), ������������� ��������� ������ ������������ ��� �������� ralph �� 10 �������� 
%% (����� ������������ ������ ���� ����� �������!). 
%% ��������� ������ � ����� ralph.txt.
ralph = rand(1, 10);
P = ralph/sum(ralph)
save ralph.txt -ascii ralph

h = alph_entropy(P)
r = alph_redundancy(P)

%% � ������� ������� alph_entropy(), alph_redundancy() ���������� �������� 
%% � ������������ ����������� � ������� ��������� � �������� ralph. ������������ �� ����������� �������, 
%% � ������� ������� �������� ������������� ���� ������ (� ��������� �������: coin, crime, unfair, ventsel, ralph), 
%% � ������ ������� �������� ��������, �� ������ � ������������. 
%% ��������� ������� � ���� results.txt.

load coin.txt -ascii coin
load crime.txt -ascii crime
load unfair.txt -ascii unfair
load ventsel.txt -ascii ventsel

vars = {coin, crime, unfair, ventsel, ralph}

for i=1:5
  entropy = alph_entropy(vars{i});
  redundancy = alph_redundancy(vars{i});
  result(i, 1) = entropy
  result(i, 2) = redundancy
endfor

save results.txt -ascii result