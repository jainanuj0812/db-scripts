/* ---------------------------------------------------------------------- */
/* Script generated with: DeZign for Databases 12.0.3                     */
/* Target DBMS:           PostgreSQL 8.3                                  */
/* Project file:          Project1.dez                                    */
/* Project name:                                                          */
/* Author:                                                                */
/* Script type:           Database creation script                        */
/* Created on:            2020-07-23 16:09                                */
/* ---------------------------------------------------------------------- */


/* ---------------------------------------------------------------------- */
/* Add tables                                                             */
/* ---------------------------------------------------------------------- */

/* ---------------------------------------------------------------------- */
/* Add table "issuer"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE issuer (
    issuerId INTEGER  NOT NULL,
    name CHARACTER(40)  NOT NULL,
    region CHARACTER(40)  NOT NULL,
    groupId INTEGER,
    ordered BOOLEAN,
    domainName CHARACTER(40),
    specialAudienceAccess BOOLEAN,
    ica CHARACTER(40),
    mastercardIssuer BOOLEAN,
    cid CHARACTER(40),
    matchingStatus CHARACTER(40),
    CONSTRAINT PK_issuer PRIMARY KEY (issuerId)
);

/* ---------------------------------------------------------------------- */
/* Add table "region"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE region (
    regionId INTEGER  NOT NULL,
    regionName CHARACTER(40),
    CONSTRAINT PK_region PRIMARY KEY (regionId)
);

/* ---------------------------------------------------------------------- */
/* Add table "language"                                                   */
/* ---------------------------------------------------------------------- */

CREATE TABLE language (
    languageId INTEGER  NOT NULL,
    languageName CHARACTER(40)  NOT NULL,
    regionId INTEGER,
    CONSTRAINT PK_language PRIMARY KEY (languageId)
);

/* ---------------------------------------------------------------------- */
/* Add table "countries"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE countries (
    countryId INTEGER  NOT NULL,
    countryName CHARACTER(40)  NOT NULL,
    regionId INTEGER,
    CONSTRAINT PK_countries PRIMARY KEY (countryId)
);

/* ---------------------------------------------------------------------- */
/* Add table "language_countries"                                         */
/* ---------------------------------------------------------------------- */

CREATE TABLE language_countries (
    languageId INTEGER  NOT NULL,
    countryId INTEGER  NOT NULL,
    CONSTRAINT PK_language_countries PRIMARY KEY (languageId, countryId)
);

/* ---------------------------------------------------------------------- */
/* Add table "states"                                                     */
/* ---------------------------------------------------------------------- */

CREATE TABLE states (
    stateId CHARACTER(40)  NOT NULL,
    name CHARACTER(40),
    countryId CHARACTER(40)  NOT NULL,
    CONSTRAINT PK_states PRIMARY KEY (stateId, countryId)
);

/* ---------------------------------------------------------------------- */
/* Add table "rules"                                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE rules (
    ruleId INTEGER  NOT NULL,
    ruleName CHARACTER(40)  NOT NULL,
    ruleDescription CHARACTER(40),
    condition CHARACTER(40),
    fieldId CHARACTER(40),
    CONSTRAINT PK_rules PRIMARY KEY (ruleId)
);

/* ---------------------------------------------------------------------- */
/* Add table "issuerCategory"                                             */
/* ---------------------------------------------------------------------- */

CREATE TABLE issuerCategory (
    issuerCategoryId CHARACTER(40)  NOT NULL,
    issuerCategoryName CHARACTER(40)  NOT NULL,
    translation CHARACTER(40),
    CONSTRAINT PK_issuerCategory PRIMARY KEY (issuerCategoryId)
);

/* ---------------------------------------------------------------------- */
/* Add table "issuer_issuerCategory"                                      */
/* ---------------------------------------------------------------------- */

CREATE TABLE issuer_issuerCategory (
    issuerId INTEGER  NOT NULL,
    issuerCategoryId CHARACTER(40)  NOT NULL,
    CONSTRAINT PK_issuer_issuerCategory PRIMARY KEY (issuerId, issuerCategoryId)
);

/* ---------------------------------------------------------------------- */
/* Add table "userField"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE userField (
    userFieldId CHARACTER(40)  NOT NULL,
    userFieldName CHARACTER(40),
    CONSTRAINT PK_userField PRIMARY KEY (userFieldId)
);

/* ---------------------------------------------------------------------- */
/* Add table "userFieldOption"                                            */
/* ---------------------------------------------------------------------- */

CREATE TABLE userFieldOption (
    userFieldOptionId CHARACTER(40)  NOT NULL,
    userFieldOptionValue CHARACTER(40),
    userFieldId CHARACTER(40)  NOT NULL,
    CONSTRAINT PK_userFieldOption PRIMARY KEY (userFieldOptionId, userFieldId)
);

/* ---------------------------------------------------------------------- */
/* Add table "prcoessor"                                                  */
/* ---------------------------------------------------------------------- */

CREATE TABLE prcoessor (
    processorId INTEGER  NOT NULL,
    issuerId INTEGER  NOT NULL,
    regionId INTEGER,
    cobrandLogo CHARACTER(40),
    special BOOLEAN,
    CONSTRAINT PK_prcoessor PRIMARY KEY (processorId)
);

/* ---------------------------------------------------------------------- */
/* Add table "user"                                                       */
/* ---------------------------------------------------------------------- */

CREATE TABLE user (
    userId INTEGER  NOT NULL,
    alias CHARACTER(40),
    emailId CHARACTER(40)  NOT NULL,
    emailFrequency INTEGER,
    issuerId INTEGER  NOT NULL,
    processorId INTEGER,
    blocked BOOLEAN,
    financeInstitution INTEGER,
    lastLoggedIn TIMESTAMP,
    CONSTRAINT PK_user PRIMARY KEY (userId, issuerId)
);

/* ---------------------------------------------------------------------- */
/* Add foreign key constraints                                            */
/* ---------------------------------------------------------------------- */

ALTER TABLE prcoessor ADD CONSTRAINT issuer_prcoessor 
    FOREIGN KEY (issuerId) REFERENCES issuer (issuerId);

ALTER TABLE prcoessor ADD CONSTRAINT region_prcoessor 
    FOREIGN KEY (regionId) REFERENCES region (regionId);

ALTER TABLE language ADD CONSTRAINT region_language 
    FOREIGN KEY (regionId) REFERENCES region (regionId);

ALTER TABLE countries ADD CONSTRAINT region_countries 
    FOREIGN KEY (regionId) REFERENCES region (regionId);

ALTER TABLE user ADD CONSTRAINT prcoessor_user 
    FOREIGN KEY (processorId) REFERENCES prcoessor (processorId);

ALTER TABLE user ADD CONSTRAINT issuer_user 
    FOREIGN KEY (issuerId) REFERENCES issuer (issuerId);

ALTER TABLE language_countries ADD CONSTRAINT language_language_countries 
    FOREIGN KEY (languageId) REFERENCES language (languageId);

ALTER TABLE language_countries ADD CONSTRAINT countries_language_countries 
    FOREIGN KEY (countryId) REFERENCES countries (countryId);

ALTER TABLE states ADD CONSTRAINT countries_states 
    FOREIGN KEY (countryId) REFERENCES countries (countryId);

ALTER TABLE issuer_issuerCategory ADD CONSTRAINT issuer_issuer_issuerCategory 
    FOREIGN KEY (issuerId) REFERENCES issuer (issuerId);

ALTER TABLE issuer_issuerCategory ADD CONSTRAINT issuerCategory_issuer_issuerCategory 
    FOREIGN KEY (issuerCategoryId) REFERENCES issuerCategory (issuerCategoryId);

ALTER TABLE userFieldOption ADD CONSTRAINT userField_userFieldOption 
    FOREIGN KEY (userFieldId) REFERENCES userField (userFieldId);
