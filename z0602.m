clc;
clear;
m=0.01;var1=0.01;
pi1=imread('lena.bmp');
px1=imnoise(pi1,'salt & pepper',0.1);
px2=imnoise(pi1,'salt & pepper',0.2);
px3=imnoise(pi1,'salt & pepper',0.3);
figure;
subplot(2,2,1)
imshow(pi1)
title('ԭʼͼ��');
subplot(2,2,2)
imshow(px1)
title('���ӽ�������ͼƬ ����0.1');
subplot(2,2,3)
imshow(px2)
title('���ӽ�������ͼƬ ����0.2');
subplot(2,2,4)
imshow(px3)
title('���ӽ�������ͼƬ ����0.3');
saveas(gcf,'3.png')

po1=px1;
w1=fspecial('gaussian');%��˹��ֵ�˲�
po2=imfilter(po1,w1);


q=-1.5;m=2;n=2                  %��г����ֵ�˲���
[g,revevtClass] = tofloat(po1);

f = imfilter(g.^(q+1),ones(m,n),'replicate');
f=f./(imfilter(g.^(q),ones(m,n),'replicate')+eps);

po3=f;

q=+1.5;m=2;n=2                  %��г����ֵ�˲���
[g,revevtClass] = tofloat(po1);

f = imfilter(g.^(q+1),ones(m,n),'replicate');
f=f./(imfilter(g.^(q),ones(m,n),'replicate')+eps);

po5=f;



w3=fspecial('average');%��ֵ�˲�
po4=imfilter(po1,w3);

figure;


subplot(2,2,1)
imshow(po2)
title('������˹��ֵ�˲�ͼ��');

subplot(2,2,3)
imshow(po3)
title('������г��-1.5�˲�ͼ��');

subplot(2,2,2)
imshow(po4)
title('������ֵƽ���˲�ͼ��');

subplot(2,2,4)
imshow(po5)
title('������г��+1.5�˲�ͼ��');

saveas(gcf,'4.png')

% fspecial('motion',len,theta)

