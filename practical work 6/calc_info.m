function [b, n] = calc_info(msg, alph, alph_p)
  if length(alph_p) ~= length(alph)
    error('Size vector alph_p = %d not equal to vector size alph = %d', length(alph_p), length(alph))
  endif
  b = 0
  for i=1:length(msg)
    buf = alph_p(strfind(alph, msg(i)))
    if (buf ~= 0)
      b = b - log2(buf)
    else
      warning('Simbol "%c(%d)" not found in alph', msg(i), i)
    endif
  endfor
  n = length(msg) * log2(length(alph))
end