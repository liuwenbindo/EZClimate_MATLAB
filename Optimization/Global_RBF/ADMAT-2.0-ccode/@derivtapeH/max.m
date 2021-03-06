function sout = max(s1,s2)
%
%
% 05/2007 -- limited the case that input, 's1' is a scalar or vector.
%            The matrix case will involve 4-dimensional arrary in the
%            computation, which is not supported in 'reverse' folder.
%   01/2010 -- add nondifferentiable points detecting.
%
%       ******************************************************************
%       *                          ADMAT - 2.0                           *
%       *              Copyright (c) 2008-2009 Cayuga Research           *
%       *                Associates, LLC. All Rights Reserved.           *
%       ******************************************************************

global globp;

s1 = derivtapeH(s1,0);

if nargin > 1

    s2=derivtapeH(s2,0);
    sout=derivtapeH(max(s1.val,s2.val),0);

    % output is a vector
    if size(getval(sout),1)==1 || size(getval(sout),2)==1
        I1=find(getval(s1)-getval(s2) > 0);
        I2=find(getval(s1)-getval(s2) == 0);

        I3=find(getval(s1)-getval(s2) < 0);

        % s1.val is a scalar and s2.val is a vector
        if length(getval(s1))==1 && length(getval(s2))~=1
            if ~isempty(I3)
                sout.deriv(I3,:) = s2.deriv(I3,:);
            end
            if ~isempty(I1)
                sout.deriv(I1,:) = repmat(s1.deriv, length(I1),1);
            end
            for j=1:length(I2)
                if isequal(s2.deriv(I2(j),:), s1.deriv)
                    sout.deriv(I2(j),:) = s1.deriv;
                else
                    error('Nondifferentiable points in max() was detected.');
                end

            end
            % s2.val is a scalar and s1.val is a vector
        elseif length(getval(s2))==1 && length(getval(s1))~=1

            if ~isempty(I1)
                sout.deriv(I1,:)=s1.deriv(I1,:);
            end
            if ~isempty(I3)
                sout.deriv(I3,:)= repmat(s2.deriv, length(I3),1);
            end
            for j=1:length(I2)
                if isequal(s1.deriv(I2(j),:), s2.deriv)
                    sout.deriv(I2(j),:)=s2.deriv;
                else
                    error('Nondifferentiable points in max() was detected.');
                end

            end
        else                   % both are vectors
            if ~isempty(I1)
                sout.deriv(I1,:)=s1.deriv(I1,:);
            end;
            if ~isempty(I3)
                sout.deriv(I3,:)=s2.deriv(I3,:);
            end;
            if ~isempty(I2)
                if isequal(s1.deriv(I2,:),s2.deriv(I2,:))
                    sout.deriv(I2,:)=s1.deriv(I2,:);
                else
                    error('Nondifferentiable points in max() was detected.');
                end

            end;
        end

    else             % both are matrices

        [I1,I1j]=find(getval(s1)-getval(s2) > 0);
        [I2,I2j]=find(getval(s1)-getval(s2) == 0);
        % non differentiable points checking
        if ~isempty(I2) || ~isempty(I2j)
            error('Nondifferentiable points in max() was detected.');
        end
        [I3,I3j]=find(getval(s1)-getval(s2) < 0);

        if length(s1.val)==1
            sout.deriv=s2.deriv;
            if ~isempty(I1)
                for i=1:globp
                    for j=1:length(I1)
                        sout.deriv(I1(j),I1j(j),i)=s1.deriv(i);
                    end
                end
            end
            for j=1:length(I2)
                if isequal(squeeze(s2.deriv(I2(j),I2j(j),:)),s1.deriv(:))
                    sout.deriv(I2(j),I2j(j),:)= s1.deriv(:);
                else
                    error('Nondifferentiable points in max() was detected.');
                end

            end
        elseif length(s2.val)==1
            sout.deriv=s1.deriv;

            if ~isempty(I3)
                for i=1:globp
                    for j=1:length(I3)
                        sout.deriv(I3(j),I3j(j),i)=s2.deriv(i);
                    end
                end
            end

            for j=1:length(I2)
                if isequal(squeeze(s1.deriv(I2(j),I2j(j),:)),s2.deriv(:))
                    sout.deriv(I2(j),I2j(j),:)= s2.deriv(:);
                else
                    error('Nondifferentiable points in max() was detected.');
                end

            end
        else
            sout.deriv=s2.deriv;
            if ~isempty(I1)
                for j=1:length(I1)
                    sout.deriv(I1(j),I1j(j),:)=s1.deriv(I1(j),I1j(j),:);
                end
            end
            if ~isempty(I2)
                for j=1: length(I2)
                    if isequal(s1.deriv(I2(j),I2j(j),:), s2.deriv(I2(j),I2j(j),:))
                        sout.deriv(I2(j),I2j(j),:)= s1.deriv(I2(j),I2j(j),:);
                    else
                        error('Nondifferentiable points in max() was detected.');
                    end
                    
                end
            end
        end
    end
else
    sout.val=max(s1.val);
    [xxx,I]=max(getval(s1));
    sout.deriv=s1.deriv(I,:);
    sout=class(sout,'derivtapeH');

end

