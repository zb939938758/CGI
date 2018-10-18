function fn = Normalize2D(f)

    f = abs(f);
    
    minf = min(min(f));
    maxf = max(max(f));

    [m, n] = size(f);
    t = ones(m, n);

    fn = ((f-t*minf) / (maxf-minf))*255;

end
