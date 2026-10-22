USE MASTER
GO

IF EXISTS(SELECT * FROM SYS.sysdatabases 
            WHERE name='BDBANCOS2025')
begin
    ALTER DATABASE BDBANCOS2025
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE
    
	DROP DATABASE BDBANCOS2025
end
go

CREATE DATABASE BDBANCOS2025
COLLATE Modern_Spanish_CI_AI
GO

USE BDBANCOS2025
GO

SET DATEFORMAT DMY
SET LANGUAGE SPANISH
GO

-- Creacion de las Tablas
CREATE TABLE Clientes (
	cli_codigo char (5) NOT NULL Primary Key ,
	cli_nombre varchar (50) NULL ,
	cli_telefono varchar(10) NULL ,
	cli_ruc char(11) NULL ,
	cli_direccion varchar (60) NULL )
GO

CREATE TABLE Tipo_Cuentas (
	cod_cta char (3) NOT NULL Primary Key,
	desc_cta varchar(30) NULL,
    moneda char(1)
)
GO

CREATE TABLE Cuentas (
    num_cta char (12) NOT NULL Primary Key,
	cli_codigo char (5) NOT NULL references Clientes,
	cod_cta char (3) NOT NULL references Tipo_Cuentas,
	saldo decimal(10,2) NULL 
)
GO


CREATE TABLE Movimientos (
    num_mov		int IDENTITY(1,1) NOT NULL Primary Key,
	num_cta		char (12) NOT NULL references Cuentas,
	fecha		datetime NULL,
	tip_mov		char(1) NULL ,
	saldo_ant	numeric(10,2) NULL, 
	monto		numeric(10,2) NULL,
	saldo_nue	numeric(10,2) NULL
)
GO

SET DATEFORMAT DMY
GO
SET LANGUAGE SPANISH
GO
-- Ingreso de Data a las Tablas

INSERT INTO clientes VALUES ('C0001','LAURA MORENO LEE','1234567','54336725321','Av. La Marina 1234')
INSERT INTO clientes VALUES ('C0002','ALEJANDRO MORENO','6584503','56325236234','Av. Pardo 456     ')
INSERT INTO clientes VALUES ('C0003','CLAUDIA LEE TORRES','5674566','67836768957','Av. Principal 123 ')
INSERT INTO clientes VALUES ('C0004','JUAN CASTA�EDA BLAS','5524453','38532523450','La Perla Callao')
INSERT INTO clientes VALUES ('C0005','PERCY OBANDO RUIZ','6789453','34532523458','Calle San Pedro 134')
INSERT INTO clientes VALUES ('C0006','LUCIA FERNANDEZ VIDAL','5632263','63568333525','Calle Ruise�ores 122')
INSERT INTO clientes VALUES ('C0007','MIGUEL NARVA TORRES','5678356','45622462572','Jr. Naranjos 5689')
INSERT INTO clientes VALUES ('C0008','CLAUDIO ROQUE PARDO','7894568','56632545357','Av. Habich 543    ')
INSERT INTO clientes VALUES ('C0009','MONICA SANCHEZ GONZALES','7894073','67233674566','Av. Iquitos 228   ')
INSERT INTO clientes VALUES ('C0010','FREDDY VERGARA MORI','6111345','14111351435','Calle Inquisidores 422')
INSERT INTO clientes VALUES ('C0011','JHON MORALES ROSALES','7685704','64223253459','Calle Cueva 432   ')
INSERT INTO clientes VALUES ('C0012','FERNANDO REDONDO VELASQUEZ','6789456','24623325742','Av. Javier Prado 114')
INSERT INTO clientes VALUES ('C0013','GABRIELA ZAPATA MARTIN','5678466','72313254560','Jr. Pio XII 112   ')
INSERT INTO clientes VALUES ('C0014','MELISSA PAICO ALVARADO','1189453','66325234580','Lizardo Montero 340')
INSERT INTO clientes VALUES ('C0015','SANDRA CAMPOS DAVILA','4563457','67362577361','Jr. Dominico 554')
INSERT INTO clientes VALUES ('C0016','MIGUEL RAMIREZ VASQUEZ','7460647','45632573556','Jr. Salavery 876  ')
INSERT INTO clientes VALUES ('C0017','RAUL MORIENTES PE�A','8975783','65362533671','Av. Habich 4567   ')
INSERT INTO clientes VALUES ('C0018','JHONATAN PE�ARAN CHAVEZ','9442752','62243632567','Av. La Molina 4256')
INSERT INTO clientes VALUES ('C0019','EUGENIO CAMPOS PERALTA','9583569','54673356250','Av. Wilson 678    ')
INSERT INTO clientes VALUES ('C0020','LUCILA PARDO ZARATE','6546534','53476250977','Av. Pardo 567     ')
INSERT INTO clientes VALUES ('C0021','ROBERTO BAGGIO MEDINA','2678958','87662554325','Av. Wilson 1267   ')
INSERT INTO clientes VALUES ('C0022','CESAR HUAMAN JERI','8975783','65362533671','Av. Habich 4567   ')
INSERT INTO clientes VALUES ('C0023','JIMMY CORTEZ AVILA','9442752','62243632567','Av. La Molina 4256')
INSERT INTO clientes VALUES ('C0024','JORGE DIAZ GARCIA','9583569','54673356250','Av. Wilson 678    ')
INSERT INTO clientes VALUES ('C0025','VICTOR RIOS SORIA','6546534','53476250977','Av. Pardo 567     ')
INSERT INTO clientes VALUES ('C0026','ENRIQUE LAZO CAMACHO','2678958','87662554325','Av. Wilson 1267   ')
GO

/*
select distinct cli_codigo from Cuentas 
where cli_codigo not in (select cli_codigo from clientes)
go
*/

INSERT Tipo_Cuentas VALUES('C01','CTA AHORROS SOLES','S')
INSERT Tipo_Cuentas VALUES('C02','CTA AHORROS DOLARES','D')
INSERT Tipo_Cuentas VALUES('C03','CTA CORRIENTE SOLES','S')
INSERT Tipo_Cuentas VALUES('C04','CTA CORRIENTE DOLARES','D')
INSERT Tipo_Cuentas VALUES('C05','CTS SOLES','S')
INSERT Tipo_Cuentas VALUES('C06','CTS DOLARES','D')
INSERT Tipo_Cuentas VALUES('C07','DEPOSITO A PLAZO FIJO SOLES','S')
INSERT Tipo_Cuentas VALUES('C08','DEPOSITO A PLAZO FIJO DOLARES','D')
INSERT Tipo_Cuentas VALUES('C09','CTA MAESTRA SOLES','S')
INSERT Tipo_Cuentas VALUES('C10','CTA MAESTRA DOLARES','D')
INSERT Tipo_Cuentas VALUES('C11','FONDOS MUTUOS SOLES','S')
INSERT Tipo_Cuentas VALUES('C12','FONDOS MUTUOS DOLARES','D')
GO

-- Cta Ahorros   S/. = 191 C01
-- Cta Ahorros   $   = 192 C02
-- Cta Corriente S/. = 193 C03
-- Cta Corriente $   = 194 C04
-- CTS           S/. = 195 C05
-- CTS           $   = 196 C06
-- Plazo Fijo    S/. = 197 C07
-- Plazo Fijo    $   = 198 C08

-- MAESTRA       S/. = 199 C09
-- MAESTRA       $   = 200 C10
-- FONDOS MUTUOS S/. = 201 C11
-- FONDOS MUTUOS $   = 202 C12

INSERT Cuentas values('191-12507-09','C0001','C01',100)
INSERT Cuentas values('191-10521-19','C0001','C01',1000)
INSERT Cuentas values('192-18531-00','C0002','C02',400)
INSERT Cuentas values('196-12137-02','C0002','C06',1500)
INSERT Cuentas values('193-13822-01','C0003','C03',2100)
INSERT Cuentas values('196-19252-01','C0003','C06',1950)
INSERT Cuentas values('192-13054-00','C0004','C02',900)
INSERT Cuentas values('191-19395-02','C0005','C01',400)
INSERT Cuentas values('196-16518-00','C0006','C06',1700)
INSERT Cuentas values('191-18912-08','C0007','C01',410)
INSERT Cuentas values('196-19896-09','C0007','C06',125)
INSERT Cuentas values('194-19141-18','C0007','C04',250)
-- NEW
INSERT Cuentas values('195-11223-08','C0015','C05',520)
INSERT Cuentas values('195-11122-09','C0008','C05',1185)
INSERT Cuentas values('196-11112-18','C0017','C06',950)
INSERT Cuentas values('196-11111-08','C0008','C06',1060)
INSERT Cuentas values('197-22334-09','C0011','C07',1285)
INSERT Cuentas values('197-22233-18','C0012','C07',850)
INSERT Cuentas values('198-22223-08','C0010','C08',1410)
INSERT Cuentas values('198-33445-09','C0007','C08',1025)
INSERT Cuentas values('199-33344-18','C0018','C09',1050)
INSERT Cuentas values('199-33334-08','C0020','C09',900)
INSERT Cuentas values('199-44556-09','C0021','C09',1350)
INSERT Cuentas values('200-44455-18','C0010','C10',1650)
INSERT Cuentas values('200-44445-08','C0009','C10',1950)
INSERT Cuentas values('200-55667-09','C0007','C10',1100)
INSERT Cuentas values('201-55566-18','C0014','C11',900)
INSERT Cuentas values('201-66778-08','C0007','C11',700)
INSERT Cuentas values('202-66677-09','C0018','C12',300)
INSERT Cuentas values('202-77889-18','C0009','C12',930)
GO

-- NEW
INSERT Cuentas values('191-18100-03','C0005','C01',600)
INSERT Cuentas values('191-18611-09','C0014','C01',400)
INSERT Cuentas values('191-18946-08','C0022','C01',800)
GO

-- Insertando los movimientos de las cuentas
INSERT Movimientos values('191-12507-09','01/01/2017','D',0,100,100)
-- (num_cta,fecha,tip_mov,saldo_ant,monto,saldo_nue)
INSERT Movimientos values('191-10521-19','01/01/2017','D',0,200,200)
INSERT Movimientos values('192-18531-00','04/05/2017','D',0,100,100)
INSERT Movimientos values('196-12137-02','05/05/2017','D',0,500,500)
INSERT Movimientos values('193-13822-01','10/01/2018','D',0,400,400)
INSERT Movimientos values('196-19252-01','12/02/2018','D',0,500,500)
INSERT Movimientos values('192-13054-00','14/04/2019','D',0,200,200)
INSERT Movimientos values('191-19395-02','08/01/2019','D',0,140,140)
INSERT Movimientos values('196-16518-00','05/02/2019','D',0,520,520)
INSERT Movimientos values('191-18912-08','10/05/2019','D',0,410,410)
INSERT Movimientos values('196-19896-09','09/06/2019','D',0,125,125)
INSERT Movimientos values('194-19141-18','17/07/2019','D',0,250,250)
INSERT Movimientos values('191-10521-19','04/09/2017','D',200,200,400)
INSERT Movimientos values('191-10521-19','11/10/2017','D',400,300,700)
INSERT Movimientos values('191-10521-19','17/11/2017','D',700,200,900)

INSERT Movimientos values('191-18912-08','19/06/2019','D',410,500,910)
INSERT Movimientos values('191-18912-08','21/07/2019','D',910,290,1200)
INSERT Movimientos values('191-18912-08','10/08/2019','R',1200,400,800)
INSERT Movimientos values('191-18912-08','30/08/2019','D',800,600,1400)
INSERT Movimientos values('191-18912-08','04/12/2019','R',1400,400,1000)
INSERT Movimientos values('191-18912-08','30/12/2019','D',1000,250,750)
INSERT Movimientos values('191-18912-08','10/01/2020','R',750,340,410)

INSERT Movimientos values('191-10521-19','01/01/2019','D',900,500,1400)
INSERT Movimientos values('191-10521-19','05/03/2019','R',1400,400,1000)
INSERT Movimientos values('192-18531-00','10/05/2017','D',100,400,500)
INSERT Movimientos values('192-18531-00','24/11/2017','D',500,100,600)
INSERT Movimientos values('192-18531-00','12/03/2018','D',600,500,1100)
INSERT Movimientos values('192-18531-00','28/03/2018','R',1100,700,400)
INSERT Movimientos values('196-12137-02','09/05/2017','D',500,500,1000)
INSERT Movimientos values('196-12137-02','25/07/2017','R',1000,300,700)
INSERT Movimientos values('196-12137-02','02/08/2018','D',700,500,1200)
INSERT Movimientos values('196-12137-02','18/09/2019','D',1200,800,2018)
INSERT Movimientos values('196-12137-02','21/10/2019','R',2018,500,1500)


INSERT Movimientos values('193-13822-01','13/01/2018','D',400,200,600)
INSERT Movimientos values('193-13822-01','20/05/2018','D',600,400,1000)
INSERT Movimientos values('193-13822-01','30/12/2018','D',1000,700,1700)
INSERT Movimientos values('193-13822-01','10/06/2019','D',1700,400,2100)
INSERT Movimientos values('196-19252-01','14/02/2018','D',500,500,1000)
INSERT Movimientos values('196-19252-01','12/04/2018','D',1000,350,1350)
INSERT Movimientos values('196-19252-01','22/10/2018','D',1350,500,1850)
INSERT Movimientos values('196-19252-01','01/04/2019','R',1850,200,1650)
INSERT Movimientos values('196-19252-01','17/02/2020','R',1650,500,1150)
INSERT Movimientos values('196-19252-01','12/05/2020','D',1150,800,1950)

INSERT Movimientos values('192-13054-00','15/04/2019','D',200,200,400)
INSERT Movimientos values('192-13054-00','10/09/2019','D',400,700,1100)
INSERT Movimientos values('192-13054-00','27/02/2020','D',1100,400,1500)
INSERT Movimientos values('192-13054-00','14/10/2020','R',1500,600,900)
INSERT Movimientos values('191-19395-02','14/01/2019','D',140,300,440)
INSERT Movimientos values('191-19395-02','28/04/2019','D',440,400,840)
INSERT Movimientos values('191-19395-02','18/10/2019','R',840,140,700)
INSERT Movimientos values('191-19395-02','08/03/2021','R',700,300,400)
INSERT Movimientos values('196-16518-00','15/02/2019','D',520,500,1020)
INSERT Movimientos values('196-16518-00','27/12/2019','D',1020,580,1600)
INSERT Movimientos values('196-16518-00','04/08/2020','D',1600,800,2400)
INSERT Movimientos values('196-16518-00','17/11/2020','R',2400,700,1700)
GO


INSERT Movimientos values('195-11223-08','11/01/2020','D',0,210,210)
INSERT Movimientos values('195-11122-09','12/01/2020','D',0,185,185)
INSERT Movimientos values('196-11112-18','14/01/2020','D',0,250,250)
INSERT Movimientos values('196-11111-08','18/01/2020','D',0,400,400)
INSERT Movimientos values('197-22334-09','21/01/2020','D',0,500,500)

INSERT Movimientos values('197-22233-18','15/02/2020','D',0,250,250)
INSERT Movimientos values('198-22223-08','23/02/2020','D',0,410,410)
INSERT Movimientos values('198-33445-09','01/03/2020','D',0,125,125)
INSERT Movimientos values('199-33344-18','11/03/2020','D',0,250,250)
INSERT Movimientos values('199-33334-08','31/03/2020','D',0,600,600)

INSERT Movimientos values('199-44556-09','01/04/2020','D',0,150,150)
INSERT Movimientos values('200-44455-18','02/04/2020','D',0,275,275)
INSERT Movimientos values('200-44445-08','01/05/2020','D',0,410,410)
INSERT Movimientos values('200-55667-09','05/05/2020','D',0,200,200)
INSERT Movimientos values('201-55566-18','01/06/2020','D',0,250,250)
INSERT Movimientos values('201-66778-08','07/06/2020','D',0,460,460)
INSERT Movimientos values('202-66677-09','01/07/2020','D',0,100,100)
INSERT Movimientos values('202-77889-18','09/07/2020','D',0,250,250)

--
-- NEW
--
INSERT Movimientos values('191-18100-03','01/01/2017','D',0,500,500)
INSERT Movimientos values('191-18611-09','01/01/2017','D',0,400,400)
INSERT Movimientos values('191-18946-08','01/01/2017','D',0,800,800)
INSERT Movimientos values('191-18100-03','01/01/2017','D',500,100,600)

INSERT Movimientos values('191-18611-09','01/01/2017','D',400,400,800)
INSERT Movimientos values('191-18611-09','18/01/2017','D',800,700,1500)
INSERT Movimientos values('191-18611-09','31/01/2017','R',1500,400,1100)
INSERT Movimientos values('191-18611-09','05/02/2017','D',1100,200,900)
INSERT Movimientos values('191-18611-09','01/03/2017','R',900,400,500)
INSERT Movimientos values('191-18611-09','05/02/2017','D',500,200,700)
INSERT Movimientos values('191-18611-09','01/03/2017','R',700,300,400)

INSERT Movimientos values('195-11223-08','01/01/2021','D',210,110,320)
-- (num_cta,fecha,tip_mov,saldo_ant,monto,saldo_nue)
INSERT Movimientos values('191-18100-03','08/01/2017','D',600,400,1000)
INSERT Movimientos values('191-18100-03','23/02/2017','R',1000,600,400)
INSERT Movimientos values('191-18100-03','12/03/2017','D',400,200,600)

INSERT Movimientos values('195-11223-08','01/01/2021','D',320,200,520)
INSERT Movimientos values('195-11122-09','04/05/2021','D',185,100,285)
INSERT Movimientos values('195-11122-09','05/05/2021','D',285,500,785)
INSERT Movimientos values('195-11122-09','10/01/2021','D',785,400,1185)

INSERT Movimientos values('191-18946-08','24/01/2017','D',800,300,1100)
INSERT Movimientos values('191-18946-08','14/02/2017','R',1100,200,900)
INSERT Movimientos values('191-18946-08','05/04/2017','D',900,300,1200)
INSERT Movimientos values('191-18946-08','21/06/2017','R',1200,500,600)
INSERT Movimientos values('191-18946-08','05/08/2017','D',600,200,800)

INSERT Movimientos values('196-11112-18','12/02/2021','D',250,500,750)
INSERT Movimientos values('196-11112-18','14/04/2021','D',750,200,950)
INSERT Movimientos values('196-11111-08','08/01/2021','D',400,140,540)
INSERT Movimientos values('196-11111-08','05/02/2021','D',540,520,1060)
INSERT Movimientos values('197-22334-09','10/05/2021','D',500,410,910)
INSERT Movimientos values('197-22334-09','09/06/2021','D',910,125,1035)
INSERT Movimientos values('197-22334-09','17/07/2021','D',1035,250,1285)

INSERT Movimientos values('197-22233-18','17/01/2022','D',250,200,450)
INSERT Movimientos values('197-22233-18','11/10/2022','D',450,300,750)
INSERT Movimientos values('197-22233-18','01/01/2022','D',750,500,1250)
INSERT Movimientos values('197-22233-18','05/03/2022','R',1250,400,850)
INSERT Movimientos values('198-22223-08','10/05/2022','D',410,400,810)
INSERT Movimientos values('198-22223-08','24/11/2022','D',810,100,910)
INSERT Movimientos values('198-22223-08','12/03/2022','D',910,500,1410)

INSERT Movimientos values('198-33445-09','28/03/2022','D',125,700,825)
INSERT Movimientos values('198-33445-09','09/05/2022','D',825,500,1325)
INSERT Movimientos values('198-33445-09','25/07/2022','R',1325,300,1025)
INSERT Movimientos values('199-33344-18','02/08/2022','D',250,500,750)
INSERT Movimientos values('199-33344-18','18/09/2022','D',750,800,1550)
INSERT Movimientos values('199-33344-18','21/10/2022','R',1550,500,1050)
INSERT Movimientos values('199-33334-08','13/01/2022','D',600,200,800)
INSERT Movimientos values('199-33334-08','20/05/2022','D',800,400,1200)
INSERT Movimientos values('199-33334-08','10/06/2022','D',1900,400,2300)
INSERT Movimientos values('199-33334-08','30/12/2022','R',2300,700,1600)

INSERT Movimientos values('199-44556-09','10/01/2023','D',150,350,500)
INSERT Movimientos values('199-44556-09','14/02/2023','D',500,500,1000)
INSERT Movimientos values('199-44556-09','12/04/2023','D',1000,350,1350)

INSERT Movimientos values('200-44455-18','08/02/2023','D',275,525,800)
INSERT Movimientos values('200-44455-18','17/02/2023','D',800,550,1350)
INSERT Movimientos values('200-44455-18','22/02/2023','D',1350,500,1850)
INSERT Movimientos values('200-44455-18','01/03/2023','R',1850,200,1650)

INSERT Movimientos values('200-44445-08','02/03/2023','D',410,1240,1650)
INSERT Movimientos values('200-44445-08','17/04/2023','R',1650,500,1150)
INSERT Movimientos values('200-44445-08','12/05/2023','D',1150,800,1950)

INSERT Movimientos values('200-55667-09','15/04/2023','D',200,200,400)
INSERT Movimientos values('200-55667-09','10/09/2023','D',400,700,1100)

INSERT Movimientos values('201-55566-18','17/02/2023','D',250,850,1100)
INSERT Movimientos values('201-55566-18','27/02/2023','D',1100,400,1500)
INSERT Movimientos values('201-55566-18','14/10/2023','R',1500,600,900)

INSERT Movimientos values('201-66778-08','04/01/2024','R',460,320,140)
INSERT Movimientos values('201-66778-08','14/01/2024','D',140,300,440)
INSERT Movimientos values('201-66778-08','28/04/2024','D',440,400,840)
INSERT Movimientos values('201-66778-08','18/10/2024','R',840,140,700)
INSERT Movimientos values('202-66677-09','08/01/2024','R',700,300,400)

INSERT Movimientos values('202-66677-09','15/02/2024','D',520,500,1020)
INSERT Movimientos values('202-77889-18','27/06/2024','D',1020,580,1600)
INSERT Movimientos values('202-77889-18','04/08/2024','D',1600,800,2400)
INSERT Movimientos values('202-77889-18','17/11/2024','R',2400,700,1700)
go

--NEW
INSERT Cuentas values('191-46256-09','C0021','C01',350)
INSERT Cuentas values('191-44875-18','C0022','C01',850)
INSERT Cuentas values('193-41545-08','C0022','C03',800)
GO

INSERT Movimientos values('191-46256-09','04/01/2025','D',0,200,200)
INSERT Movimientos values('191-46256-09','14/01/2025','D',200,350,550)
INSERT Movimientos values('191-46256-09','28/04/2025','R',550,200,350)

INSERT Movimientos values('191-44875-18','08/01/2025','D',0,500,500)
INSERT Movimientos values('191-44875-18','23/03/2025','R',500,300,200)
INSERT Movimientos values('191-44875-18','15/08/2025','D',200,500,700)
INSERT Movimientos values('191-44875-18','27/10/2025','D',700,150,850)

INSERT Movimientos values('193-41545-08','04/03/2025','D',0,1000,1000)
INSERT Movimientos values('193-41545-08','17/11/2025','R',1000,200,800)
go

INSERT Movimientos values('191-18946-08','24/11/2019','D',850,300,1150)
INSERT Movimientos values('191-18946-08','14/12/2025','R',1150,200,950)
INSERT Movimientos values('191-18946-08','10/01/2008','R',950,100,850)

INSERT Cuentas values('191-55849-09','C0023','C01',1000)
INSERT Movimientos values('191-55849-09','04/01/2025','D',0,500,500)
INSERT Movimientos values('191-55849-09','14/01/2025','D',500,450,950)
INSERT Movimientos values('191-55849-09','28/04/2025','R',950,350,600)
INSERT Movimientos values('191-55849-09','14/05/2025','D',600,400,1000)

INSERT Cuentas values('191-51886-18','C0024','C01',900)
INSERT Movimientos values('191-51886-18','14/01/2025','D',0,200,200)
INSERT Movimientos values('191-51886-18','24/01/2025','D',200,500,700)
INSERT Movimientos values('191-51886-18','28/04/2025','R',700,200,500)
INSERT Movimientos values('191-51886-18','21/08/2025','D',500,400,900)

INSERT Cuentas values('193-64202-08','C0024','C03',700)
INSERT Movimientos values('193-64202-08','09/02/2025','D',0,400,400)
INSERT Movimientos values('193-64202-08','23/03/2025','D',400,300,700)
INSERT Movimientos values('193-64202-08','28/06/2025','R',700,150,550)
INSERT Movimientos values('193-64202-08','11/11/2025','R',550,200,350)
INSERT Movimientos values('193-64202-08','23/11/2025','D',350,350,700)

INSERT Cuentas values('191-61756-09','C0025','C01',500)
INSERT Movimientos values('191-61756-09','04/01/2025','D',0,200,200)
INSERT Movimientos values('191-61756-09','24/02/2025','D',200,350,550)
INSERT Movimientos values('191-61756-09','28/04/2025','R',550,250,300)
INSERT Movimientos values('191-61756-09','09/05/2025','D',300,200,500)
INSERT Movimientos values('191-61756-09','14/05/2025','D',500,350,850)
INSERT Movimientos values('191-61756-09','28/06/2025','R',850,350,500)

INSERT Cuentas values('193-41378-18','C0025','C03',800)
INSERT Movimientos values('193-41378-18','23/02/2025','D',0,400,400)
INSERT Movimientos values('193-41378-18','14/03/2025','D',400,1000,1400)
INSERT Movimientos values('193-41378-18','28/07/2025','R',1400,200,1200)
INSERT Movimientos values('193-41378-18','08/10/2025','R',1200,300,900)
INSERT Movimientos values('193-41378-18','22/11/2025','R',900,100,800)
INSERT Movimientos values('193-41378-18','14/01/2008','D',800,500,1300)

INSERT Cuentas values('191-46223-09','C0026','C01',400)
INSERT Movimientos values('191-46223-09','04/01/2025','D',0,200,200)
INSERT Movimientos values('191-46223-09','14/01/2025','D',200,350,550)
INSERT Movimientos values('191-46223-09','28/04/2025','R',550,250,300)
INSERT Movimientos values('191-46223-09','14/01/2025','D',300,350,650)
INSERT Movimientos values('191-46223-09','28/04/2025','R',650,250,400)

INSERT Cuentas values('193-41645-18','C0026','C03',1300)
INSERT Movimientos values('193-41645-18','26/01/2025','D',0,400,400)
INSERT Movimientos values('193-41645-18','24/04/2025','D',400,300,700)
INSERT Movimientos values('193-41645-18','14/07/2025','R',700,200,500)
INSERT Movimientos values('193-41645-18','05/10/2025','D',500,300,800)
INSERT Movimientos values('193-41645-18','21/10/2025','R',800,200,1000)
INSERT Movimientos values('193-41645-18','05/11/2025','D',1000,300,1300)

-- NEW
INSERT Movimientos values('191-46223-09','26/01/2025','D',0,400,400)
INSERT Movimientos values('191-46223-09','14/06/2025','D',400,300,700)
INSERT Movimientos values('191-46223-09','24/08/2025','R',700,200,500)
INSERT Movimientos values('191-46223-09','25/11/2025','R',500,200,300)

INSERT Movimientos values('191-51886-18','16/02/2025','D',0,400,400)
INSERT Movimientos values('191-51886-18','14/08/2025','D',400,300,700)
INSERT Movimientos values('191-51886-18','09/10/2025','R',700,200,500)
INSERT Movimientos values('191-51886-18','30/11/2025','D',500,400,900)

INSERT Movimientos values('191-55849-09','16/03/2025','D',0,400,400)
INSERT Movimientos values('191-55849-09','14/07/2025','D',400,300,700)
INSERT Movimientos values('191-55849-09','09/11/2025','R',700,200,500)

INSERT Movimientos values('191-61756-09','16/02/2025','D',0,400,400)
INSERT Movimientos values('191-61756-09','24/07/2025','D',400,300,700)
INSERT Movimientos values('191-61756-09','09/12/2025','R',700,400,300)

INSERT Movimientos values('193-41378-18','03/02/2025','D',0,400,400)
INSERT Movimientos values('193-41378-18','24/06/2025','D',400,300,700)
INSERT Movimientos values('193-41378-18','19/10/2025','R',700,200,500)
INSERT Movimientos values('193-41378-18','20/11/2025','D',500,500,1000)
INSERT Movimientos values('193-41378-18','05/12/2025','R',1000,200,800)

INSERT Movimientos values('193-41645-18','18/01/2025','D',0,400,400)
INSERT Movimientos values('193-41645-18','14/03/2025','D',400,300,700)
INSERT Movimientos values('193-41645-18','09/07/2025','R',700,200,500)
INSERT Movimientos values('193-41645-18','14/08/2025','D',500,300,800)
INSERT Movimientos values('193-41645-18','09/10/2025','R',800,200,600)
INSERT Movimientos values('193-41645-18','09/12/2025','D',600,200,800)

INSERT Movimientos values('193-64202-08','20/03/2025','D',0,400,400)
INSERT Movimientos values('193-64202-08','14/05/2025','D',400,300,700)
INSERT Movimientos values('193-64202-08','09/06/2025','R',700,300,400)
INSERT Movimientos values('193-64202-08','14/07/2025','D',400,150,550)
INSERT Movimientos values('193-64202-08','14/08/2025','D',550,150,700)

---------------------------------------------------
INSERT Cuentas values('202-45319-02','C0018','C01',800)
INSERT Movimientos values('202-45319-02','22/05/2025','D',0,600,600)
INSERT Movimientos values('202-45319-02','19/06/2025','D',600,800,1400)
INSERT Movimientos values('202-45319-02','10/07/2025','R',1400,300,1100)
INSERT Movimientos values('202-45319-02','14/09/2025','R',1100,300,800)
go

INSERT Cuentas values('204-13526-02','C0018','C03',1200)
INSERT Movimientos values('204-13526-02','20/07/2025','D',0,400,400)
INSERT Movimientos values('204-13526-02','14/08/2025','D',400,300,700)
INSERT Movimientos values('204-13526-02','19/08/2025','R',700,300,400)
INSERT Movimientos values('204-13526-02','14/09/2025','D',400,500,900)
INSERT Movimientos values('204-13526-02','24/09/2025','D',900,300,1200)
GO



---------------------------------------------------

SELECT 'Base de Datos BDBANCOS2025 creada correctamente' AS Mensaje
GO
PRINT 'Base de Datos BDBANCOS2025 creada correctamente'
GO

SET NOCOUNT OFF
GO






