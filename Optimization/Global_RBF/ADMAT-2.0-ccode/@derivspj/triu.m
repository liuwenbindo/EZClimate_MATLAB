function L=triu(A)
%
%
%  04/2007 -- rmoved unused variables
%
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

L.val=triu(A.val);
L.derivspj=triu(A.derivspj);
L=class(L,'derivspj');

