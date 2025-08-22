function y = Lagged(x, n)
%
% add delay to a vector
% n > 0: positive (right) lag
% n < 0: negative (left) lead
% n = 0: no lag

x = x(:)';
n = round(n);
if(n > 0)
    y = [zeros(1,n) x(1:end-n)];
elseif(n < 0)
    y = [x(-n+1:end) zeros(1,-n)];
else
    y = x;
end

y = y(1:length(x));