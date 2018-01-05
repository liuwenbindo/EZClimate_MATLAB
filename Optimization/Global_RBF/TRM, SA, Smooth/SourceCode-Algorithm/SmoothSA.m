function [ xbest , fbest , evalf ] = SmoothSA ( myfun, x0, xstar, Ts,...
    kB, L, lambda, srmin, lb, ub, tracking, varargin )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulated annealing algorithm with lambda-Smooth technique. We have a
% sequence of lambda which is the parameter for the extra term 
% ||x-xstar||^2where xstar is the global optimum we guess or a point near 
% the global optimum. For each entry of lambda, we run through the 
% temperature sequence to get the result, and using the final x for the
% next entry of lambda until we go through all the lambda.
% Can draw the picture of all attempted function value and accepted
% function value and fbest if tracking parameter is set for 1
%
% Input arguments:
% fun - function name
% x0 - starting point
% xstar - the optima we guess
% Ts(1:end) - temperatures from hottest to coldest (Ts(end) cannot be 0)
% kB - Boltzmann constant
% L - number of trials at one temperature
% lambda(1:end) - lambda-sequence, the last entry must be 0
% srmin - minimum search range
% lb,ub - lower,upper bounds on x
% tracking - whether draw the picture of tracking
% varargin - additional arguments to function "fun"
%
% Returns:
% the final result of f and x and the number of evaluation of f
%
% "orig" refers to the user specified function
% non-"orig" refers to the modified function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(Ts(1)<0)
    error('Wrong Temperature Sequence!');
end

if(lambda(end)~=0)
    error('Last entry of lambda sequence must be 0!')
end

x = x0;
xbest=x0;
fbest=feval(myfun,x0,varargin{:});
evalf=1;
f_vec = zeros(length(Ts)*L*length(lambda),1);
f_vecold = zeros(length(Ts)*L*length(lambda),1);
ind = 0;

for k=1:length(lambda)
    Lambda=lambda(k);
    for i=1:length(Ts)
        T = Ts(i);
        sr = max((-lb+ub)*(T./max(Ts)),srmin);
        fold_orig = feval(myfun,x,varargin{:});
        evalf=evalf+1;
        fold = fold_orig + Lambda*norm(x-xstar)^2;
        for j=1:L
            xnew = neighbor(x, sr, lb, ub);
            fnew_orig = feval(myfun,xnew,varargin{:});
            evalf=evalf+1;
            fnew = fnew_orig + Lambda*norm(xnew-xstar)^2;
            ind=ind+1;
            f_vec(ind) = fnew;
            
            % accept new point if either function value is less or
            % accept a worse point with probability depending on T
            
            if (fnew <= fold)
                x = xnew;
                fold = fnew;
                fold_orig=fnew_orig;
            elseif (exp(-(fnew-fold)/kB/T) > rand)
                x = xnew;
                fold = fnew;
                fold_orig=fnew_orig;
            end
            
            if(fold_orig<fbest)
                fbest=fold_orig;
                xbest=x;
            end
            f_vecold(ind)=fold;
        end
    end
end

if(tracking==1)
figure
plot(f_vec, 'blue');
hold on;
plot(f_vecold, 'green');
hold on;
minsofar = f_vec;
for i = 1:length(f_vec)
    minsofar(i) = min(f_vec(1:i));
end
plot(minsofar, 'red');
end

end