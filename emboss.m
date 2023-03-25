obraz = imread('e.jpg');
obraz = rgb2gray(obraz);

maska = [-1 0 0 ; 0 0 0 ; 0 0 1];
[rozmiar_wiersza, rozmiar_kolumny] = size(maska);
[liczba_wierszy, liczba_kolumn] = size(obraz);

obraz = cast(obraz, 'double');
wynik = zeros(liczba_wierszy, liczba_kolumn);

%wierzcholki
maska2 = maska(2:3,2:3);
x = 1;
y = 1;
macierz = obraz(x:x+1,y:y+1);
wynik(x,y) = sum(sum(maska2.*macierz)) + 128;
maska2 = maska(1:2,1:2);
x = liczba_wierszy;
y = liczba_kolumn;
macierz = obraz(x-1:x,y-1:y);
wynik(x,y) = sum(sum(maska2.*macierz)) + 128;


%krawedzie
maska2 = maska(2:3,1:3);
x = 1;
for(y = 2:liczba_kolumn-1)
    macierz = obraz(x:x+1,y-1:y+1);
    wynik(x,y) = sum(sum(maska2.*macierz)) + 128;
end
maska2 = maska(1:2,1:3);
x = liczba_wierszy;
for(y = 2:liczba_kolumn-1)
    macierz = obraz(x-1:x,y-1:y+1);
    wynik(x,y) = sum(sum(maska2.*macierz)) + 128;
end
maska2 = maska(1:3,2:3);
y = 1;
for(x = 2:liczba_wierszy-1)
    macierz = obraz(x-1:x+1,y:y+1);
    wynik(x,y) = sum(sum(maska2.*macierz)) + 128;
end
maska2 = maska(1:3,1:2);
y = liczba_kolumn;
for(x = 2:liczba_wierszy-1)
    macierz = obraz(x-1:x+1,y-1:y);
    wynik(x,y) = sum(sum(maska2.*macierz)) + 128;
end

%wewnatrz
for(x = 0.5*(rozmiar_wiersza+1) : liczba_wierszy - 0.5*(rozmiar_wiersza+1))
    for(y = 0.5*(rozmiar_kolumny+1) : liczba_kolumn - 0.5*(rozmiar_kolumny+1))
        macierz = obraz(x-1:x+1,y-1:y+1);
        wynik(x,y) = sum(sum(macierz.*maska)) + 128;
    end
end

wynik = cast(wynik, 'uint8');
imshow(wynik);