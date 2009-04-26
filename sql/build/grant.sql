drop role if exists eve_admin;
create role eve_admin with superuser nologin;

drop role if exists eve; 
create role eve;

drop role if exists eve_readonly;
create role eve_readonly;
