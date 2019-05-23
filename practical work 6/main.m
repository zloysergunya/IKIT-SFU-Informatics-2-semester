%% Инициализировать генератор псевдослучайных чисел MATLAB номером своего варианта.
rand('state', 104);

alph = ['0':'9' 'A':'F']

ralph = rand(1, length(alph))
ralph = ralph/sum(ralph)
p = ralph
save ralph.txt -ascii ralph

entropy = alph_entropy(p)
redundancy = alph_redundancy(p)

msg = gen_msg(p, 100)
save msg.txt -ascii msg

[b, n] = calc_info(msg, alph, p)

results = [b, n, b/length(msg), entropy, redundancy]
save results.txt -ascii results