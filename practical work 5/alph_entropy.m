function [H] = alph_entropy (P)
    H=0;
    for (i=1:length (P))
      if (P(i) ~= 0)
        H=H-P(i)*(log2(P(i)));
       end
    end
end;