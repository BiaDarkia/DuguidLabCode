function sita = GetAngle(p1, p2)
   temp =(p1(1)*p2(1) + p1(2)*p2(2))/(sqrt(sum(p1.^2))*sqrt(sum(p2.^2)));
   sita = acos(temp);
end
