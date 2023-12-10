drop table if exists import ;
drop table if exists regions ;
drop table if exists epreuve ;
drop table if exists competiteur ;
drop table if exists event ;
drop table if exists pays ;
drop table if exists games ;
drop table if exists sport;



/*-----------------------/
/                       /
/  EXO 2              /   
/----------------------*/


/*Création de la table import*/
create table import(id int, name text, sex char(1), age int, height int, weight float, team text, noc char(3), games text, year int, season text, city text, sport text, event text, medal text);

/*Création de la table regions*/
create table regions(noc char(3) primary key,region text, notes text);

/*Importation des données du csv dans la table import*/
\copy import from 'athlete_events.csv' delimiter ',' header null 'NA' quote '"' encoding 'ISO-8859-1' CSV;

/*Importation des données du csv dans la table régions*/
\copy regions from noc_regions.csv delimiter ',' header csv null '';

/*Suppression des données inférieur à l'année 1920 et des épreuves du sport 'Art competetions*/
delete from import where year  < 1920 or sport = 'Art Competitions';  




/*-----------------------/
/                       /
/  EXO 4               /   
/----------------------*/


/*Création de la table pays*/

Create table pays(
    NOC char(3),
    region text,
    notes text,
    Constraint pk_pays primary key(NOC)
);


/*Création de la table competiteur*/

Create table competiteur(
    id int,
    name text,
    sex text,
    height int,
    weight int,
    Constraint pk_competiteur primary key(id)
);

/*Création de la table sport*/

Create table sport(
    sport text,
    Constraint pk_sport primary key(sport)
);

/*Création de la table event*/

Create table event(
    eno serial,
    game_name text,
    sport text,
    Constraint pk_event primary key(eno),
    Constraint fk_sport foreign key(sport) References sport(sport)
);

/*Création de la table games*/

CREATE TABLE games(
    gno serial, 
    year int, 
    season text,
    city text,
    games text,
    CONSTRAINT pk_games primary key(gno)
);

/*Création de la table epreuves*/

Create table epreuve(
    eno int,
    id int,
    gno int,
    NOC char(3),
    age int,
    medal text,
    Constraint fk_competiteurs foreign key(id) REFERENCES competiteur(id),
    Constraint fk_event foreign key(eno) REFERENCES event(eno),
    Constraint fk_games foreign key(gno) REFERENCES games(gno),
    Constraint fk_pays foreign key(noc) References pays(noc),
    COnstraint pk_epreuve primary key(eno,gno,id,noc)
);



Insert into pays(NOC,region) Values ('SGP','Singapour');

/* Insertion des données de la table pays*/
Insert into pays Select * From regions ;


/* Insertion des données de la table sport*/
Insert into sport Select distinct sport from import order by sport asc;


/* Insertion des données de la table games*/
Insert into games(year,season,city,games) select distinct i.year,i.season,i.city,i.games from import as i
order by year asc;


/* Insertion des données de la table event*/
Insert into event(game_name,sport) select distinct i.event,s.sport from import as i, sport as s Where s.sport=i.sport;


/* Insertion des données de la table compétiteur*/
Insert into competiteur(name,sex,height,weight,id) Select distinct i.name,i.sex,i.height,i.weight,i.id  
From import as i order by name asc;


/* Insertion des données de la table epreuve*/
Insert into epreuve(eno,id,gno,age,medal,noc) Select e.eno,c.id,g.gno,i.age,i.medal,p.noc
From import as i ,event as e, competiteur as c, games as g, pays as p
Where c.id=i.id
And e.game_name =i.event
And p.noc = i.noc
And g.year=i.year and g.city=i.city and g.season=i.season;
 



