function [W, RP] = find_relevant_points_with_weights(P, Re, sigma)
    n = size(P,1);
    RP = [0, 0];
    W = 0;
    for i = 1:n
        for j = i+1:n
            P1      =   P(i,:);
            P2      =   P(j,:);
            r1      =   Re(i);
            r2      =   Re(j);
            sigma1  =   sigma(i);
            sigma2  =   sigma(j);
            I = find_intersections(P1, P2, r1, r2);
            
            if (isequal(I, zeros(0)))
                I   = (P1+P2)/2;
                d1  = norm(I-P1);
                d2  = norm(I-P2);
                w   = evaluated_normal_density(d1, r1, sigma1) * evaluated_normal_density(d2, r2, sigma2);
                RP  = [RP; I];
                W   = [W; w];
            continue;
            endif
            
            w = evaluated_normal_density(r1, r1, sigma1) * evaluated_normal_density(r2, r2, sigma2);
            W = [W; w];
            if(size(I,1) == 2)
                W = [W; w];
            endif
            RP = [RP; I];
        endfor
    endfor

    W   =   W(2:size(W,1), :);
    RP  =   RP(2:size(RP,1), :);
    
    sorted = sortrows([W, RP], -1);
    
    W   =   sorted(1:n, 1);
    RP  =   sorted(1:n, 2:3);
endfunction;