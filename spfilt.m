function f = spfilt(g, type, m, n, parameter)
%
% f = spfilt(g, 'amean', m, n) ����ƽ��
% f = spfilt(g, 'gmean', m, n) ����ƽ��
% f = spfilt(g, 'hmean', m, n) г����ƽ��
% f = spfilt(g, 'chmean', m, n,Q) contraharmonic ƽ��
% f = spfilt(g, 'median', m, n) ��ֵ
% f = spfilt(g, 'max', m, n) ���ֵ
% f = spfilt(g, 'min', m, n) ��Сֵ
% f = spfilt(g, 'midpoint', m, n) �е�
% f = spfilt(g, 'atrimmed', m, n,D) alpha-trimmed ƽ��
%
if nargin == 2
m = 3; n = 3; Q = 1.5; d = 2;
elseif nargin == 5
Q = parameter; d = parameter;
elseif nargin == 4
Q = 1.5; d = 2;
else
error('Wrong number of inputs.');
end
switch type
case 'amean'
w = fspecial('average',[m,n]);
f = imfilter(g,w,'replicate');
case 'gmean'
f = gmean(g,m,n);
case 'hmean'
f = harmean(g,m,n);
case 'chmean'
f = charmean(g,m,n,Q);
case 'median'
f = medfilt2(g, [m,n], 'symmetric');
case 'max'
f = ordfilt2(g,m*n,ones(m,n),'symmetric');
case 'min'
f = ordfilt2(g,1,ones(m,n),'symmetric');
case 'midpoint'
f1 = ordfilt2(g,1,ones(m,n),'symmetric');
f2 = ordfilt2(g,m*n,ones(m,n),'symmetric');
f = imlincomb(0.5,f1,0.5,f2);
case 'atrimmed'
if (d<0) | (d/2~=round(d/2))
error('d must be a nonnegative, even integer.')
end
f = alphatrim(g,m,n,d);
otherwise
error('Unknown filter type.')
end