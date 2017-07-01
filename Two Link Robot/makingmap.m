

for i=1:100
    for j=1:100
    map(i,j) = 0;
    end 
end


%p=[ 2 3 3 13; 3 3 16 4; 6 6 12 8; 5 10 15 12; 15 11 20 12; 16 6 18 10].*5
p=[10 10 40 30; 60 10 90 30; 0 60 40 80; 50 50 80 70; 60 90 100 100];
k=0;
for k = 1:length(p)
    %disp(k);
    for i=1:100
        for j=1:100
            %disp(i);
            if ((p(k,1)<=j) && (p(k,2)<=i) && (p(k,3) >=j) && (p(k,4) >= i))
                disp 1
                map(i,j) = 1;
            end
        end 
    end 
end; 

%save('')
%{

    for i=2:99
        for j=2:99
%disp(i);
                if map(i,j) == 1
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i-1,j)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                
                if map(i+1,j)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i,j-1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                  end
                if map(i,j+1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i-1,j-1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i-1,j+1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i+1,j+1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
                if map(i+1,j-1)  == 1
                
                    if map(i,j) == 0
                        map(i,j) = 2;
                    end 
                end
        end 
    end 
%}