CREATE TABLE If not Exists Users (user_id INT, email VARCHAR(255));
Truncate table Users;
insert into Users (user_id, email) values ('1', 'alice@example.com');
insert into Users (user_id, email) values ('2', 'bob_at_example.com');
insert into Users (user_id, email) values ('3', 'charlie@example.net');
insert into Users (user_id, email) values ('4', 'david@domain.com');
insert into Users (user_id, email) values ('5', 'eve@invalid');
