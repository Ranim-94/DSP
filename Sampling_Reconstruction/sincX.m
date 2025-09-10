function y=sincX(x)
ind=find(x==0);                                                              
x(ind)= 1;
y = sin(x)./(x);                                                     
y(ind) = 1;   

