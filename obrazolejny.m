obraz=imread('e.jpg');
%rozmiary tablicy
a=3;
b=5;
wynik=uint8(zeros([size(obraz,1)-a,size(obraz,2)-b,3]));
%liczenie histogramu dla kazdego kanalu RGB
for z=1:3
  for z2=1:size(obraz,1)-a
      for z3=1:size(obraz,2)-b
          maska=obraz(z2:z2+a-1,z3:z3+b-1,z);
          y=zeros(1,256);
          for x=1:(a*b)
              y(maska(x)+1)=y(maska(x)+1)+1;
          end
    %uzyskanie wartosci maksymalnej
          [wartoscmax,pozycja]=max(y);
          wynik(z2,z3,z)=pozycja-1;
      end
  end
end
imshow(wynik);