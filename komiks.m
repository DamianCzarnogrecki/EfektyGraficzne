obraz = imread('e.jpg');
figure(1);
imshow(obraz);

obraz_koncowy = obraz;

prog_wykrywania_krawedzi = 0.01;

tryb_wykrycia_krawedzi = 'sobel'; 

nasycenie = 2;

% parametry do wyg³adzenia obrazu
promien=2; C=[3, 0.1]; 
liczba_powtorzen = 1; 


% nasycenie
    obraz_double = double(obraz);
    obraz_szary = double(rgb2gray(obraz));
    wzor = obraz_double;
  
    wzor(:,:,1)=obraz_szary; wzor(:,:,2)=obraz_szary; wzor(:,:,3)=obraz_szary;
    
    obraz_zmieniony = (1-nasycenie).*wzor+nasycenie.*obraz_double;
    
    obraz_zmieniony = uint8(obraz_zmieniony);
    
% normalizacja obrazu do [0,1].
obraz_edycja = (double(obraz_zmieniony)) ./ 255;


if liczba_powtorzen > 1
    obraz_edycja = rozmycie(obraz_edycja,promien,C);
    obraz_szary = rgb2gray(obraz_edycja);
    
    % reprezentacja krawêdzi za pomoc¹ maski
    % wykorzystanie funkcji "edge"
    maska_krawedzi = uint8(edge(obraz_szary, tryb_wykrycia_krawedzi, prog_wykrywania_krawedzi));
    
    for i=2:liczba_powtorzen
        obraz_edycja = rozmycie(obraz_edycja,promien,C);
    end
elseif liczba_powtorzen == 1
    obraz_edycja = rozmycie(obraz_edycja,promien,C);
    obraz_szary = rgb2gray(obraz_edycja);
    maska_krawedzi = uint8(edge(obraz_szary, tryb_wykrycia_krawedzi, prog_wykrywania_krawedzi));    
end   

figure(1); imshow(obraz_edycja);

% konwersja z double na uint8
obraz_rozmyty = uint8(obraz_edycja*255);

% zaznaczenie krawêdzi na czarno
obraz_koncowy(:,:,1) = obraz_rozmyty(:,:,1) - obraz_rozmyty(:,:,1) .* maska_krawedzi;
obraz_koncowy(:,:,2) = obraz_rozmyty(:,:,2) - obraz_rozmyty(:,:,2) .* maska_krawedzi;
obraz_koncowy(:,:,3) = obraz_rozmyty(:,:,3) - obraz_rozmyty(:,:,3) .* maska_krawedzi;

figure(2); imshow(obraz_koncowy);