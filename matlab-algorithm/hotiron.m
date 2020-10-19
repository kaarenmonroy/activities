function H = hotiron(T)
a=2;
coord=zeros();
%%% Lectura y obtención de los valores RGB de n imagenes
red=T(:,:,1);
green=T(:,:,2);
blue=T(:,:,3);
[m,n]=size(red);
    for x=1:m
        for y=1:n  
            coord(a,1)=red(x,y);
            coord(a,2)=green(x,y);
            coord(a,3)=blue(x,y);
            a=a+1;
        end 
    end 
%%% Obtención de los valores RGB SIN repetir
paleta=zeros(size(coord));
vector=zeros(size(3));
[m,~]=size(paleta);
b=1;
i=0;
    for x=1:m-1
            vector(1)=coord(x+1,1);
            vector(2)=coord(x+1,2);
            vector(3)=coord(x+1,3);
        for y=1:m-1
                if vector(1)~=paleta(y,1) || vector(2)~=paleta(y,2) || vector(3)~=paleta(y,3) 
                   i=0;
                else 
                   i=1;
                   break;
                end 
        end
            if i==0
               paleta(b,1)=vector(1);
               paleta(b,2)=vector(2);
               paleta(b,3)=vector(3); 
               b=b+1;
            end 
    end 
P=zeros(size(b-1));
    for x=1:b-1
        P(x,1)=paleta(x,1);
        P(x,2)=paleta(x,2);
        P(x,3)=paleta(x,3);
    end
%%% Mapeo de los valores RGB a un rango entre 0-1 para crear su mapa de
%%% color. Referencia: https://la.mathworks.com/matlabcentral/answers/
%%% 370370-how-to-mapping-values
Rmap=(P(:,1)-min(P(:,1)))*(1-0)/(max(P(:,1))-min(P(:,1))) + 0;
Gmap=(P(:,2)-min(P(:,2)))*(1-0)/(max(P(:,2))-min(P(:,2))) + 0;
Bmap=(P(:,3)-min(P(:,3)))*(1-0)/(max(P(:,3))-min(P(:,3))) + 0;    
RGBmap=zeros(size(P));
    for x=1:length(P)
      RGBmap(x,1)=Rmap(x);
      RGBmap(x,2)=Gmap(x);
      RGBmap(x,3)=Bmap(x);
    end 
%%% Ordenamiento del mapa de color
%%% Referencia: https://stackoverflow.com/questions/25510110/constructing-
%%% a-matrix-of-images-sorted-according-to-rgb-intensity 
 HSV = rgb2hsv(RGBmap);
 rgb = sortrows(HSV,[3 2 1]);
 RGBmap = hsv2rgb(rgb);
 H=zeros();
    for x=1:b-1
        if RGBmap(x,1)~=1 || RGBmap(x,2)~=1 || RGBmap(x,3)~=1 
            if RGBmap(x,1)~=0 || RGBmap(x,2)~=0 || RGBmap(x,3)~=0
                H(x,1)=RGBmap(x,1);
                H(x,2)=RGBmap(x,2);
                H(x,3)=RGBmap(x,3);
            end
        end
    end
end