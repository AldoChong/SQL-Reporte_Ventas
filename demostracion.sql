-- este es el script de la demostracion de sql. Creamos una base desde cero, la llenamos con los datos y hacemos consultas sobre ella

-- preparamos la base de datos 

drop database if exists demostracion;
create database if not exists demostracion;
use demostracion;

-- creamos las tablas 

create table if not exists direccion(id_direccion smallint unsigned auto_increment, colonia char(100) not null, calle char(100) not null, numero int unsigned not null, primary key(id_direccion));
create table if not exists cliente(id_cliente smallint unsigned auto_increment, nombre char(100) not null, apellido char(100) not null, telefono char(100) not null, correo char(100) not null, edad int not null, id_direccion smallint unsigned not null, primary key(id_cliente));
create table if not exists celular(id_celular smallint unsigned auto_increment, modelo char(100) not null, marca char(100) not null, precio float not null, color char(100) not null, primary key(id_celular));
create table if not exists ticket(id_ticket smallint unsigned auto_increment, id_cliente smallint unsigned not null, id_celular smallint unsigned not null, fecha date not null, primary key(id_ticket));

-- agregamos las llaves foraneas

alter table cliente add constraint fkdireccion foreign key (id_direccion) references direccion(id_direccion);
alter table ticket add constraint fkcliente foreign key (id_cliente) references cliente(id_cliente);
alter table ticket add constraint fkcelular foreign key (id_celular) references celular(id_celular);

-- insertamos los datos 

insert into direccion (colonia, calle, numero) values ('Tlalpan', 'Aba', 67), ('Juarez', 'Tabacalera', 34), ('Tlalpan', 'Moneda', 8), ('Iztapalapa', 'Tecnicos y Manuales', 5), ('Gustavo A. Madero', 'Heroes de Nacozari', 6);
insert into cliente (nombre, apellido, telefono, correo, edad, id_direccion) values ('Aldo', 'Chong', '5548181208', 'aldochong02@gmail.com', 28, 1), ('Lizbeth', 'Luna', '2136547896', 'liz@demostracion.com', 36, 2), ('Charles', 'Sol', '5487963215', 'charles@demostracion.com', 45, 3), ('Juan', 'Camion', '5789641254', 'juan@demostracion.com', 18, 4), ('Omar', 'Mesa', '4512369878', 'omar@demostracion.com', 22, 5);
insert into celular (modelo, marca, precio, color) values ('SFR-T56', 'Xiaomi', 5000, 'negro'), ('FRTU-467', 'Apple', 7000, 'blanco'), ('ROF-325', 'Nokia', 3500, 'azul'), ('TIO-258', 'Xiaomi', 6000, 'blanco'), ('ROP-289', 'Huawei', 4600, 'amarillo'), ('WIO-287', 'Apple', 10000, 'gris');
insert into ticket(id_cliente, id_celular, fecha) values (1,2,'2020-02-23'), (1, 5, '2020-02-23'), (4, 6, '2021-03-16'), (5,3, '2021-03-16'), (2,4,'2021-03-16'), (3,1,'2022-05-20'), (1,4, '2022-05-20'), (4,3,'2022-05-20'), (4,3,'2022-05-20'), (2,6, '2022-05-20'), (5,3, '2019-12-23'), (2,6, '2019-12-23'), (1,3, '2019-12-23'), (4,1, '2019-12-23');

-- Ahora ya tenemos la base de datos. Ahora si podemos empezar a hacer consultas 

-- consulta 1. mostrar marca, modelo y color del celular mas caro

select modelo, marca, color from celular where precio = (select max(precio) from celular);

-- consulta 2. Mostrar toda la informacion de las direcciones tales que su calle empieze con la letra T

select * from direccion where calle like 'T%';

-- consulta 3. Mostrar nombre, edad del cliente y marca, precio, color  del celular comprados el dia '2019-12-23'

select nombre, edad, marca, precio, color from ticket join celular using(id_celular) join cliente using(id_cliente) where fecha = '2019-12-23';

-- consulta 4. mostrar el total de ventas del dia 2022-05-20

select sum(precio) from ticket join celular using(id_celular) where fecha = '2022-05-20';

-- consulta 5. mostrar el dia, nombre y colonia del cliente de la compra del celular mas caro

select fecha, nombre, colonia from ticket join celular using(id_celular) join cliente using(id_cliente) join direccion using(id_direccion) where precio = (select max(precio) from celular);

