% Defining Stations and transissions
% Places are the Stations
% Transsisions are railways between stations
% Stavanger - Sandnes

function [png] = RailwaySim_pdf()
png.PN_name = 'Railway simulation - Stavanger to Sandnes';
png.set_of_Ps = {'pGenStavanger', 'pGenSandnes',...
    'Stavanger', 'Paradis', 'Mariero', 'Jattavagen',...
    'Gausel', 'SandnesSentrum', 'Sandnes'};

png.set_of_Ts = {'tInStavanger', ... %'tInSandnes',
     'SToParadis', 'SToMariero', 'SToJattavagen','SToGausel', 'SToSandnesSentrum', 'SToSandnes',...
     'NToSandnesSentrum','NToGausel','NToJattavagen','NToMariero','NToParadis','NToStavanger'};
%'pGenSandnes', 'tInSandnes', 1, 'tInSandnes', 'Sandnes', 1,...
png.set_of_As = {
    'pGenStavanger','tInStavanger', 1, 'tInStavanger', 'Stavanger', 1,...
    'Stavanger', 'SToParadis', 1, 'SToParadis', 'Paradis', 1,...
    'Paradis', 'SToMariero', 1, 'SToMariero', 'Mariero', 1,...
    'Mariero', 'SToJattavagen', 1, 'SToJattavagen', 'Jattavagen', 1,...
    'Jattavagen', 'SToGausel', 1, 'SToGausel', 'Gausel', 1,...
    'Gausel', 'SToSandnesSentrum', 1, 'SToSandnesSentrum', 'SandnesSentrum', 1,...
    'SandnesSentrum', 'SToSandnes', 1, 'SToSandnes', 'Sandnes', 1,...
    'Sandnes', 'NToSandnesSentrum', 1, 'NToSandnesSentrum', 'SandnesSentrum', 1, ...
    'SandnesSentrum', 'NToGausel', 1, 'NToGausel', 'Gausel', 1,...
    'Gausel','NToJattavagen',1, 'NToJattavagen','Jattavagen', 1,...
    'Jattavagen','NToMariero',1, 'NToMariero','Mariero', 1,...
    'Mariero','NToParadis',1, 'NToParadis','Paradis', 1,...
    'Paradis','NToStavanger',1, 'NToStavanger','Stavanger', 1
    };

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
