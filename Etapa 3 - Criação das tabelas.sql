create table aat.cliente (
	cpfCliente varchar(14) primary key,
	nomeCliente text,
	dataNas date
);

create table aat.endereco (
	cpfCliente varchar(14) primary key,
	cidade text,
	bairro text,
	rua text,
	numeroEnd int
);

create table aat.telefoneCliente (
	cpfCliente varchar(14),
	numeroTel varchar(15),
	primary key(cpfCliente, numeroTel)
);

create table aat.pedido (
	idPedido int primary key,
	valorPedido decimal,
	quantPedido int,
	dataPedido date,
	cpfCliente varchar(14) references aat.cliente(cpfCliente)
);

create table aat.vendedor (
	rgVendedor varchar(14) primary key,
	nomeVendedor text,
	emailVendedor text
);

create table aat.emitirPedido (
	rgVendedor varchar(14) references aat.vendedor(rgVendedor),
	idPedido int references aat.pedido(idPedido),
	primary key(rgVendedor, idPedido)
);

create table aat.produto (
	idProduto int primary key,
	valorProduto decimal
);

create table aat.contem (
	idPedido int references aat.pedido(idPedido),
	idProduto int references aat.produto(idProduto),
	primary key(idPedido, idProduto)
);

create table aat.fornecedor (
	cnpj varchar(20) primary key,
	dataEntrega date
);

create table aat.disponibilizarProduto (
	cnpj varchar(20) references aat.fornecedor(cnpj),
	idProduto int references aat.produto(idProduto),
	primary key(cnpj, idProduto)
);