N=10;
str = str2mat(' ',' ', ' ', ...
 '        First example function is a sample nonlinear vector function', ...
 '        examplefun.m. Here is the code', ...
 '        ', ...
'function f= examplefun(x,Extra)', ...
'f=x.*x;', ...
'f(1)=f(1)+x''*x;', ...
'f=f+x(1)*x(1);', ...
' ', ...
 '        First few steps in this demo deal with this function. ', ...
 '        Press next to continue ...');
ssdisp(figNumber,str);      
drawnow;

% Delay a little more in the case of AutoPlay

if get(findobj(figNumber,'string','AutoPlay'),'value') pause(2) ; end ;

if sspause(figNumber), return; end;

str = str2mat (...
   '      1. Initializations', ...
   '        ', ...
   '         JPI=getJPI(''examplefun'',N);', ...
   '        ', ...
   '          Computes the coloring and partition info. ', ...
   ' ');
   
ssdisp(figNumber,str);                                     
drawnow;

x=ones(N,1);
m = length(examplefun(x));
JPI=getJPI('examplefun',m);

% Delay a little more in the case of AutoPlay
if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;

str = str2mat(' ', ...
   ' Evaluating the sparse Jacobian using AD :', ...
   ' ', ...
   ' [f,Jd]=evalJ(''examplefun'',x,[],[],JPI); ', ...
    '');
ssdisp(figNumber,str);      
drawnow;


disp('First evaluating by AD ...');
verb=2;
[f,Jd]=evalJ('examplefun',x,[],[],JPI,verb);

% Delay a little more in the case of AutoPlay
if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;

str = str2mat(' ', ...
   ' Now computing the sparse Jacobian using finite differences :', ...
   ' ', ...
   ' JPI=getJPI(''examplefun'',m,[],[],''f'');', ...
   ' [f,Jf]=evalJ(''examplefun'',x,[],[],JPI); ', ...
    '');

ssdisp(figNumber,str);
drawnow;
verb=2;
JPI=getJPI('examplefun',m,[],[],'f');
[f,Jf]=evalJ('examplefun',x,[],[],JPI,verb);
disp(sprintf('Error in Direct and Finite Diff Methods = %e',norm(full(Jd-Jf))));

if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;

str = str2mat(' ',' ', ' ', ...
 '        Second example function is the brown nonlinear scalar function', ...
 '        brown1.m. Here is the M-code for this function', ...
 '        ', ...
'function value = brown1(x,Extra);', ...
'  n=length(x);', ... 
'  y=zeros(n,1);', ...
'  i=1:(n-1);', ....
'  y(i)=(x(i).^2).^(x(i+1).^2+1);', ...
'  y(i)=y(i)+(x(i+1).^2).^(x(i).^2+1);' , ...
'  value=sum(y);', ...
' ', ...
 '        Rest of the  demo deals with this function. ', ...
 '        Press next to continue ...');

 
ssdisp(figNumber,str);
drawnow ;



 
% Delay a little more in the case of AutoPlay
if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;

str = str2mat(' ', ...
   '      1. Initializations', ...
   '        ', ...
   '         HPI=getHPI(''brown1'',N);', ...
   '        ', ...
   '          Computes the coloring and partition info. ', ...
   ' ');


ssdisp(figNumber,str);
drawnow ;

HPI=getHPI('brown1',N);
% Delay a little more in the case of AutoPlay
if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;
str = str2mat(' ', ...
   ' Evaluating the sparse Hessian using AD :', ...
   ' ', ...
   ' [v,g,H]=evalH(''brown1'',x,[],HPI,verb); ', ...
   ' ');

ssdisp(figNumber,str);
drawnow ;
x=ones(N,1);
verb=2;
[v,g,H]=evalH('brown1',x,[],HPI,verb);

if get(findobj(figNumber,'string','AutoPlay'),'value') pause(3) ; end ;
if sspause(figNumber), return; end;


