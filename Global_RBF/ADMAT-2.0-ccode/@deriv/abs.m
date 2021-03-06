function sout=abs(s1)
%
% overload the abs operation 
%  
%
%  03/2007 -- if s1.val is a vector, it has to be a 
%              column vector.
%  03/2007 -- add the case for s1.val is a matrix
%
%  05/2009 -- add the sparse case for deriv field.
%  01/2010 -- add nondifferentiable points detecting.
%
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************


global globp;
sout.val=abs(s1.val);
[m,n] = size(s1.val);

% non differentiable points checking

if issparse(s1.deriv)
    val = s1.val(:);
    indx = (val <0);
    % non differentiable points checking
    index0 = (val == 0);
    if nnz(index0)>0 && norm(s1.deriv(index0),1) ~= 0
        error('Nondifferentiable points in abs() was detected.');
    else
        sout.deriv = s1.deriv;
        sout.deriv(indx,:) = -sout.deriv(indx,:);
    end
else
    tmp = sign(s1.val);
    if m > 1 && n >1         % s1.val is a matrix
        % non differentiable points checking
        index0 = (tmp == 0);
        if nnz(index0)>0 && norm(s1.deriv(index0),1) ~= 0
            error('Nondifferentiable points in abs() was detected.');
        else
            sout.deriv = tmp(:,:, ones(1,globp)) .* s1.deriv;
        end
    else                     % s1.val is a vector or scalar
        % non differentiable points checking
        index0 = (tmp == 0);
        if nnz(index0)>0 && norm(s1.deriv(index0),1) ~= 0
            error('Nondifferentiable points in abs() was detected.');
        else
            tmp = tmp(:);
            sout.deriv=tmp(:,ones(1,globp)).*s1.deriv;
        end
    end
end
sout=class(sout,'deriv');
