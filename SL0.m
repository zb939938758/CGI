function s = SL0(A, x, sigma_min, sigma_decrease_factor, mu_0, L, A_pinv, true_s)

    if nargin < 4
        sigma_decrease_factor = 0.5;
        A_pinv = pinv(A);
        mu_0 = 2;
        L = 3;
        ShowProgress = false;
    elseif nargin == 4
        A_pinv = pinv(A);
        mu_0 = 2;
        L = 3;
        ShowProgress = false;
    elseif nargin == 5
        A_pinv = pinv(A);
        L = 3;
        ShowProgress = false;
    elseif nargin == 6
        A_pinv = pinv(A);
        ShowProgress = false;
    elseif nargin == 7
        ShowProgress = false;   %logical(0)
    elseif nargin == 8
        ShowProgress = true;	% logical(1)
    else
        error('Error in calling SL0 function');
    end


    % Initialization
    % s = A\x; x = A*s;
    s = A_pinv * x;
    sigma = 2 * max(max(abs(s)));

    if ShowProgress
            fprintf('computing ...\n')
    end
    % Main Loop
    while sigma > sigma_min
        for i = 1:L
            delta = s .* exp(-abs(s).^2 / sigma^2);
%             s = A_pinv * x;
            s = s - mu_0 * delta;
            s = s - A_pinv * (A * s - x);   % Projection
        end

        if ShowProgress
            fprintf('	sigma = %f, SNR = %f\n', sigma, estimate_SNR(s, true_s))
        end

        sigma = sigma * sigma_decrease_factor;
    end

end