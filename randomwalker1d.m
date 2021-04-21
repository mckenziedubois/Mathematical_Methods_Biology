function randomwalker1d(N,M)
x = zeros(M,N)
for j=1:M
    for i =1:N-1
        r=rand;
        if r<0.5; 
            x(i+1,j)= x(i,j)+1
        else
            x(i+1,j)=x(i,j)-1;
        end
    end
end
plot(x)
xlabel('time step'); 
ylabel('position'); 
end

