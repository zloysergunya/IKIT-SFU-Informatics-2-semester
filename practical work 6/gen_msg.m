function msg = gen_msg(p, len)
    alph = ['0':'9' 'A':'Z'];
    if ~isvector(p)
        error('p must be a vector')
    end
    if length(p) > length(alph)
        error('p is too long (%d > %d)', length(p), length(alph));
    end
    if length(p) < 2
        error('p is too short (%d < 2)', length(p));
    end
    if ~isscalar(len)
        error('len must be a scalar')
    end
    if len < 1
        error('len is too small (%d < 1)', len)
    end
    msg = '';
    for i = 1:len
        msg(i) = alph(rand_discr(p));
    end
end

function r = rand_discr(p)
    r = sum(cumsum(p) < rand()) + 1;
end
