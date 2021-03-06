function []=fprintf(format,varargin)
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

n = length(varargin);
myargin = cell(1, n);
for i=1 : n
    myargin{i}=getval(varargin{i});
end
if length(varargin)==1
    fprintf(format,myargin{1});
elseif length(varargin)==2
    fprintf(format,myargin{1},myargin{1});

elseif length(varargin)==3
    fprintf(format,myargin{1},myargin{2},myargin{3});

else
    fprintf(format,myargin{1},myargin{2},myargin{3},myargin{4});

end
