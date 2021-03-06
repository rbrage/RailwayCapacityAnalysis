% Defining Stations and transissions
% Places are the Stations
% Transsisions are railways between stations
% Stavanger - Sandnes

function [png] = RailwaySim_pdf()

global global_info;

% Sets name of simulation
png.PN_name = 'Railway simulation - Stavanger to Egersund';

% Sets generators
png.set_of_Ps = {'pGenStavanger', 'pGenSandnes', 'pGenNaerbo','pGenEgersund', 'pGenMoi', 'pGenKristiansand', 'pGenDrammen', 'pGenGulskogen', 'pGenGanddal',...
 'pOutStavangerS','pOutSandnes','pOutNaerbo','pOutEgersund', 'pOutKristiansand','pOutDrammen', 'pOutGulskogen', 'pOutGanddal', 'pOutNeslandsvatn'};

png.set_of_Ts = {'tInStavanger','tInSandnes','tInNaerbo', 'tInEgersund', 'tInMoi','tInKristiansand', 'tInDrammen', 'tInGulskogen', 'tInGanddal',...
'tOutStavangerS','tOutSandnes','tOutNaerbo','tOutEgersund','tOutKristiansand','tOutDrammen', 'tOutGulskogen', 'tOutGanddal', 'tOutNeslandsvatn'};

png.set_of_As = {'pGenStavanger','tInStavanger', 1, 'tInStavanger', 'StavangerS', 1, ...
                        'tInStavanger', 'pGenStavanger', 1,...
                  'pGenSandnes','tInSandnes',1, 'tInSandnes','Sandnes',1,...
                        'tInSandnes','pGenSandnes',1,...
                  'pGenNaerbo','tInNaerbo',1,'tInNaerbo','Naerbo',1,...
                        'tInNaerbo','pGenNaerbo',1,...
                  'pGenEgersund','tInEgersund',1,'tInEgersund','Egersund',1,...
                        'tInEgersund','pGenEgersund',1,...
                  'pGenMoi','tInMoi',1,'tInMoi','Moi',1,...
                        'tInMoi','pGenMoi',1,...
                  'pGenKristiansand','tInKristiansand',1,'tInKristiansand','Kristiansand',1,...
                        'tInKristiansand','pGenKristiansand',1,...
                  'pGenDrammen','tInDrammen',1,'tInDrammen','Drammen',1,...
                        'tInDrammen','pGenDrammen',1,...
                  'pGenGanddal','tInGanddal',1,'tInGanddal','Ganddal',1,...
                        'tInGanddal','pGenGanddal',1,...
                  'pGenGulskogen','tInGulskogen',1,'tInGulskogen','Gulskogen',1,...
                        'tInGulskogen','pGenGulskogen',1,...
                  'StavangerS', 'tOutStavangerS', 1, 'tOutStavangerS', 'pOutStavangerS', 1,...
                  'Sandnes', 'tOutSandnes', 1, 'tOutSandnes', 'pOutSandnes',1,...
                  'Naerbo', 'tOutNaerbo', 1,'tOutNaerbo','pOutNaerbo',1,...
                  'Egersund','tOutEgersund',1,'tOutEgersund','pOutEgersund',1,...
                  'Kristiansand','tOutKristiansand',1,'tOutKristiansand','pOutKristiansand',1,...
                  'Drammen','tOutDrammen',1,'tOutDrammen','pOutDrammen',1,...
                  'Ganddal','tOutGanddal',1,'tOutGanddal','pOutGanddal',1,...
                  'Gulskogen','tOutGulskogen',1,'tOutGulskogen','pOutGulskogen',1,...
                  'Neslandsvatn','tOutNeslandsvatn',1,'tOutNeslandsvatn','pOutNeslandsvatn',1};


stations = global_info.stations;

% Dynamically generates train stations and rail connections south bound
for i = 1:length(stations),
    png.set_of_Ps = [png.set_of_Ps {strjoin(['', stations(i)], '')}];
    if i < length(stations),
        png.set_of_Ts = [png.set_of_Ts {strjoin(['SF', stations(i)], '')}];
        png.set_of_As = [png.set_of_As {strjoin(['', stations(i)], ''), strjoin(['SF', stations(i)], '')} 1 ...
            {strjoin(['SF', stations(i)], ''), strjoin(['', stations(i+1)], '') 1}];
    end;
end;

% Dynamically generates train stations and rail connections north bound
for i= (length(stations)-1):-1:1,
    %if i > 1, % length(global_info.stations),%
        png.set_of_Ts = [png.set_of_Ts {strjoin(['NT', stations(i)], '')}];
        png.set_of_As = [png.set_of_As {strjoin(['', stations(i+1)], ''), strjoin(['NT', stations(i)], '')} 1 ...
            {strjoin(['NT', stations(i)], ''), strjoin(['', stations(i)], '') 1}];
    %end;
end;

%disp(png.set_of_Ps);
%disp('...................................')
% disp(png.set_of_Ts);
%disp('...................................')
%disp(png.set_of_As);

disp('PDF created');

% 1. Gulskogen
% 2. Mjøndalen
% 3. Steinberg
% 4. Hokksund
% 5. Vestfossen
% 6. Darbu
% 7. Kongsberg
% 8. Nordagutu
% 9. Bø
% 10. Lunde
% 11. Drangedal
% 12. Neslandsvatn
% 13. Gjerstad
% 14. Vegårshei
% 15. Nelaug
% 16. Vennesla
% 17. Kristiansand
% 18. Nodeland
% 19. Breland
% 20. Marnardal
% 21. Audnedal
% 22. Snartemo
% 23. Storekvina
% 24. Gyland
% 25. Sira
% 26. Moi
% 27. Egersund
% 28. Hellvik
% 29. Sirevåg
% 30. Ogna
% 31. Brusand
% 32. Vigrestad
% 33. Varhaug
% 34. Nærbø
% 35. Bryne
% 36. Klepp
% 37. Øksnavadporten
% 38. Ganddal
% 39. Sandnes
% 40. Sandnes sentrum
% 41. Gausel
% 42. Jåttåvågen
% 43. Mariero
% 44. Paradis
% 45. Stavanger
