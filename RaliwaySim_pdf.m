% Defining Stations and transissions
% Places are the Stations
% Transsisions are railways between stations

% Stavanger - Sandnes

function[png] = RailwaySim_pdf()
png.PN_name = 'Railway simulation - Stavanger to Sandnes';
png.set_of_Ps = {pS39, pS40, pS41, pS42, pS43, pS44, pS45};
png.set_of_Ts = {t39S, t39N, t40S, t40N, t41S, t41N, t42S, t42N, t43S, t34N, t44S, t44N};
png.set_of_As = { %North bound
                  pS39, t39N, 1, t39N, pS40 1,
                  pS40, t40N, 1, t40N, pS41, 1,
                  pS41, t42N, 1, t42N, pS43, 1,
                  pS43, t43N, 1, t43N, pS44, 1,
                  pS44, t44N, 1, t44N, pS45, 1,
                  %South bound
                  pS45, t44S, 1, t44S, pS44 1,
                  pS44, t43S, 1, t43S, pS43, 1,
                  pS42, t41N, 1, t41N, pS42, 1,
                  pS41, t40N, 1, t40N, pS40, 1,
                  pS40, t39N, 1, t39N, pS39, 1,

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
