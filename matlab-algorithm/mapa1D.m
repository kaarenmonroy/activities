function M = mapa1D(T)
a=1;
coord=zeros();
%%% Lectura y obtención de los valores RGB de n imagenes
[m,n]=size(T(:,:,1));
red=T(:,:,1);
green=T(:,:,2);
blue=T(:,:,3);
    for x=1:m
        for y=1:n  
            coord(a,1)=red(x,y);
            coord(a,2)=green(x,y);
            coord(a,3)=blue(x,y);
            a=a+1;
        end 
    end 
%%% Obtención de los valores RGB de n imagenes SIN repetir
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
         if paleta(x,1)~=1|| paleta(x,2)~=1 || paleta(x,3)~=1 
            if paleta(x,1)~=0|| paleta(x,2)~=0 || paleta(x,3)~=0
                P(x,1)=paleta(x,1);
                P(x,2)=paleta(x,2);
                P(x,3)=paleta(x,3);
            end
         end
    end
%%% obtención del valor equivalente a los valores RBG
RGB=length(P); 
for x=1:length(P)
    RGB(x)=P(x,1)+P(x,2)*255+P(x,3)*((255)^2);
end
%%% Mapeo del valor a un rango entre 0-1 Referencia: 
%%% https://la.mathworks.com/matlabcentral/answers/370370-how-to-mapping-values
RGBmap=size(RGB); 
    for x=1:length(RGB)
        RGBmap(x)=(RGB(x)-min(RGB))*(1-0)/(max(RGB)-min(RGB)) ;  
    end
M=sort(RGBmap);
end
