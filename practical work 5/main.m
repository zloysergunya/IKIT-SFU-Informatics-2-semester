%% »нициализировать генератор псевдослучайных чисел MATLAB номером своего варианта.
rand('state', 104);

%% Ќаписать функцию, подсчитывающую энтропию заданного алфавита:
%% h = alph_entropy(P), где P Ч вектор веро€тностей символов алфавита; h Ч энтропи€ в битах.

%% Ќаписать функцию, подсчитывающую избыточность заданного алфавита:
%% r = alph_redundancy(P), где P Ч вектор веро€тностей символов алфавита; r Ч избыточность.

%% »спользу€ функцию rand(), сгенерировать случайный вектор веро€тностей дл€ алфавита ralph из 10 символов 
%% (сумма веро€тностей должна быть равна единице!). 
%% —охранить вектор в файле ralph.txt.
ralph = rand(1, 10);
P = ralph/sum(ralph)
save ralph.txt -ascii ralph

h = alph_entropy(P)
r = alph_redundancy(P)

%% — помощью функций alph_entropy(), alph_redundancy() подсчитать энтропию 
%% и избыточность приложенных к заданию алфавитов и алфавита ralph. —формировать из результатов матрицу, 
%% у которой каждому алфавиту соответствует одна строка (в следующем пор€дке: coin, crime, unfair, ventsel, ralph), 
%% в первом столбце записана энтропи€, во втором Ч избыточность. 
%% —охранить матрицу в файл results.txt.

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