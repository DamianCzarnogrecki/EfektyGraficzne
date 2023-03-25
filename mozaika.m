obraz=imread('e.jpg');
wynik=uint8(zeros(size(obraz)));
a=1; b=1;
kolumna=0;
wiersz=0;
x=1;y=1;

while (a < size(obraz,1))
  while(x+a+wiersz < size(obraz,1)&& y+b+kolumna < size(obraz,2))
          wynik(x+a:x+a+wiersz,y+b:y+b+kolumna,:)=obraz(a:a+wiersz,b:b+kolumna,:);
          %losowanie rozmiaru kafelkow
          x=ceil(rand(1)*5); %odstepy miedzy kafelkami - szerokosc
          y=ceil(rand(1)*8); %odstepy miedzy kafelkami - wysokosc
          kolumna=ceil(rand(1)*18); %wysokosc kafelkow
          wiersz=ceil(rand(1)*18); %szerokosc kafelkow
          b=b+kolumna;
      end
       a=a+wiersz;
       b=1;
end
imshow(wynik);