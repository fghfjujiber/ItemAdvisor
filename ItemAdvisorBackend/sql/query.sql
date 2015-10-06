DROP TABLE IF EXISTS `postDB`;
DROP TABLE IF EXISTS `followDB`;
DROP TABLE IF EXISTS `tagDB`;
DROP TABLE IF EXISTS `commentDB`;
DROP TABLE IF EXISTS `likeDB`;
DROP TABLE IF EXISTS `imgDB`;

CREATE TABLE postDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    user_id         INT(11) NOT NULL,
    content         TEXT NOT NULL,
    no_view         INT(11) NOT NULL,
    time_stamp      INT(11) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE followDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    follower_id     INT(11) NOT NULL, 
    following_id    INT(11) NOT NULL, 
    PRIMARY KEY (id)
);

CREATE TABLE tagDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    user_id         INT(11) NOT NULL, 
    post_id         INT(11) NOT NULL,
    tag_type        INT(11) NOT NULL, 
    tag_desc        TEXT NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE commentDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    user_id         INT(11) NOT NULL, 
    reply_id        INT(11) NOT NULL, 
    post_id         INT(11) NOT NULL,
    content         TEXT NOT NULL,
    time_stamp      INT(11) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE likeDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    user_id         INT(11) NOT NULL, 
    post_id         INT(11) NOT NULL,
    flag            INT(11) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE imgDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    post_id         INT(11) NOT NULL,
    img             TEXT NOT NULL,
    PRIMARY KEY (id)
);

-- userDB

DROP TABLE IF EXISTS `userDB`;

CREATE TABLE userDB
(
    id              INT(11) NOT NULL AUTO_INCREMENT,
    email           VARCHAR(70) NOT NULL, 
    firstname       VARCHAR(50) NOT NULL,
    lastname        VARCHAR(50) NOT NULL,
    password        VARCHAR(255) NOT NULL,
    description     TEXT NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO `userDB` (email, firstname, lastname, password, description) values ('xiaoming.chen10@gmail.com','Xiaoming','Chen','4297f44b13955235245b2497399d7a93','Im lazy to write descriptions');
INSERT INTO `userDB` (email, firstname, lastname, password, description) values ('mr.yuxiang.zhou@googlemail.com','Yuxiang','Zhou','4297f44b13955235245b2497399d7a93','Im lazy to write descriptions');
INSERT INTO `userDB` (email, firstname, lastname, password, description) values ('guohongcheng1@gmail.com','Guohong','Chen','4297f44b13955235245b2497399d7a93','Im lazy to write descriptions');
