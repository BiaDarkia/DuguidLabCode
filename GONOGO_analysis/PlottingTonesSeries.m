function PlottingTonesSeries(Goseries_mean, Nogoseries_mean, mouse_ID)


Toneseries_mean = [Goseries_mean(:,mouse_ID) Nogoseries_mean(:, mouse_ID)];
a = bar(Toneseries_mean); 
a(1).FaceColor = 'b'; a(2).FaceColor = 'r'; 
xlabel('Training days'), ylabel('mSec'); title('Avarage series of same tone');
legend('GO', 'NOGO','Location', 'NorthWest'); hold off;


end

