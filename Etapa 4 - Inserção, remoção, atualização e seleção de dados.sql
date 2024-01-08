/* CREATE */

create table cliente (
	cpfCliente varchar(14) primary key,
	nomeCliente text,
	dataNas date
);

create table endereco (
	cpfCliente varchar(14) primary key,
	cidade text,
	bairro text,
	rua text,
	numeroEnd int
);

create table telefoneCliente (
	cpfCliente varchar(14),
	numeroTel varchar(15),
	primary key(cpfCliente, numeroTel)
);

create table pedido (
	idPedido int primary key,
	valorPedido decimal,
	quantPedido int,
	dataPedido date,
	cpfCliente varchar(14) references cliente(cpfCliente)
);

create table vendedor (
	rgVendedor varchar(14) primary key,
	nomeVendedor text,
	emailVendedor text
);

create table emitirPedido (
	rgVendedor varchar(14) references vendedor(rgVendedor),
	idPedido int references pedido(idPedido),
	primary key(rgVendedor, idPedido)
);

create table produto (
	idProduto int primary key,
	valorProduto decimal
);

create table contem (
	idPedido int references pedido(idPedido),
	idProduto int references produto(idProduto),
	primary key(idPedido, idProduto)
);

create table fornecedor (
	cnpj varchar(20) primary key,
	dataEntrega date
);

create table disponibilizarProduto (
	cnpj varchar(20) references fornecedor(cnpj),
	idProduto int references produto(idProduto),
	primary key(cnpj, idProduto)
);

/* INSERT */

insert into cliente (cpfCliente, nomeCliente, dataNas)
values ('123.654.789-40', 'Felipe Morais', '1993-10-02'),
	   ('134.987.546-25', 'Ana Maria', '1980-03-21'),
	   ('190.876.345-53', 'João Paulo', '1991-12-04')
	   
insert into endereco (cpfCliente, cidade, bairro, rua, numeroEnd)
values ('123.654.789-40', 'Parelhas-RN', 'Centro', 'Rua Primeira', 24),
	   ('134.987.546-25', 'Currais Novos-RN', 'Centro', 'Rua Segunda', 257),
	   ('190.876.345-53', 'Monteiro-PB', 'Centro', 'Rua Terceira', 171)
	   
insert into telefoneCliente (cpfCliente, numeroTel)
values ('123.654.789-40', '(84) 98768-9871'),
       ('134.987.546-25', '(84) 98621-8924'),
	   ('190.876.345-53', '(83) 99756-2476')

insert into pedido (idPedido, valorPedido, quantPedido, dataPedido, cpfCliente)
values (1, 120.00, 1, '2023-09-12', '123.654.789-40'),
       (2, 456.90, 1, '2023-11-23', '134.987.546-25'),
	   (3, 3365, 1, '2024-01-02', '190.876.345-53')
	   
insert into vendedor (rgVendedor, nomeVendedor, emailVendedor)
values ('12.345.678-9', 'Lucas Oliveira', 'lucasolv@gmail.com'),
       ('14.876.235-3', 'Junior da Silva', 'juniordasilva@gmail.com')
	   
insert into emitirPedido (rgVendedor, idPedido)
values ('12.345.678-9', 1),
       ('12.345.678-9', 2),
	   ('14.876.235-3', 3),
	   
insert into produto (idProduto, valorProduto)
values (1, 120.00),
       (2, 456.90),
	   (3, 3365)

insert into contem (idPedido, idProduto)
values (1, 1),
       (2, 2),
	   (3, 3)
	   
insert into fornecedor (cnpj, dataEntrega)
values ('12.345.678/0001-00', '2023-12-27'),
       ('23.661.798/0001-30', '2023-12-30')
	   
insert into disponibilizarProduto (cnpj, idProduto)
values ('12.345.678/0001-00', 1),
       ('12.345.678/0001-00', 2),
	   ('23.661.798/0001-30', 3)
	   

/* UPDATE */	  

/* Atualização de um único campo */
update cliente
set dataNas = '2005-05-05'
where cpfCliente = '134.987.546-25';

update vendedor
set emailVendedor = 'juniorsilvacavalc@gmail.com'
where rgVendedor = '14.876.235-3';

update fornecedor
set dataEntrega = '2024-01-06'
where cnpj = '12.345.678/0001-00';


/* Atualização de mais de um campo de uma só vez */
update endereco 
set cidade = 'Jardim do Serido-RN', bairro = 'Bela Vista', rua = 'Rua Segunda', numeroEnd = 25
where cpfCliente = '123.654.789-40';

update pedido 
set valorPedido = 100.00, quantPedido = 2
where idPedido = 1;


/* DELETE */

/* Apagando uma linha da tabela */
delete from disponibilizarProduto
where idProduto = 3

/* Apagando mais de uma linha da tabela */
delete from emitirPedido
where idPedido in(2,3)
returning *;

/* Apagar todos os registros da tabela */
delete from cliente


/* SELECT */

/* Selecionando linhas da tabela CLIENTE, onde o nome começa com a letra F */
select nomeCliente
from cliente
where nomeCliente ILIKE 'f%'

/* Selecionando linha completa da tabela ENDEREÇO, onde o número do endereço corresponde a 257 */
select cpfCliente, cidade, bairro, rua, numeroEnd
from endereco
where numeroEnd = 257

/* Selecionando valores maiores do que R$120,00 da tabela PRODUTO */
select idProduto, valorProduto
from produto
where valorProduto > 120

/* Selecionando um determinado cliente da tabela CLIENTE que nasceu em uma data específica */
select cpfCliente, nomeCliente, dataNas
from cliente
where dataNas = '1991-12-04'