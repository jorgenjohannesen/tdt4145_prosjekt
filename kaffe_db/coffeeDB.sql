-- sletter eksisterende tabeller

DROP TABLE IF EXISTS kaffe;
DROP TABLE IF EXISTS bruker;
DROP TABLE IF EXISTS kaffesmaking;
DROP TABLE IF EXISTS kaffebrenneri;
DROP TABLE IF EXISTS kaffeparti;
DROP TABLE IF EXISTS boenneIParti;
DROP TABLE IF EXISTS gaard;
DROP TABLE IF EXISTS foredlingsmetode;
DROP TABLE IF EXISTS kaffeboenne;
DROP TABLE IF EXISTS boenneDyrkesAv;
DROP TABLE IF EXISTS art;

-- oppretter tabeller

CREATE TABLE bruker (
    brukerID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    epostadresse VARCHAR(30) NOT NULL,
    fullt_navn VARCHAR(30) NOT NULL,
    passord VARCHAR(30) NOT NULL
);

CREATE TABLE kaffesmaking (
    smakingID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    notater VARCHAR(30) NOT NULL,
    poeng INTEGER NOT NULL,
    smaking_dato DATE NOT NULL,
    brukerID INTEGER NOT NULL,
    kaffeID INTEGER NOT NULL,
    CONSTRAINT kaffesmaking_fk1 FOREIGN KEY (brukerID) 
        REFERENCES bruker(brukerID)
            ON UPDATE CASCADE
            ON DELETE SET NULL,
    CONSTRAINT kaffesmaking_fk2 FOREIGN KEY (kaffeID) 
        REFERENCES kaffe(kaffeID)
            ON UPDATE CASCADE       
            ON DELETE CASCADE
);

CREATE TABLE kaffe (
    kaffeID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    kaffe_navn VARCHAR(30) NOT NULL,
    kaffe_beskrivelse VARCHAR(30) NOT NULL,
    kiloprisINOK INTEGER NOT NULL,
    brenningsgrad VARCHAR(30) NOT NULL,
    brenning_dato VARCHAR(30) NOT NULL,
    brenneriID INTEGER NOT NULL,
    partiID INTEGER NOT NULL,
    CONSTRAINT kaffe_fk1 FOREIGN KEY (brenneriID) 
        REFERENCES kaffebrenneri(brenneriID)
            ON DELETE SET NULL
            ON UPDATE CASCADE,
    CONSTRAINT kaffe_fk2 FOREIGN KEY (partiID) 
        REFERENCES kaffeparti(partiID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

CREATE TABLE kaffebrenneri (
    brenneriID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    brenneri_navn VARCHAR(30) NOT NULL
);

CREATE TABLE kaffeparti (
    partiID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    innhostningsaar INTEGER NOT NULL,
    kiloprisIUSD INTEGER NOT NULL,
    foredlingsID INTEGER NOT NULL,
    gaardID INTEGER NOT NULL,
    CONSTRAINT kaffeparti_fk1 FOREIGN KEY (foredlingsID) 
        REFERENCES foredlingsmetode(foredlingsID),
    CONSTRAINT kaffeparti_fk2 FOREIGN KEY (gaardID) 
        REFERENCES gaard(gaardID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE boenneIParti (
    boenneID INTEGER NOT NULL,
    partiID INTEGER NOT NULL,
    CONSTRAINT boenneIParti_pk PRIMARY KEY (boenneID, partiID),
    CONSTRAINT boenneIParti_fk1 FOREIGN KEY (boenneID) 
        REFERENCES kaffeboenne(boenneID)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT boenneIParti_fk2 FOREIGN KEY (partiID) 
        REFERENCES kaffeparti(partiID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

CREATE TABLE gaard (
    gaardID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    gaard_navn VARCHAR(30) NOT NULL,
    moh INTEGER NOT NULL,
    land VARCHAR(30) NOT NULL,
    region VARCHAR(30) NOT NULL
);

CREATE TABLE foredlingsmetode (
    foredlingsID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    metode_navn VARCHAR(30) NOT NULL,
    metode_beskrivelse VARCHAR(30) NOT NULL
);

CREATE TABLE kaffeboenne (
    boenneID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    boenne_navn VARCHAR(30) NOT NULL,
    art VARCHAR(30) NOT NULL
);

CREATE TABLE boenneDyrkesAv (
    boenneID INTEGER NOT NULL,
    gaardID INTEGER NOT NULL,
    CONSTRAINT boenneDyrkesAv_pk PRIMARY KEY (boenneID, gaardID),
    CONSTRAINT boenneDyrkesAv_fk1 FOREIGN KEY (boenneID) 
        REFERENCES kaffeboenne(boenneID)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
    CONSTRAINT boenneDyrkesAv_fk2 FOREIGN KEY (gaardID) 
        REFERENCES gaard(gaardID)
            ON UPDATE CASCADE
            ON DELETE CASCADE
);

INSERT INTO bruker VALUES (1, 'navn@navn.no', 'Navn Navnesen', 'Passord123');
INSERT INTO bruker VALUES (2, 'martin.Odegaard@arsenal.no', 'Martin Ødegaard', 'RealMardrid7');
INSERT INTO bruker VALUES (3, 'elton@everglades.com', 'Elton John', 'YourSong12');
INSERT INTO bruker VALUES (4, 'skooog@østfold.no', 'Henrik Skog', 'VimmernAGett');
INSERT INTO bruker VALUES (5, 'demo@bruker.no', 'Demo Brukersen', 'Demopassord');

INSERT INTO kaffeboenne VALUES (1, 'Bourbon', 'Arabica');
INSERT INTO kaffeboenne VALUES (2, 'Lommedalsbønne', 'Liberica');
INSERT INTO kaffeboenne VALUES (3, 'Slependenbønne', 'Robusta');
INSERT INTO kaffeboenne VALUES (4, 'Hvalstadbønne', 'Arabica');

INSERT INTO gaard VALUES (1, 'Ringi', 100, 'Norge', 'Akershus');
INSERT INTO gaard VALUES (2, 'Farmen-gården', 1800, 'Østerrike', 'Wien');
INSERT INTO gaard VALUES (3, 'Øverland Gård', 250, 'Rwanda', 'Vita');
INSERT INTO gaard VALUES (4, 'Martin', 760, 'Colombia', 'Lolain');
INSERT INTO gaard VALUES (5, 'Nombre de Dios', 1500, 'El Salvador', 'Santa Ana');

INSERT INTO foredlingsmetode VALUES (1, 'Vasket', 'Grønnsåpe og vann') ;
INSERT INTO foredlingsmetode VALUES (2, 'Bærtørket', 'Med hårføner') ;
INSERT INTO foredlingsmetode VALUES (3, 'Semi-vasket', 'Kun vann');
INSERT INTO foredlingsmetode VALUES (4, 'Soltørket', 'Tørket i solen');

INSERT INTO kaffeparti VALUES (1, 2018, 12, 3, 2);
INSERT INTO kaffeparti VALUES (2, 2020, 7, 4, 4);
INSERT INTO kaffeparti VALUES (3, 2022, 4, 2, 2);
INSERT INTO kaffeparti VALUES (4, 2020, 10, 1, 3);
INSERT INTO kaffeparti VALUES (5, 2021, 8, 2, 5);

INSERT INTO kaffe VALUES (1, 'Kveldsro', 'Kaffe med lite koffein, fin på kveldstid.', 150, 'Lys', '05/01/2022', 2, 1);
INSERT INTO kaffe VALUES (2, 'Oppkvikkern', 'Rask energi på morgenen, denne er det krutt i.', 60, 'Mørk', '01/03/2022', 3, 3)  ;
INSERT INTO kaffe VALUES (3, 'Dark Heaven', 'En mørk som kjennes i hele kroppen.', 90, 'Mørk', '08/12/2022', 1, 2);
INSERT INTO kaffe VALUES (4, 'Bakfull', 'En kaffe perfekt for dagen derpå, floral i formen.', 120, 'Middels', '22/02/2022', 4, 4);
INSERT INTO kaffe VALUES (5, 'Vinterkaffe 2022', 'En velsmakende og kompleks kaffe for mørketiden', 600, 'Lys', '20/01/2022', 5, 5);

INSERT INTO kaffebrenneri VALUES (1, 'Kaffebrenneriet');
INSERT INTO kaffebrenneri VALUES (2, 'Kaffeslasken');
INSERT INTO kaffebrenneri VALUES (3, 'Brennstasjonen');
INSERT INTO kaffebrenneri VALUES (4, 'Brenneriet 2015');
INSERT INTO kaffebrenneri VALUES (5, 'Jacobsen & Svart');

INSERT INTO boenneIParti VALUES (1, 3);
INSERT INTO boenneIParti VALUES (2, 4);
INSERT INTO boenneIParti VALUES (3, 2);
INSERT INTO boenneIParti VALUES (3, 1);
INSERT INTO boenneIParti VALUES (1, 5);

INSERT INTO boenneDyrkesAv VALUES (1, 3);
INSERT INTO boenneDyrkesAv VALUES (2, 4);
INSERT INTO boenneDyrkesAv VALUES (3, 2);
INSERT INTO boenneDyrkesAv VALUES (4, 1);
INSERT INTO boenneDyrkesAv VALUES (1, 5);

INSERT INTO kaffesmaking VALUES (1,'Meget god kaffe, fin farge og aroma',8,'05/03/2022',1,3);
INSERT INTO kaffesmaking VALUES (2,'Fikk meg umiddelbart i form på blåmandag, kanskje litt bitter for min smak',7,'22/02/2022',3,2);
INSERT INTO kaffesmaking VALUES (3,'Ikke verdt den høye prisen. En god kaffe, men ikke helt der oppe.',3,'07/02/2022',1,4);
INSERT INTO kaffesmaking VALUES (4,'God kaffe, gleder meg til å severe denne til gjester. Floral og fin!',6,'05/12/2022',2,1);
INSERT INTO kaffesmaking VALUES (5,'Fin farge og aroma, men litt for sterk for meg',6,'05/01/2022',2,2);
