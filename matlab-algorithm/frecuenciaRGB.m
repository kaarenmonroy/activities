function FP = frecuenciaRGB(matriz)
vector=imhist(matriz);
x=1:1:length(vector);
fr=double(zeros(size(x)));fp=double(zeros(size(x))); 
    for a=1:length(vector)
        if vector(a)~=0
            fr(a)=double(vector(a)/sum(vector));
            fp(a)=fr(a)*100;
        end 
    end 
FP=fp;
end

