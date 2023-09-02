-- Criação do banco de dados para o cenário de E-commerce

create database ecommerce;
use ecommerce;

-- criar tabela cliente

create table clients(
	idClient int auto_increment primary key,
    primeiroNome varchar(15),
    Minit char(3),
    ultimoNome varchar (20),
    CPF char (11) not null,
    Address varchar (30),
    constraint unique_cpf_client unique (CPF)
);

-- criar tabela produto
create table Produto(
	idProduto int auto_increment primary key,
    Pname varchar(10),
    classification_kids bool default false,
    category enum( 'Eletrônico','Vestuário','Alimentos','Moveis' ) not null,
    avaliacao float default 0,
    size varchar(12)
);

create table payments(
	idClient int,
    idpayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key (idClient, idpayment)
);
-- criar tabela pedido

create table Pedido(
	idOrders int auto_increment primary key,
	idOrderClient int,
    orderStatus enum('Em andamento','Cancelado','Confirmado') default ('Em processamento'),
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash bool default false,
    constraint fk_orders_client foreign key (idOrderClient) references Clients(idClient)
);

-- criar tabela estoque

create table Estoque(
	idEstoque int auto_increment primary key,
	lovalEstoque varchar(200) not null,
    quantidade int default 0
);

-- criar tabela fornecedores

create table Fornecedores(
	idFornecedor int auto_increment primary key,
	razaoSocial varchar(200) not null,
    endereco varchar (20) not null,
    CNPJ char(15) not null,
    contato char(11) not null,
    constraint unique_fornecedor unique(CNPJ)
);


-- criar tabela vendedor

create table Vendedor(
	idVendedor int auto_increment primary key,
	nomeSocial varchar(255) not null,
    CNPJ char(13),
    CPF char(9),
    localização varchar(255),
    contato char(11) not null,
    constraint unique_cnpj_vendedor unique (CNPJ),
    constraint unique_cpf_vendedor unique (CPF)
);

create table Produtos_Vendedor(
	idPseller int,
    idProduto int,
    prodQuantidade int not null,
    primary key (idPseller,idProduto),
    constraint fk_produtos_vendedor foreign key (idPseller) references vendedor(idVendedor),
	constraint fk_produtos_produto foreign key (idProduto) references produto(idProduto)
);

create table Produtos_Pedido(
	idPProduto int,
    idPOrder int,
    ppQuantidade int default 1,
    ppStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key (idPProduto, idPOrder),
    constraint fk_produtos_produtos_vendedor foreign key (idPProduto) references produto(idProduto),
	constraint fk_produtos_produtos foreign key (idPOrder) references pedido(idOrders)
);

create table localização(
	idLproduct int,
    idLstorage int,
    location varchar (255) not null,
    primary key (idLproduct,idLstorage),
    constraint fk_localização_produto foreign key (idLproduct) references produto(idProduto),
	constraint fk_localização_Estoque foreign key (idLstorage) references Estoque(idEstoque)
);

-- Persistindo e recuperando dados a partir de consultas

insert into Clients (primeiroNome,Minit,ultimoNome,CPF,Address)
	values('Carlos','S.','Nascimento',12334,'Rua Piracicaba'),
		  ('Maria','B','Fernandes',876658,'Rua Pajos'),
          ('Vinicius','G','Brandão',66558,'Avenida Osmar Quintera '),
          ('Ciliane','T','Neves', 267932, 'Rua Presidente Sol');

insert into Produto (Pname,classification_kids,category,avaliacao,size) values
					
                    ('Notebook',false,'Eletronico',4,null),
                    ('camiseta',true,'Vestuário',3,null),
                    ('Armario',false,'Moveis',4, '3x2x5'),
                    ('Chaleira',false,'Eletronico',4,null);
          
alter table clients auto_increment = 1;



