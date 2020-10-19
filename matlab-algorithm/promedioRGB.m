function P = promedioRGB(r,g,b)
[m,n]=size(r);
red=r;
green=g;
blue=b; 
p=zeros(size(r));
    for x=1:m
        for y=1:n
            p(x,y)= red(x,y)+green(x,y)+blue(x,y)/3;
            P=uint8(p); 
        end 
    end 
end

