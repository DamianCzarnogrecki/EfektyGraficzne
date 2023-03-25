obraz=imread('e.jpg');
szary=rgb2gray(obraz);
kopia=double(szary);

for x=1:size(kopia,1)-2
    for z=1:size(kopia,2)-2
        %maska - szerokosc
        maska_szerokosc=((2*kopia(x+2,z+1)+kopia(x+2,z)+kopia(x+2,z+2))-(2*kopia(x,z+1)+kopia(x,z)+kopia(x,z+2)));
        %maska - wysokosc
        maska_dlugosc=((2*kopia(x+1,z+2)+kopia(x,z+2)+kopia(x+2,z+2))-(2*kopia(x+1,z)+kopia(x,z)+kopia(x+2,z)));
        %gradient
        szary(x,z)=sqrt(maska_szerokosc.^3+maska_dlugosc.^3);
     
    end
end

imshow(szary);