%%

%
%
%
%
%

%% Inicialização da reconstrução

% limpa a memória 

clear; close all; clc;

% fixa as variaveis e o tipo para otimizar memória
sino3d_c1 = zeros(1003,182,1357,'int8');
sino3d_c2 = zeros(1003,182,1357,'int8');
sino3d_c3 = zeros(1003,182,1357,'int8');
sino3d_c4 = zeros(1003,182,1357,'int8');

% Parâmetros de reconstrução
theta = 0:179;
slice = 679;

%% carrega os dados

dado1 = load('sinograma_c1.txt');
dado2 = load('sinograma_c2.txt');
dado3 = load('sinograma_c3.txt');
dado4 = load('sinograma_c4.txt');


%% Retroprojeção do sinograma

for i=0:1356
    sino3d_c1(:,:,i+1)=dado1(i*1003+1:1003*(i+1),:);
end
disp('rearranjo dos dados 1 concluido')


for i=0:1356
sino3d_c2(:,:,i+1)=dado2(i*1003+1:1003*(i+1),:);
end
disp('rearranjo dos dados 2 concluido')

for i=0:1356
    sino3d_c3(:,:,i+1)=dado3(i*1003+1:1003*(i+1),:);
end    
disp('rearranjo dos dados 3 concluido')

for i=0:1356    
    sino3d_c4(:,:,i+1)=dado4(i*1003+1:1003*(i+1),:);
end
disp('rearranjo dos dados 4 concluido')

%% Soma os sinogramas na fatia de interesse


 sinograma = sino3d_c1(:,:,slice) + ...
             sino3d_c2(:,:,slice) + ...
             sino3d_c3(:,:,slice) + ...
             sino3d_c4(:,:,slice);

%sinograma = sino3d_c2(:,:,slice) + sino3d_c3(:,:,slice) + sino3d_c4(:,:,slice);

imagesc(sinograma');

imagem = iradon(sinograma(:,2:181),theta);

figure, imagesc(imagem); colorbar, colormap jet; 

%% retroprojeção de cada sinograma separadamente 

imagem1 = iradon(sino3d_c1(:,2:181,slice),theta,'Ram-Lak');
imagem2 = iradon(sino3d_c2(:,2:181,slice),theta,'Ram-Lak');
imagem3 = iradon(sino3d_c3(:,2:181,slice),theta,'Ram-Lak');
imagem4 = iradon(sino3d_c4(:,2:181,slice),theta,'Ram-Lak');


disp('Retroprojecao finalizada')

%%
imagem = imagem1 + ...
         imagem2 + ...
         imagem3 + ...
         imagem4;

figure; imagesc(imagem);

%%
figure; imagesc(imagem2(:,:)); colorbar;

title('');
xlabel('');
ylabel('');

colormap jet;

%%

imagem(:,:,slice) = iradon(sino3d_c2(:,2:181,slice),theta, 'none');


figure, imagesc(sino3d_c2(:,:,slice)'); 
colormap jet; 
title('sinograma'); xlabel('raio (mm)'); ylabel('\theta (graus)'); 
colorbar;

figure, imagesc(imagem(:,:,slice)); 
colormap jet; title('imagem'); xlabel('largura (mm)'); ylabel('altura (mm)');
colorbar;
 


