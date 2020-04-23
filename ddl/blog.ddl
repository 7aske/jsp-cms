/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     4/23/2020 9:14:25 AM                         */
/*==============================================================*/


drop table if exists author;

drop table if exists comment;

drop table if exists post;

drop table if exists post_tag;

drop table if exists role;

drop table if exists tag;

drop table if exists user;

drop table if exists user_role;

/*==============================================================*/
/* Table: author                                                */
/*==============================================================*/
create table author
(
   id_user              int not null,
   display_name         varchar(32) not null,
   active               bool default false,
   primary key (id_user)
);

/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment
(
   id_comment           int not null auto_increment,
   id_post              int not null,
   body                 text not null,
   commenter_name       varchar(32) not null,
   commenter_email      varchar(32) not null,
   date_commented       datetime not null,
   primary key (id_comment)
);

/*==============================================================*/
/* Table: post                                                  */
/*==============================================================*/
create table post
(
   id_post              int not null auto_increment,
   id_user              int not null,
   title                varchar(64) not null,
   excerpt              varchar(512) not null,
   body                 text not null,
   date_posted          date not null,
   published            bool default false,
   slug                 varchar(32) not null,
   primary key (id_post)
);

/*==============================================================*/
/* Table: post_tag                                              */
/*==============================================================*/
create table post_tag
(
   id_tag               int not null,
   id_post              int not null,
   primary key (id_tag, id_post)
);

/*==============================================================*/
/* Table: role                                                  */
/*==============================================================*/
create table role
(
   id_role              int not null auto_increment,
   role_name            varchar(32) not null,
   primary key (id_role)
);

/*==============================================================*/
/* Table: tag                                                   */
/*==============================================================*/
create table tag
(
   id_tag               int not null auto_increment,
   role_name            varchar(32) not null,
   primary key (id_tag)
);

/*==============================================================*/
/* Table: user                                                  */
/*==============================================================*/
create table user
(
   id_user              int not null auto_increment,
   email                varchar(32) not null,
   username             varchar(32) not null,
   password             varchar(256) not null,
   active               bool default false,
   primary key (id_user)
);

/*==============================================================*/
/* Table: user_role                                             */
/*==============================================================*/
create table user_role
(
   id_role              int not null,
   id_user              int not null,
   primary key (id_role, id_user)
);

alter table author add constraint fk_author_user foreign key (id_user)
      references user (id_user) on delete restrict on update restrict;

alter table comment add constraint fk_post_comment foreign key (id_post)
      references post (id_post) on delete restrict on update restrict;

alter table post add constraint fk_post_author foreign key (id_user)
      references author (id_user) on delete restrict on update restrict;

alter table post_tag add constraint fk_post_tag foreign key (id_tag)
      references tag (id_tag) on delete restrict on update restrict;

alter table post_tag add constraint fk_post_tag2 foreign key (id_post)
      references post (id_post) on delete restrict on update restrict;

alter table user_role add constraint fk_user_role foreign key (id_role)
      references role (id_role) on delete restrict on update restrict;

alter table user_role add constraint fk_user_role2 foreign key (id_user)
      references user (id_user) on delete restrict on update restrict;

