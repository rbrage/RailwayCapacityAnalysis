% Defining Stations and transissions
% Places are the Stations
% Transsisions are railways between stations

function[png] = RailwaySim_pdf()
png.PN_name = 'Railway simulation';
png.set_of_Ps = {};
png.set_of_Ts = {};
png.set_of_As = {};

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
