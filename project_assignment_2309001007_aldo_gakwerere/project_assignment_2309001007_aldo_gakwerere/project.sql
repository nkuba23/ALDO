create database CarRental_management_system;

use CarRental_management_system;

-- creation of vehicle table
create table vehicles(
vehicle_id  int primary key,
manufacture varchar(20),
model varchar(20),
year int
);

-- creation of customer table

create table customers(
customer_id int primary key,
fname varchar(20),
lname varchar(20),
email varchar(20),
phone varchar (10),
address varchar(20)
);

-- creation of reservation

create table reservations(
reservation_id int primary key,
customer_id int,
vehicle_id int,
startdate date,
enddate date,
foreign key (customer_id) references customers(customer_id),
foreign key (vehicle_id) references  vehicles(vehicle_id));

-- creation of payment table

create table payments(
payment_id int primary key,
reservation_id int,
amount varchar(20),
paymentdate DATE,
paymentmethod varchar(20),
foreign key (reservation_id) references reservations(reservation_id)
);

insert into vehicles values
(7,'fuso','super grate',2021),
(8,'kia','civic',2021),
(9,'benz','escape',2000);

insert into customers values
(22,'aldo','Gakwerere','gakwererealdo@gmail.com','078987978','kibungo'),
(23,'aldo','Gakwerere','pazzo@gmail.com','078987978','bugesera'),
(24,'aldo','Gakwerere','emmy@gmail.com','078987978','kibungo'),
(27,'aldo','Gakwerere','fisto@gmail.com','078987978','kigali'),
(26,'wer','Gakwerere','shema@gmail.com','078987978','nyagasozi');



insert into reservations values
(17,1,1,'2025-09-01','2025-09-10'),
(18,2,2,'2025-03-08','2025-03-14'),
(19,3,3,'2025-07-11','2025-07-20'),
(20,4,4,'2025-09-01','2025-09-20'),
(21,5,5,'2025-09-01','2025-09-30');

insert into payments values
(10,1,'20000','2025-09-01','cash'),
(11,2,'50000','2025-09-01','credit card'),
(12,3,'100000','2025-09-01','cash'),
(14,4,'60000','2025-09-01','cash'),
(15,5,'200000','2025-09-01','credit card');

select * from vehicles;
select * from customers;
select *from reservations;
select * from payments; 

-- making update

update customers set fname='boyi' where customer_id=1;
update vehicles set manufacture='voiture' where vehicle_id=4;
update reservations set startdate ='2025-09-04' where reservation_id=1;
update payments set paymentmethod ='mobile money' where payment_id=1;

-- make delete

delete from vehicles where vehicle_id=7;
delete from customers where customer_id=12;
delete from payments where payment_id=13;
delete from reservations where reservation_id=19;

-- how to make view

create view mama as select*from vehicles where vehicle_id=9;
select* from mama;

create view pazzo as select*from payments where payment_id=12;
select* from pazzo;

create view emmy as select fname from customers where fname='aldo';
select* from emmy;

create view fera as select* from reservations where reservation_id=18;
select* from fera;

create view mere as select * from payments where payment_id=15;
select * from mere;

create view pere as select* from customers where customer_id=26;
select * from pere;

--  average
select avg(amount)as averageamount from payments;

-- sum

select sum(amount) as sumamount from payments;

-- create procedure
delimiter $$
create procedure gakwererek( in id int,in modeli varchar(20),in yar int ,in manufacturepam varchar(20))
begin
insert into vehicles values(id,modeli,yar,manufacturepam);
end $$
delimiter ;
call gakwererek(8,'kia','civic',2021);

delimiter $$
create procedure gakwerereka(in modeli varchar(20),in id int)
begin
update vehicles set model=modeli where vehicle_id=id;
end $$
delimiter ;

call gakwerereka('esca',9);

delimiter $$
create procedure gakwerera(in fnamek varchar(20),in id int)
begin
update customers set fname=fnamek where customer_id=id;
end $$
delimiter ;
call gakwerera('serire',26);

delimiter $$
create procedure aldomur(in amounteni varchar(20))
begin
select * from payments where amount=amounteni;
end $$
delimiter ;
call aldomur(20000);

delimiter $$
create procedure aldomura(in id int)
begin
delete from reservations where reservation_id=id;
end $$
delimiter ;
call aldomura(18);


delimiter $$
create procedure aldomuraa(in id int)
begin
delete from reservations where reservation_id=id;
end $$
delimiter ;
call aldomuraa(17);

delimiter $$
create procedure aldomuraa(in id int)
begin
delete from reservations where reservation_id=id;
end $$
delimiter ;

-- triggers

create table vehicle_counters(c_name varchar(30) primary key, count int);
insert into vehicle_counters(c_name,count) values("numberofvehicle",0);
select * from vehicle_counters;

DELIMITER $$
CREATE TRIGGER vehicleafterinserts AFTER INSERT ON vehicles FOR EACH ROW
BEGIN
UPDATE vehicle_counters SET count = count + 1 WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER vehicleafterdelete AFTER DELETE ON vehicles FOR EACH ROW
BEGIN
UPDATE vehicle_counters SET count = count - 1 WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER vehicleafterupdate AFTER UPDATE ON vehicles FOR EACH ROW
BEGIN
UPDATE vehicle_counters SET count = count WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

create table customer_counters(c_name varchar(30) primary key, count int);
insert into customer_counters(c_name,count) values("numberofvehicle",0);
select * from customer_counters;



DELIMITER $$
CREATE TRIGGER customerafterinserts AFTER INSERT ON customers FOR EACH ROW
BEGIN
UPDATE customer_counters SET count = count + 1 WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER customerafterdelete AFTER DELETE ON customers FOR EACH ROW
BEGIN
UPDATE customer_counters SET count = count - 1 WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER customerafterupdate AFTER UPDATE ON customers FOR EACH ROW
BEGIN
UPDATE customer_counters SET count = count WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER customerafterdelete AFTER DELETE ON customers FOR EACH ROW
BEGIN
UPDATE customer_counters SET count = count - 1 WHERE c_name="numberofvehicle";
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER customerafterupdate AFTER UPDATE ON customers FOR EACH ROW
BEGIN
UPDATE customer_counters SET count = count WHERE c_name="numberofvehicle";
END $$
DELIMITER ;
