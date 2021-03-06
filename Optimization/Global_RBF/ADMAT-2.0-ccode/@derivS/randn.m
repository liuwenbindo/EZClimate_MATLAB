function y = randn(m,n)
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

if nargin ==1
    y= derivS(randn(getval(m)));
else
    y= derivS(randn(getval(m),getval(n)));
end
