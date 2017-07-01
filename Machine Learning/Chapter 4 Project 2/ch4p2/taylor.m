syms x
f = exp(x/2)*sin(x);
xa = zeros(101,1);
ya = zeros(101,1);
y = (x + (1/factorial(2))*x^2 * diff(f) + (1/factorial(3))*x^3 * diff(diff(f))+   (1/factorial(4)) * diff(diff(diff(f)))+ (1/factorial(5)) * diff(diff(diff(diff(f)))));
count=0;

for c=0:6.5/100:6.5;
    count = count+1;
    xa(count,1)=c;
    ya(count,1)= subs(y,x,c);
end
xa
ya


plot(xa,ya)

grid on
