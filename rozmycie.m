function X = rozmycie(A,B,C)  
  
    if size(A,3) == 1   
 
% dla czarnobialego

    [X,Y] = meshgrid(-B:B,-B:B);  
    E = exp(-(X.^2+Y.^2)/(2*C(1)^2));  
  
    % zastosowanie filtra 
    wymiar = size(A);  
    X = zeros(wymiar);  
    for y = 1:wymiar(1)  
        for z = 1:wymiar(2)  
            MaleY = max(y-B,1);  
            MaleZ = min(y+B,wymiar(1));  
            DuzeY = max(z-B,1);  
            DuzeZ = min(z+B,wymiar(2));  
            I = A(MaleY:MaleZ,DuzeY:DuzeZ);
         
            intensywnosc = exp(-(I-A(y,z)).^2/(2*C(2)^2));  
        
            % obliczanie odpowiedzi filtra  
            F = intensywnosc.*E((MaleY:MaleZ)-y+B+1,(DuzeY:DuzeZ)-z+B+1);  
            X(y,z) = sum(F(:).*I(:))/sum(F(:));  
                 
        end

    end
        
    else
 
    % wagi
    [X,Y] = meshgrid(-B:B,-B:B);  
    E = exp(-(X.^2+Y.^2)/(2*C(1)^2));  
  
    % przeskalowanie
    C(2) = 100*C(2);  
  
    % zastosowanie filtra  
    wymiar = size(A);  
    X = zeros(wymiar);  
    for y = 1:wymiar(1)  
        for z = 1:wymiar(2)  
            MaleY = max(y-B,1);  
            MaleZ = min(y+B,wymiar(1));  
            DuzeY = max(z-B,1);  
            DuzeZ = min(z+B,wymiar(2));  
            wsumie = A(MaleY:MaleZ,DuzeY:DuzeZ,:);  
        
            % obliczenie wag 
            aa = wsumie(:,:,1)-A(y,z,1);  
            bb = wsumie(:,:,2)-A(y,z,2);  
            cc = wsumie(:,:,3)-A(y,z,3);  
            intensywnosc = exp(-(aa.^2+bb.^2+cc.^2)/(2*C(2)^2));  
        
            % obliczenie odpowiedzi filtra
            dd = intensywnosc.*E((MaleY:MaleZ)-y+B+1,(DuzeY:DuzeZ)-z+B+1);  
            suma = sum(dd(:));  
            X(y,z,1) = sum(sum(dd.*wsumie(:,:,1)))/suma;  
            X(y,z,2) = sum(sum(dd.*wsumie(:,:,2)))/suma;  
            X(y,z,3) = sum(sum(dd.*wsumie(:,:,3)))/suma;  
                  
        end

    end

    end
end
