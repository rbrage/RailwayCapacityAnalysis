% Defining Stations and transissions
% Places are the Stations
% Transsisions are railways between stations

% Stavanger - Sandnes

function[png] = RailwaySim1_pdf()
png.PN_name = 'Railway simulation - Stavanger to Sandnes';
png.set_of_Ps = {pS39, pS40, pS41, pS42, pS43, pS44, pS45};
png.set_of_Ts = {tS39, tN39, tS40, tN40, tS41, tN41, tS42, tN42, tS43, t43N, tS44, tN44};
png.set_of_As = { %North bound
                  pS39, tN39, 1, tN39, pS40 1,...
                  pS40, tN40, 1, tN40, pS41, 1,...
                  pS41, tN42, 1, tN42, pS43, 1,...
                  pS43, tN43, 1, tN43, pS44, 1,...
                  pS44, tN44, 1, tN44, pS45, 1,...
                  %South bound
                  pS45, tS44, 1, tS44, pS44 1,...
                  pS44, tS43, 1, tS43, pS43, 1,...
                  pS42, tS41, 1, tS41, pS42, 1,...
                  pS41, tS40, 1, tS40, pS40, 1,...
                  pS40, tS39, 1, tS39, pS39, 1,...
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
