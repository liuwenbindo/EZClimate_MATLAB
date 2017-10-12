function sout=tan(s1)
%
%  
%
%  March, 2007 -- correct the computation of 
%                 the derivative.
%  04/2007 -- consider the case for row vectors
%
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************


m = size(s1.val,1);
sout.val=tan(s1.val);

s1val = getvalue(s1);
tmp = sec(getvalue(s1val)).^2;
if m == 1
    sout.derivH = tmp(:).*s1.derivH;
else
    sout.derivH = tmp.*s1.derivH;
end

sout=class(sout,'derivH');
