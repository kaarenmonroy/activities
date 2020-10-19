%%% THERMOMAPCOLORS
%%% Creado por Karen Monroy
close all; clc; clear;
%%% Carga y despligue de la termografia
imagen=uigetfile('*.*','Select An Image');
i=imread(imagen);
figure('Name','Selecciona el area de la imagen que quieras analizar') 
[T, rect] = imcrop(i);
close all;
%%% Histogramas de la termografia 
figure('Name','Histogramas RGB de la termografia seleccionada') 
subplot(1,4,1)
bar(0:255,imhist(T(:,:,1)),3,'r'),title('Histograma R'),xlabel('Tono'); ylabel('Frecuencia');xlim([0 255]);
subplot(1,4,2);
bar(0:255,imhist(T(:,:,2)),3,'g'),title('Histograma G'),xlabel('Tono'); ylabel('Frecuencia');xlim([0 255]);
subplot(1,4,3);
bar(0:255,imhist(T(:,:,3)),3,'b'),title('Histograma B'),xlabel('Tono'); ylabel('Frecuencia');xlim([0 255]);
promedio1=promedioRGB(T(:,:,1),T(:,:,2),T(:,:,3));
subplot(1,4,4);
bar(0:255,imhist(promedio1),3,'k'),title('Histograma del promedio RGB'),xlabel('Tono'); ylabel('Frecuencia');xlim([0 255]);
%%% Porcentajes RGB
figure('Name','Porcentajes RGB de cada tono de la termografia seleccionada')
bar(0:255,frecuenciaRGB(T(:,:,1)),3,'r'),hold on;
bar(0:255,frecuenciaRGB(T(:,:,2)),3,'g'),hold on;
bar(0:255,frecuenciaRGB(T(:,:,3)),3,'b'),hold on;
bar(0:255,frecuenciaRGB(promedio1),3,'k'),grid on;
title('Porcentajes RGB de la termografia seleccionada'),xlabel('Tono'),ylabel('Porcentaje (%)'),legend('Red','Green','Blue','Promedio');xlim([0 255]);
%%% Grafica 3D de los puntos RGB
figure('Name','Grafica RGB de cada tono de la termografia')
stem3(T(:,:,1),T(:,:,2),T(:,:,3),'Linewidth',1.5,'LineStyle','none','Color','k');
title('Grafica RGB en 3D de la termografia'),xlabel('Tono R'), ylabel('Tono G'),zlabel('Tono B');
%%% Despligue de la imagen con su respectivo mapa de color 
paleta=input('Introduce la paleta de color de tu termografia (rainbow=1 / hot iron=2) : ');
if paleta==1
    figure('Name','Despliegue de una termografia con su respectivo mapa de colores')
    image(T)
    title('Termografia con su respectivo mapa de colores');
    colormap(rainbow(T));
    colorbar
elseif paleta==2
    figure('Name','Despliegue de una termografia con su respectivo mapa de colores')
    image(T)
    title('Termografia con su respectivo mapa de colores');
    colormap(hotiron(T));
    colorbar
end    
%%% Opcion de crear mapa de colores personalizado 
ban=input('¿Quieres crear un mapa de colores personalizado? (si=1, no=0) = ');
if ban==1
    M=mapa1D(T);
    n=input('Introduce el numero de categorias que quieres visualizar para tu mapa de colores personalizado = ');
    t=size(n);
    a=1;b=1;d=1;
    mymap=size(150);
    freq=size(n);
        for x=1:n 
            fprintf('Introduce el valor maximo de la categoria %d',x);
            t(x)=input(' = ');
            colores = {'Amarillo','Verde','Verde Oscuro','Aqua','Azul','Azul Oscuro','Rojo','Vino','Morado','Naranja','Rosa','Coral','Fucsia','Cafe','Gris','Negro','Blanco'};
            [indx,tf] = listdlg('PromptString','Seleccione un color:','SelectionMode','single','ListString',colores);
           if indx==1
                colors=[1,0.92,0.63];
                elseif indx==2
                elseif indx==3
                colors=[0.29,0.61,0.25];
                elseif indx==4
                colors=[0.59, 1, 0.82];
                elseif indx==5
                colors=[0.45,0.91,1];
                elseif indx==6
                colors=[0.05,0,1];
                elseif indx==7
                colors=[0.96,0,0.05];
                elseif indx==8
                colors=[0.49,0,0.19];
                elseif indx==9
                colors=[0.72,0.43,0.93];
                elseif indx==10
                colors=[1,0.65,0.35];
                elseif indx==11
                colors=[1,0.58,0.93];
                elseif indx==12
                colors=[1,0.61,0.5];
                elseif indx==13
                colors=[1,0,0.48];
                elseif indx==14
                colors=[0.6,0.4,0.2];
                elseif indx==15
                colors=[0.76,0.76,0.76];
                elseif indx==16
                colors=[0,0,0];
                elseif indx==17
                colors=[1,1,1];
           end
             while M(a)<t(x)
                a=a+1;
                d=d+1;
             end
              freq(x)=d;
                 for y=1:d
                    mymap(b,1)=colors(:,1);
                    mymap(b,2)=colors(:,2);
                    mymap(b,3)=colors(:,3);
                    b=b+1;
                 end 
             d=1;  
        end
end 
%%% Despliegue de la termografia transformada con el mapa de color
%%% personalizado
if ban==1
    disp(' '); 
    for x=1:n
        area=freq(x)*100/length(mymap);
        formatSpec="El area porcentual que representa la categoria %d es de %4.2f%% ";
        fprintf(formatSpec,x,area);
        disp(' ');
    end
    if paleta==1
        figure('Name','Despliegue de la termografia con el mapa de color personalizado')
        image(T(:,:,1))
        title('Termografia con el mapa de colores personalizado');
        colormap(mymap);
        colorbar
    elseif paleta==2
        figure('Name','Despliegue de la termografia con el mapa de color personalizado')
        image(T(:,:,2))
        title('Termografia con el mapa de colores personalizado');
        colormap(mymap);
        colorbar
    end
end