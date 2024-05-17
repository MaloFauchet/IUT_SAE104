DROP SCHEMA IF EXISTS sae104_c14 CASCADE; /* CASCADE à voir, pas sur */
CREATE SCHEMA programme_but;
SET SCHEMA 'programme_but';

CREATE TABLE _activites (
    lib_activite VARCHAR(255),
    releve_de VARCHAR(255),
    CONSTRAINT _activites_pk PRIMARY KEY(lib_activite)
);

CREATE TABLE _competences (
    lib_competence VARCHAR(255),
    CONSTRAINT _competences_pk PRIMARY KEY(lib_competence)
);

ALTER TABLE _activites
    ADD CONSTRAINT _activites_fk_competences
    FOREIGN KEY(releve_de) REFERENCES _competences(lib_competence);

CREATE TABLE _niveau (
    numero_n INT,
    CONSTRAINT _niveau_pk PRIMARY KEY(numero_n)
);

CREATE TABLE _semestre (
    numero_sem VARCHAR(255),
    fait_partie INT,
    CONSTRAINT _semestre_pk PRIMARY KEY(numero_sem)
);

ALTER TABLE _semestre
    ADD CONSTRAINT _semestre_fk_niveau
    FOREIGN KEY(fait_partie) REFERENCES _niveau(numero_n);

CREATE TABLE _ue (
    code_ue VARCHAR(255),
    dans VARCHAR(255),
    est_realisee_dans VARCHAR(255),
    CONSTRAINT _ue_pk PRIMARY KEY(code_ue)
);

ALTER TABLE _ue
    ADD CONSTRAINT _ue_fk_semestre
    FOREIGN KEY(dans) REFERENCES _semestre(numero_sem);

ALTER TABLE _ue
    ADD CONSTRAINT _ue_fk_activites
    FOREIGN KEY(est_realisee_dans) REFERENCES _activites(lib_activite);

CREATE TABLE _parcours (
    code_p CHAR,
    libelle_parcours VARCHAR(255),
    nbre_gpe_td INT,
    nbre_gpe_tp INT,
    CONSTRAINT _parcours_pk PRIMARY KEY(code_p)
);

CREATE TABLE _ressources (
    code_r VARCHAR(255),
    lib_r VARCHAR(255),
    nb_h_td_pn INT,
    nb_h_tp_pn INT,
    nb_h_cm_pn INT,
    quand VARCHAR(255),
    CONSTRAINT _ressources_pk PRIMARY KEY(code_r)
);

ALTER TABLE _ressources
    ADD CONSTRAINT _ressources_fk_semestre
    FOREIGN KEY(quand) REFERENCES _semestre(numero_sem);

CREATE TABLE _est_enseignee (
    code_r VARCHAR(255),
    code_p CHAR,
    CONSTRAINT _est_enseignee_pk PRIMARY KEY(code_r, code_p)
);

ALTER TABLE _est_enseignee
    ADD CONSTRAINT _est_enseignee_fk_ressources
    FOREIGN KEY(code_r) REFERENCES _ressources(code_r);

ALTER TABLE _est_enseignee
    ADD CONSTRAINT _est_enseignee_fk_parcours
    FOREIGN KEY(code_p) REFERENCES _parcours(code_p);

CREATE TABLE _sae (
    code_sae VARCHAR(255),
    lib_sae VARCHAR(255),
    nb_h_td_enc INT,
    nb_h_td_projet_autonomie INT,
    CONSTRAINT _sae_pk PRIMARY KEY(code_sae)
);

CREATE TABLE _r_comp (
    code_r VARCHAR(255),
    code_sae VARCHAR(255),
    nb_h_td_c INT,
    nb_h_tp_c INT,
    CONSTRAINT _r_comp_pk PRIMARY KEY (code_r, code_sae)
);

ALTER TABLE _r_comp
    ADD CONSTRAINT _r_comp_fk_ressources
    FOREIGN KEY(code_r) REFERENCES _ressources(code_r);

ALTER TABLE _r_comp
    ADD CONSTRAINT _r_comp_fk_sae
    FOREIGN KEY(code_sae) REFERENCES _sae(code_sae);

CREATE TABLE _correspond (
    lib_activite VARCHAR(255),
    numero_n INT,
    code_p CHAR,
    CONSTRAINT _correspond_pk PRIMARY KEY(lib_activite, numero_n, code_p)
);

ALTER TABLE _correspond
    ADD CONSTRAINT _correspond_fk_activites
    FOREIGN KEY(lib_activite) REFERENCES _activites(lib_activite);

ALTER TABLE _correspond
    ADD CONSTRAINT _correspond_fk_niveau
    FOREIGN KEY(numero_n) REFERENCES _niveau(numero_n);

ALTER TABLE _correspond
    ADD CONSTRAINT _correspond_fk_parcours
    FOREIGN KEY(code_p) REFERENCES _parcours(code_p);