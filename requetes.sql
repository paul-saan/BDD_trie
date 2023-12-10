
/*-----------------------/
/                       /
/  EXO 3                /   
/----------------------*/

/*Q1: Il y a 15 colonnes.*/
SELECT COUNT(*) as exo_Q1 FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'import';

/*Q2: 255 080 lignes.*/
Select count(*) as exo3_Q2 from import ;

/*Q3: Il y en a 231 codes NOC.*/
Select count(distinct noc) as exo3_Q3 from regions ;

/*Q4: 126 782 */
Select count(distinct id) as exo3_Q4 from import ;

/*Q5: 12116*/
Select count(*) as exo_Q5 from import Where medal ='Gold' ;

/*Q6:*/
Select count(*) as exo3_Q6 from import where name Like 'Carl Lewis%' ; 


/*-----------------------/
/                       /
/  EXO 5                /   
/----------------------*/

/*Q1*/

Select region,count(*) 
from epreuve as e, pays as p 
where p.noc=e.noc 
group by region 
order by count desc;

/*Q2*/

Select region,count(*)
from epreuve as e, pays as p
where e.noc = p.noc
and medal='Gold' 
group by region
order by count desc;

/*Q3*/

Select region,count(*) 
from epreuve as e, pays as p
where e.noc=p.noc
and medal is not null 
group by region
order by count desc;

/*Q4*/

Select name,count(*) 
from epreuve as e, competiteur as c 
where c.id=e.id 
and medal='Gold' 
group by c.name 
order by count desc;

/*Q5*/

Select noc,count(*) from epreuve as e, games as g 
where e.gno=g.gno 
and city='Albertville' 
and medal in('Bronze','Silver','Gold') 
group by noc 
order by count desc;

/*Q8*/

Select age,count(*) 
from epreuve 
where medal ='Gold' 
and age is not null 
group by age 
order by age desc;

/*Q9*/

Select sport,count(*) 
from epreuve as e,event as ev 
where e.eno=ev.eno 
and medal is not null 
and age is not null 
and age >50 group by sport 
order by sport;

/*Q10*/

Select count(*),season,year 
from epreuve as e , games as g,event as ev 
Where e.gno=g.gno 
and ev.eno=e.eno 
group by season,year 
order by year;

/*Q11*/

Select count(*),year from epreuve as e, games as g,competiteur as c 
where g.gno=e.gno 
and c.id=e.id 
and medal is not null 
and sex='F' 
and season='Summer' 
group by year 
order by year; 


/*-----------------------/
/                       /
/  EXO 6                /   
/----------------------*/

/*JUDO FRANCAIS*/


/*Requete permettant de savoir le classement de la france au judo au niveau des médailles par rapport aux autres pays.*/


Select noc,count(*)
from epreuve as e1, event as e2,competiteur as c,games as g 
where e1.eno=e2.eno 
and g.gno=e1.gno 
and c.id=e1.id 
and medal is not null
and sport='Judo'
group by noc
order by count desc;


/*Requete permettant de savoir le classement de la france au judo masculin du niveau des médailles par rapport aux autres pays.*/

Select noc,count(*)
from epreuve as e1, event as e2,competiteur as c,games as g 
where e1.eno=e2.eno 
and g.gno=e1.gno 
and c.id=e1.id 
and medal is not null
and sport='Judo' 
and c.sex='M'
group by noc
order by count desc;


/*Requete permettant de savoir le classement de la france au judo féminin du niveau des médailles par rapport aux autres pays.*/

Select noc,count(*)
from epreuve as e1, event as e2,competiteur as c,games as g 
where e1.eno=e2.eno 
and g.gno=e1.gno 
and c.id=e1.id 
and medal is not null
and sport='Judo' and c.sex='F'
group by noc
order by count desc;

/*Requete permettant d'afficher le classement des athlètes francais ayant le plus de médailles au JUDO*/

Select name,sport,age,game_name,games,medal
from epreuve as e1, event as e2,competiteur as c,games as g 
where e1.eno=e2.eno 
and g.gno=e1.gno 
and c.id=e1.id 
and medal is not null
and sport='Judo' and noc='FRA' 
and name like 'Teddy%';





