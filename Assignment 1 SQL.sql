USE `world`;

/*
Assignment 1, SQL and Databases  
Author: Jonathan Hygrell
Date: 15 October 2021
*/

#Uppgift 2
SELECT
	Name, Population							#Lista stadsnamn och folkmängd
FROM
	city
WHERE
	Name LIKE 'Stockholm';  					#Filtrera ut stockholm från tabellen
    
    
#Uppgift 3
SELECT
	ROW_NUMBER() OVER() AS '#',					#Detta är endast för att numrera alla rader
    Name 										#Lista namn på länder
FROM
	country
WHERE
	Name LIKE '%stan%';							#Ett wildcard för att hitta alla "stan"-länder
    

#Uppgift 4
SELECT
	ROW_NUMBER() OVER() AS '#', 				#Detta är endast för att numrera alla rader
    GovernmentForm AS 'Statsskick', 			#Döper om GovernmentForm till statsskick
    COUNT(GovernmentForm) AS 'Förekommer (ggr)' #Räkna hur många gånger de enskilda statsskicken förekommer
FROM
	country
GROUP BY 
	GovernmentForm;   							#Gruppera efter GovernmentForm, pga aggregate function "COUNT" under SELECT
    
    
#Uppgift 5
SELECT
	ROW_NUMBER() OVER() AS '#',					#Detta är endast för att numrera alla rader
	ci.Name, co.Code AS Country , ci.Population 

FROM 
	city AS ci									#Anger förkortningar för de olika tabellerna jag vill använda i JOIN
JOIN 
	country AS co

ON 
	ci.CountryCode = co.Code 					#Länka ihop CountryCode från tabellen city med Code från tab. country
	
ORDER BY										#Sortera efter folkmängd
	Population
DESC											#DESC sorterar från störst folkmängd och nedåt

LIMIT 10;      									#Enligt uppgift så ska vi lista de 10 största, jag avgränsar med LIMIT



#VG-uppgift query, jag har lagt in en ny table med information i world.sql som är bifogad i zip-filen

#Denna query visar vilka av mina listade länder som har engelska som ett språk
SELECT 
	ROW_NUMBER() OVER() AS '#', 										#Detta är endast för att numrera alla rader
    eng.CountryAbbreviation, co.CountryCode, eng.MainLanguage, 
    co.Language AS 'Alt. language', COUNT(co.Language)  AS '1 for True' #Listar kolumner jag vill visa i output
FROM
    englishlanguage AS eng												#Förkortningar från min egna tabell englishlanguage
JOIN																	#och tabellen country
	countrylanguage AS co
ON
	eng.CountryAbbreviation = co.CountryCode							#länka ihop tabellerna med varandra
WHERE 
	co.Language LIKE '%Engl%' AND co.CountryCode <= 'U'					#ett wildcard för att filtrera språk på "Engl"
GROUP BY CountryCode													#och ett villkor att lista countrycode
																		#mindre eller lika med "U" 
                                                                        #i min lista av länder i "englishlanguage"
;