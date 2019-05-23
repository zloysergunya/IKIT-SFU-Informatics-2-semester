function [x] = alph_redundancy (P)
  x=1-(alph_entropy(P)/log2(length (P)));
end