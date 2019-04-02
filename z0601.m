clc;clear;
f=imread('lena.bmp');

F=fft2(f);
T=1;a=2;b=2;

for u=1:size(f,1)
    for v = 1:size(f,2)

H(u,v)=T./(pi*(u*a+v*b))*sin(pi*(u*a+v*b))*exp(complex(0,pi*(u*a+v*b)));
G(u,v)=H(u,v).*F(u,v);
    end
end


g=ifft2(G);
g=g(1:size(f,1),1:size(f,2));

g1=imnoise(g,'gaussian',10/(512.^2),0);
F1=fft2(g1);

 K=0.02
for u=1:size(f,1)
    for v = 1:size(f,2)

H(u,v)=T./(pi*(u*a+v*b))*sin(pi*(u*a+v*b))*exp(complex(0,pi*(u*a+v*b)));
G(u,v)=(1./H(u,v)).*(det(H(u,v)).^2)./(det(H(u,v)).^2+K).*F1(u,v);
    end
end
g3=ifft2(G);
g3=g3(1:size(f,1),1:size(f,2));
% figure;
% imshow(g3,[]);
figure;
subplot(2,2,1)
imshow(f)
title('原图');

subplot(2,2,2)
imshow(g,[])
title('经过5.6-11公式滤波滤波图像');
subplot(2,2,3)
imshow(g1,[])
title('在模糊图像基础上增加高斯噪声');
subplot(2,2,4)
imshow(g3,[])
title('使用维纳恢复图像');
saveas(gcf,'5.png')


p=[0,-1,0;-1,4,-1;0,-1,0];
F1= fft2(g1,512,512);
P  = fft2(p,512,512);
for k1=0:0.001:0.05
;for u=1:size(f,1)
    for v = 1:size(f,2)

H(u,v)=T./(pi*(u*a+v*b))*sin(pi*(u*a+v*b))*exp(complex(0,pi*(u*a+v*b)));


    end
end
N1=conj(H);
N2=(H);
N3=(P);
G=(N1./((N2.^2)+k1.*(N3.^2))).*F1;
% 
g4=ifft2(G);
% g4 = otf2psf(G,[512,512]);
g4=g4(1:size(f,1),1:size(f,2));

figure;
subplot(2,2,1)
imshow(f)
title('原图');

subplot(2,2,2)
imshow(g,[])
title('经过5.6-11公式滤波滤波图像');
subplot(2,2,3)
imshow(g1,[])
title('在模糊图像基础上增加高斯噪声');
subplot(2,2,4)
imshow(g4,[])
title('使用最小二乘恢复图像');
end
% saveas(gcf,'6.png')



