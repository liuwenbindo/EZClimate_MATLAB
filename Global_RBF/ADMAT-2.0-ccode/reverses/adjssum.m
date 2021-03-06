function adjsum(i)
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

global tape;
global globp;

m = size(tape(tape(i).arg1vc).W);
dim = tape(i).arg2vc;
if length(m) > 2                % input is a matrix
    if dim == 1
        for k=1:globp
            for j=1:size(tape(tape(i).arg1vc).W,2)
                tape(tape(i).arg1vc).W(:,j,k)=tape(tape(i).arg1vc).W(:,j,k)+...
                    tape(i).W(j,k);
            end
        end
    elseif dim == 2
        for k = 1 : globp
            for j=1:size(tape(tape(i).arg1vc).W,2)
                tape(tape(i).arg1vc).W(j,:,k)=tape(tape(i).arg1vc).W(j,:,k)+...
                    tape(i).W(j,k);
            end
        end
    end
else
    if globp == 1
        if dim == 1
            if size(tape(i).val,1) == 1 && size(tape(i).val,2) > 1      % val is a row vector
                tape(tape(i).arg1vc).W = bsxfun(@plus, tape(tape(i).arg1vc).W,tape(i).W');
            else                            % val a column vector or scalar
                tape(tape(i).arg1vc).W = bsxfun(@plus,tape(tape(i).arg1vc).W, tape(i).W);
            end
        elseif dim == 2
            if size(tape(i).val,1) > 1 && size(tape(i).val,2) == 1      % val is a column vector
                tape(tape(i).arg1vc).W = bsxfun(@plus, tape(tape(i).arg1vc).W , tape(i).W);
            else                            % val a scalar
                tape(tape(i).arg1vc).W = bsxfun(@plus, tape(tape(i).arg1vc).W, tape(i).W);
            end
        end
    else
        if dim == 1
            if size(tape(i).val,1) == 1 && size(tape(i).val,2) == 1 % val is a scalar
                tape(tape(i).arg1vc).W = bsxfun(@plus, tape(tape(i).arg1vc).W, tape(i).W);
            else   % val is a row vector
                tape(tape(i).arg1vc).W = tape(tape(i).arg1vc).W + ...
                    tape(i).W;
            end
        elseif dim == 2
            if size(tape(i).val,1) == 1 && size(tape(i).val,2) == 1 % val is scalar
                tape(tape(i).arg1vc).W = bsxfun(@plus, tape(tape(i).arg1vc).W, tape(i).W);
            else   % val is a column vector
                tape(tape(i).arg1vc).W = tape(tape(i).arg1vc).W + ...
                    tape(i).W;
            end
        end
    end
end
