function sout = asinh(s1)
%
%
% 05/2007 -- limited the case that input, 's1' is a scalar or vector. 
%            The matrix case will involve 4-dimensional arrary in the
%            computation, which is not supported in 'reverse' folder.
%
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

global globp;
sout.val = asinh(s1.val);

 tmp = 1./sqrt((s1.val).^2 + 1);

sout.deriv = repmat(tmp(:), 1, globp) .* s1.deriv;

sout=class(sout,'derivtapeH');
