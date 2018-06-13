function [ SpecIndex ] = SpecificityIndex_GONOGO(Hits, FalseAlarms, Num_tonesGO, Num_tonesNOGO)

RateHits = Hits./Num_tonesGO; 
RateFA = FalseAlarms./Num_tonesNOGO; 

SpecIndex = RateHits - RateFA; 
BiasIndex = (RateFA./(1-SpecIndex))-0.5; 



end

