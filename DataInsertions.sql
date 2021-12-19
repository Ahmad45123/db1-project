-- 15 + 15 + 8 + 9 + 3

-- 15 gucian, 15 non gucian, 9 supervisor, 8 examiner, 3 admin
--

-- 1-8 master gucian, 9-15 phd gucian, 16-23 master non gucian, 24-30 phd non gucian

USE dbProject3;
GO

-- disable referential integrity
EXEC sp_MSForEachTable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL' 
GO 

EXEC sp_MSForEachTable 'DELETE FROM ?' 
GO 

-- enable referential integrity again 
EXEC sp_MSForEachTable 'ALTER TABLE ? WITH CHECK CHECK CONSTRAINT ALL' 
GO

EXEC sp_MSForEachTable 'DBCC CHECKIDENT(''?'', RESEED, 0)'
GO

--EXEC sp_MSForEachTable 'SET IDENTITY_INSERT ? ON'
--GO

SET IDENTITY_INSERT PostGradUser OFF;
SET IDENTITY_INSERT Course OFF;
SET IDENTITY_INSERT Payment OFF;
SET IDENTITY_INSERT Thesis OFF;
SET IDENTITY_INSERT Publication OFF;

GO

INSERT INTO PostGradUser (email, password) VALUES ('mohsen.raki@gu.com', 'nyVrn9l8Eb');
INSERT INTO PostGradUser (email, password) VALUES ('zephan.iel@rnau.com', 'DhMBLL6zPy');
INSERT INTO PostGradUser (email, password) VALUES ('afonso.fohri@klor.com', 'SR2LrAuash');
INSERT INTO PostGradUser (email, password) VALUES ('alof.lari@gmail.com', '124TOfwCRs');
INSERT INTO PostGradUser (email, password) VALUES ('anuja.regli@krol.com', 'QNDktMqu4n');
INSERT INTO PostGradUser (email, password) VALUES ('corn.elio@nrklo.com', 'bRvU1rxZL9');
INSERT INTO PostGradUser (email, password) VALUES ('audam.ar@omlr.com', 'uGH6h6eEnc');
INSERT INTO PostGradUser (email, password) VALUES ('noran.nero@dfkai.com', 'bkhql3cvYD');
INSERT INTO PostGradUser (email, password) VALUES ('anish.laro@bordis.com', 'hq5YlAGaEM');
INSERT INTO PostGradUser (email, password) VALUES ('silas.fatsani@zvui.com', 'Di4dzLLfJQ');
INSERT INTO PostGradUser (email, password) VALUES ('mina.bartolome@gju.com', 'Brlcit2tK0');
INSERT INTO PostGradUser (email, password) VALUES ('nirmala.themix@hoh.com', 'BM3aZb4TYB');
INSERT INTO PostGradUser (email, password) VALUES ('nassim.farka@tkaol.com', 'sDagntF66Q');
INSERT INTO PostGradUser (email, password) VALUES ('gennadius.erna@ragl.com', 'hhKk1zAxI5');
INSERT INTO PostGradUser (email, password) VALUES ('silvijo.sree@lgaro.com', 'OtpVqpnVeJ');
INSERT INTO PostGradUser (email, password) VALUES ('janna.josefine@iko.com', 'pb8HtGTnlc');
INSERT INTO PostGradUser (email, password) VALUES ('bert.jia@gihu.com', 'nmyAoDZgI8');
INSERT INTO PostGradUser (email, password) VALUES ('machli.jen@ogiho.com', 'u67FwcLP8R');
INSERT INTO PostGradUser (email, password) VALUES ('borja.aong@wind.com', 'PXyCRnhMhw');
INSERT INTO PostGradUser (email, password) VALUES ('chetana.eef@ujkl.com', 'YOUESGCwAd');
INSERT INTO PostGradUser (email, password) VALUES ('washington.dion@ikla.com', '5QBz0MuwLS');
INSERT INTO PostGradUser (email, password) VALUES ('quint.kai@ik', 'HwkWaFYwVT');
INSERT INTO PostGradUser (email, password) VALUES ('aamina.jaki@klar.com', '5C6PW79UjE');
INSERT INTO PostGradUser (email, password) VALUES ('elenora.andor@iklar.com', '7jIGGliI7Y');
INSERT INTO PostGradUser (email, password) VALUES ('yuko.rafa@far.com', 'fEOyR0t8q8');
INSERT INTO PostGradUser (email, password) VALUES ('paulo.settimio@ikl.com', 'caKGwtYpa6');
INSERT INTO PostGradUser (email, password) VALUES ('punit.vladimir@drac.com', 'cVglOOyiDn');
INSERT INTO PostGradUser (email, password) VALUES ('marietta.troph@tro.com', '1mJFMEKcYO');
INSERT INTO PostGradUser (email, password) VALUES ('laurentius.andrea@uklar.com', 'USNs9GZy2B');
INSERT INTO PostGradUser (email, password) VALUES ('filo.pavi@klart.com', 'Jy3KBmUoA4');
INSERT INTO PostGradUser (email, password) VALUES ('ruska.sachna@oplf.com', 'gtIZHHFtlj');
INSERT INTO PostGradUser (email, password) VALUES ('annabelle.izumi@ippo.com', 'GmdnCTpbjI');
INSERT INTO PostGradUser (email, password) VALUES ('charis.frang@ikea.com', 'afkjyceZN0');
INSERT INTO PostGradUser (email, password) VALUES ('ilker.judo@fmab.com', 'peFP0gyD6w');
INSERT INTO PostGradUser (email, password) VALUES ('balint.gerhard@cg.com', 'jF0NCbhxsU');
INSERT INTO PostGradUser (email, password) VALUES ('svanhild.nout@mha.com', 'iklOGpT42I');
INSERT INTO PostGradUser (email, password) VALUES ('marta.whit@dbz.com', 'LmrQEDpr0q');
INSERT INTO PostGradUser (email, password) VALUES ('sweet.gadisa@fma.com', 'uyvychfzvb');
INSERT INTO PostGradUser (email, password) VALUES ('gillian.hugh@hxh.com', 'PbBEmaVBlh');
INSERT INTO PostGradUser (email, password) VALUES ('bart.mustafa@aot.com', '0FREkvuiJD');
INSERT INTO PostGradUser (email, password) VALUES ('hektor.fjolla@baki.com', 'KKWvmuuNzu');
INSERT INTO PostGradUser (email, password) VALUES ('gwen.abdullah@ben.com', 'gCr84Mid53');
INSERT INTO PostGradUser (email, password) VALUES ('marianne.cuthbert@dn.com', 'anOaPT5Adj');
INSERT INTO PostGradUser (email, password) VALUES ('alwin.divina@ukla.com', 'K1iF6AFlYi');
INSERT INTO PostGradUser (email, password) VALUES ('sophronia.eutro@kal.com', 'xybWdt5AeB');
INSERT INTO PostGradUser (email, password) VALUES ('prita.mino@tra.com', 'Nwqg7dFjrp');
INSERT INTO PostGradUser (email, password) VALUES ('morris.loui@atlab.com', 'r664gTOh0P');
INSERT INTO PostGradUser (email, password) VALUES ('polikarp.alyona@kiro.com', 'QDTrpJBydF');
INSERT INTO PostGradUser (email, password) VALUES ('clem.laureniu@regal.com', 'lp6o0z7tgk');
INSERT INTO PostGradUser (email, password) VALUES ('mabyn.valentina@gmail.com', 'hfdghhfgugdf236');


INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (9974, 1, 0.0);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (4251, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (6210, 1, 0.5);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (6819, 2, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (4307, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (1416, 3, 0.0);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (9052, 1, 0.3);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (3052, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES (7243, 1, 0.2);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 3121, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 4183, 5, 0.2);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 8921, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 7817, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 3409, 2, 0.8);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 1247, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 9974, 1, 0.0);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 4251, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 6210, 1, 0.5);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 6819, 2, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 4307, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 1416, 3, 0.0);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 9052, 1, 0.3);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 3052, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 7243, 1, 0.2);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 3121, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 4183, 5, 0.2);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 8921, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 7817, 1, 0.1);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 3409, 2, 0.8);
INSERT INTO Payment (amount, no_Installments, fundPercentage) VALUES ( 1247, 1, 0.1);

INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-02-14', 1, 9974, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-05-02', 2, 4251, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-07-15', 3, 6210, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-09-01', 4, 3819, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-10-17', 4, 3819, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-10-18', 5, 4307, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-11-14', 6, 416, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-12-31', 6, 500, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-01-08', 6, 500, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-01-14', 7, 9052, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-02-02', 8, 3052, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-02-15', 9, 7243, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-03-21', 10, 3121, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-07-27', 11, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-10-26', 11, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-01-28', 11, 1000, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-02-04', 11, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-02-05', 11, 183, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-09-27', 12, 8921, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-10-03', 13, 7817, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-10-05', 14, 3009, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-11-29', 14, 400, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-12-09', 15, 1247, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-02-14', 16, 9974, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-05-02', 17, 4251, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-07-15', 18, 6210, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-09-01', 19, 3819, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-10-17', 19, 3819, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-10-18', 20, 4307, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-11-14', 21, 416, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2019-12-31', 21, 500, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-01-08', 21, 500, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-01-14', 22, 9052, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-02-02', 23, 3052, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-02-15', 24, 7243, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-03-21', 25, 3121, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-07-27', 26, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2020-10-26', 26, 1000, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-01-28', 26, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-02-04', 26, 1000, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-02-05', 26, 183, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-09-27', 27, 8921, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-10-03', 28, 7817, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-10-05', 29, 3009, 0);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-11-29', 29, 400, 1);
INSERT INTO Installment (date, paymentId, amount, done) VALUES ('2021-12-09', 30, 1247, 0);


INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(1, 'mohsen', 'raki', 'MSc', 'Electronics', 'rkrbjp street', 1.60, '31-4248');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Electronics', 'MSc', 'Electronics Thesis', '2017-1-24', '2018-1-11', '2019-1-21', 3.19, 1, 0);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(2, 'zephan', 'iel', 'MSc', 'Computer Science', 'uxjlpqj street', 2.13, '22-9997');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2017-2-5', '2018-2-26', '2019-2-24', 0.39, 2, 1);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(3, 'afonso', 'fohri', 'MSc', 'Management', 'xkmekfl street', 3.13, '7-0786');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'MSc', 'Management Thesis', '2017-3-12', '2018-3-12', '2019-3-2', 1.63, 3, 1);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(4, 'alof', 'lari', 'MSc', 'Management', 'itfminoyri street', 2.68, '39-2279');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'MSc', 'Management Thesis', '2017-4-10', '2018-4-3', '2019-4-16', 1.38, 4, 2);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(5, 'anuja', 'regli', 'MSc', 'Computer Science', 'dlvhuanv street', 3.09, '4-8140');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2017-5-16', '2018-5-6', '2019-5-25', 1.94, 5, 1);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(6, 'corn', 'elio', 'MSc', 'Computer Science', 'plleet street', 0.27, '22-4417');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2017-6-2', '2018-6-7', '2019-6-28', 3.80, 6, 2);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(7, 'audam', 'ar', 'MSc', 'Computer Science', 'hvaeuh street', 1.20, '24-9420');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2017-7-14', '2018-7-28', '2019-7-16', 0.31, 7, 0);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(8, 'noran', 'nero', 'MSc', 'Pharmacy', 'hpkelzuxmu street', 3.27, '23-3696');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'MSc', 'Pharmacy Thesis', '2017-8-14', '2018-8-8', '2019-8-4', 1.11, 8, 1);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(9, 'anish', 'laro', 'PhD', 'Computer Science', 'blidtkb street', 2.34, '12-4790');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'PhD', 'Computer Science Thesis', '2017-9-6', '2018-9-7', '2019-9-24', 1.99, 9, 0);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(10, 'silas', 'fatsani', 'PhD', 'Management', 'eoymtjp street', 1.85, '34-0478');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2017-10-20', '2018-10-21', '2019-10-26', 1.94, 10, 1);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(11, 'mina', 'bartolome', 'PhD', 'Pharmacy', 'vjhmnuexj street', 1.63, '21-0211');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'PhD', 'Pharmacy Thesis', '2017-11-28', '2018-11-10', '2019-11-11', 0.50, 11, 2);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(12, 'nirmala', 'themix', 'PhD', 'Electronics', 'miuntkry street', 2.21, '2-2192');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Electronics', 'PhD', 'Electronics Thesis', '2018-12-26', '2019-12-28', '2020-12-10', 0.85, 12, 2);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(13, 'nassim', 'farka', 'PhD', 'Pharmacy', 'wqbsnl street', 1.80, '38-1120');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'PhD', 'Pharmacy Thesis', '2018-1-28', '2019-1-14', '2020-1-14', 1.59, 13, 0);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(14, 'gennadius', 'erna', 'PhD', 'Management', 'rlxziol street', 2.39, '15-9670');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2018-2-4', '2019-2-1', '2020-2-23', 2.08, 14, 2);
INSERT Into GucianStudent(id, firstName, lastName, type, faculty, address, GPA, undergradID)
Values(15, 'silvijo', 'sree', 'PhD', 'Management', 'yvfunqaqj street', 2.25, '16-5990');
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2018-3-23', '2019-3-12', '2020-3-16', 3.75, 15, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(16, 'janna', 'josefine', 'MSc', 'Management', 'hqwkozcvs street', 0.36);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'MSc', 'Management Thesis', '2018-4-5', '2019-4-10', '2020-4-4', 2.39, 16, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(17, 'bert', 'jia', 'MSc', 'Computer Science', 'xfuyyorp street', 2.40);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2018-5-21', '2019-5-22', '2020-5-5', 2.83, 17, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(18, 'machli', 'jen', 'MSc', 'Computer Science', 'fbyoxuh street', 1.61);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2018-6-24', '2019-6-1', '2020-6-27', 0.42, 18, 0);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(19, 'borja', 'aong', 'MSc', 'Computer Science', 'vgjlvpsv street', 3.83);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'MSc', 'Computer Science Thesis', '2018-7-12', '2019-7-1', '2020-7-18', 2.27, 19, 2);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(20, 'chetana', 'eef', 'MSc', 'Management', 'xstqye street', 0.22);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'MSc', 'Management Thesis', '2018-8-6', '2019-8-2', '2020-8-16', 3.05, 20, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(21, 'washington', 'dion', 'MSc', 'Pharmacy', 'tykwkshzdq street', 2.71);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'MSc', 'Pharmacy Thesis', '2018-9-15', '2019-9-22', '2020-9-9', 1.22, 21, 2);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(22, 'quint', 'kai', 'MSc', 'Pharmacy', 'wbcxogu street', 2.93);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'MSc', 'Pharmacy Thesis', '2018-10-14', '2019-10-14', '2020-10-10', 0.78, 22, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(23, 'aamina', 'jaki', 'MSc', 'Pharmacy', 'mrjyuibjmf street', 2.60);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Pharmacy', 'MSc', 'Pharmacy Thesis', '2018-11-5', '2019-11-22', '2020-11-21', 1.28, 23, 2);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(24, 'elenora', 'andor', 'PhD', 'Electronics', 'tbnshqtjnc street', 0.73);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Electronics', 'PhD', 'Electronics Thesis', '2019-12-21', '2020-12-6', '2021-12-26', 3.43, 24, 2);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(25, 'yuko', 'rafa', 'PhD', 'Computer Science', 'cevuqvm street', 3.70);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'PhD', 'Computer Science Thesis', '2019-1-9', '2020-1-4', '2021-1-13', 0.23, 25, 0);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(26, 'paulo', 'settimio', 'PhD', 'Management', 'pzdxjj street', 3.03);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2019-2-19', '2020-2-18', '2021-2-18', 1.41, 26, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(27, 'punit', 'vladimir', 'PhD', 'Management', 'lstnnmqaiz street', 1.56);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2019-3-7', '2020-3-15', '2021-3-27', 2.87, 27, 1);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(28, 'marietta', 'troph', 'PhD', 'Computer Science', 'lnorhuvr street', 0.53);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'PhD', 'Computer Science Thesis', '2019-4-10', '2020-4-1', '2021-4-12', 3.62, 28, 0);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(29, 'laurentius', 'andrea', 'PhD', 'Management', 'uucrydtnzw street', 3.69);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Management', 'PhD', 'Management Thesis', '2019-5-1', '2020-5-7', '2021-5-7', 2.29, 29, 0);
INSERT Into NonGucianStudent(id, firstName, lastName, type, faculty, address, GPA)
Values(30, 'filo', 'pavi', 'PhD', 'Computer Science', 'khzkwdxszc street', 0.83);
INSERT INTO Thesis (field, type, title, startDate, endDate, defenseDate, grade, payment_id, noExtension)
Values( 'Computer Science', 'PhD', 'Computer Science Thesis', '2019-6-25', '2020-6-22', '2021-6-14', 3.36, 30, 0);


INSERT INTO Supervisor(id, name, faculty) VALUES(31,'Ruska Sachna','Electronics');
INSERT INTO Supervisor(id, name, faculty) VALUES(32,'Annabelle Izumi','Computer Science');
INSERT INTO Supervisor(id, name, faculty) VALUES(33,'Charis Frang','Pharmacy');
INSERT INTO Supervisor(id, name, faculty) VALUES(34,'Ilker Judo','Management');
INSERT INTO Supervisor(id, name, faculty) VALUES(35,'Balint Gerhard','Pharmacy');
INSERT INTO Supervisor(id, name, faculty) VALUES(36,'Svanhild Nout','Computer Science');
INSERT INTO Supervisor(id, name, faculty) VALUES(37,'Marta Whit','Management');
INSERT INTO Supervisor(id, name, faculty) VALUES(38,'Sweet Gadisa','Computer Science');
INSERT INTO Supervisor(id, name, faculty) VALUES(39,'Gillian Hugh','Electronics');


INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(40,'Bart Mustafa','Electronics',0);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(41,'Hektor Fjolla','Computer Science',1);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(42,'Gwen Abdullah','',1);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(43,'Marianne Cuthbert','',1);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(44,'Alwin Divina','Computer Science',0);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(45,'Sophronia Eutro','Electronics',0);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(46,'Prita Mino','Management',1);
INSERT INTO Examiner(id, name, fieldOfWork, isNational) VALUES(47,'Morris Loui','Pharmacy',0);

INSERT INTO Admin(id) VALUES(48);
INSERT INTO Admin(id) VALUES(49);
INSERT INTO Admin(id) VALUES(50);

INSERT INTO Course (fees,creditHours, code) VALUES (2000, 4, 'CS102');
INSERT INTO Course (fees,creditHours, code) VALUES (3000, 3, 'CS103');
INSERT INTO Course (fees,creditHours, code) VALUES (4000, 4, 'CS104');
INSERT INTO Course (fees,creditHours, code) VALUES (1000, 3, 'CS101');
INSERT INTO Course (fees,creditHours, code) VALUES (5000, 3, 'CS105');
INSERT INTO Course (fees,creditHours, code) VALUES (1000, 4, 'CS106');

INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (16, 1, 100.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (16, 2, 98.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (16, 3, 100.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (17, 4, 10.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (18, 5, 99.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (19, 5, 30.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (20, 3, 100.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (20, 4, 26.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (25, 3, 39.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (25, 2, 90.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (27, 1, 70.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (27, 6, 75.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (28, 2, 38.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (29, 3, 0.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (30, 4, 21.0);
INSERT INTO NonGucianStudentTakeCourse (sid, cid, grade) VALUES (30, 6, 1.0);


INSERT INTO Defense (serialNumber, date, location, grade) VALUES (1, '2019-10-25' , 'uaaiboqaof', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (2, '2019-11-06' , 'eycnmmnjgm', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (3, '2019-11-17' , 'jlglsorxji', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (4, '2019-12-24' , 'fkxlnfsyja', 48.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (5, '2020-04-16' , 'uhlunwjcfz', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (6, '2020-04-26' , 'tlronstsin', 97.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (7, '2020-08-02' , 'xvdqgtgwqa', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (8, '2020-09-26' , 'gblqxlffcx', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (9, '2020-10-08' , 'eblgnnvngr', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (10, '2020-11-25' , 'iymfpkozpx', 28.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (11, '2020-12-29' , 'dfbhnyrlvd', 198.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (12, '2021-02-04' , 'xrievrmbya', 850.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (13, '2021-08-20' , 'ywdwnmtdsu', 19.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (14, '2021-10-21' , 'fnjdbajbge', 60.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (15, '2021-12-01' , 'fllrboklop', 30.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (16, '2019-10-25' , 'uaaiboqaof', 920.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (17, '2019-11-06' , 'eycnmmnjgm', 99.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (18, '2019-11-17' , 'jlglsorxji', 10.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (19, '2019-12-24' , 'fkxlnfsyja', 19.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (20, '2020-04-16' , 'uhlunwjcfz', 99.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (21, '2020-04-26' , 'tlronstsin', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (22, '2020-08-02' , 'xvdqgtgwqa', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (23, '2020-09-26' , 'gblqxlffcx', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (24, '2020-10-08' , 'eblgnnvngr', 0.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (25, '2020-11-25' , 'iymfpkozpx', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (26, '2020-12-29' , 'dfbhnyrlvd', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (27, '2021-02-04' , 'xrievrmbya', 0.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (28, '2021-08-20' , 'ywdwnmtdsu', 0.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (29, '2021-10-21' , 'fnjdbajbge', 100.0);
INSERT INTO Defense (serialNumber, date, location, grade) VALUES (30, '2021-12-01' , 'fllrboklop', 100.0);


INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-10-25', 1, 40, 'One of the best thesises I have read');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-11-06', 2, 46, 'Made me cry');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-11-17', 3, 45, 'Please review line 325');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-12-24', 4, 42, 'Amazing');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-04-16', 5, 40, 'I love it');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-04-26', 6, 44, 'Amazing');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-08-02', 7, 41, 'Please review line 125');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-09-26', 8, 43, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-10-08', 9, 43, 'HAAHAHAHAH');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-11-25', 10, 45, 'Very thought provoking');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-12-29', 11, 47, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-02-04', 12, 47, 'Made me cry');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-08-20', 13, 46, 'Good');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-10-21', 14, 44, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-12-01', 15, 41, 'Very bad');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-10-25', 16, 40, 'One of the best thesises I have read');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-11-06', 17, 46, 'Made me cry');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-11-17', 18, 45, 'Please review line 325');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2019-12-24', 19, 42, 'Would read again');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-04-16', 20, 40, 'I love it');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-04-26', 21, 44, 'Amazing');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-08-02', 22, 41, 'Please review line 131');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-09-26', 23, 43, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-10-08', 24, 43, 'HAAHAHAHAH');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-11-25', 25, 45, 'Very thought provoking');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2020-12-29', 26, 47, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-02-04', 27, 47, 'Made me cry');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-08-20', 28, 46, 'Good');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-10-21', 29, 44, 'Excellent');
INSERT INTO ExaminerEvaluateDefense(date, serialNo, examinerId, comment) VALUES ('2021-12-01', 30, 41, 'Meet me after defense');

INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (1,1,'2009-08-16','80','diam fringilla',1,31)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (1,2,'2017-07-28','97','cursus porttitor',1,39)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (2,1,'2004-10-25','25','auctor neque',2,36)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (3,1,'2018-05-04','73','ipsum dolor',3,37)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (4,1,'2016-09-11','29','euismod Vestibulum',4,37)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (5,1,'2005-12-23','21','eget urna',5,36)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (5,2,'2007-12-07','13','non eleifend',5,36)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (7,1,'2012-03-10','69','dolor sit',7,32)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (11,1,'2009-04-28','32','leo a',11,33)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (11,2,'2021-11-03','49','sollicitudin pulvinar',11,35)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (13,1,'2002-03-27','94','vel tortor',13,33)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (13,2,'2019-11-05','47','sem bibendum',13,33)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (15,1,'2003-04-09','81','sapien mattis',15,34)
INSERT INTO GUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (15,2,'2005-04-17','97','eu ut',15,34)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (16,1,'2013-11-25','3','Etiam vel',16,34)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (16,2,'2002-01-03','29','orci Ut',16,37)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (17,1,'2020-06-20','2','nisi ligula',17,32)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (17,2,'2021-03-10','11','congue placerat',17,32)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (18,1,'2020-08-27','85','consequat suscipit',18,36)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (18,2,'2008-09-18','49','Aliquam orci',18,36)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (21,1,'2011-12-16','23','efficitur neque',21,35)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (24,1,'2003-12-07','3','Curabitur efficitur',24,31)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (24,2,'2017-08-04','85','neque Nullam',24,39)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (26,1,'2009-10-05','37','rutrum tempus',26,37)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (26,2,'2014-12-06','39','Suspendisse sodales',26,37)
INSERT INTO NonGUCianProgressReport(sid,no,date,eval,state,thesisSerialNumber,supid) VALUES (27,1,'2016-08-08','13','amet consectetur',27,34)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (1, 39, 1)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (1, 31, 1)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (2, 36, 2)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (3, 37, 3)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (4, 37, 4)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (5, 36, 5)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (7, 32, 7)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (11, 33, 11)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (11, 35, 11)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (13, 33, 13)
INSERT INTO GUCStudentRegisterThesis (sid, supid, serial_no) VALUES (15, 34, 15)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (16, 34, 16)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (16, 37, 16)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (17, 32, 17)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (18, 36, 18)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (21, 35, 21)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (24, 39, 24)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (24, 31, 24)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (26, 37, 26)
INSERT INTO NonGUCStudentRegisterThesis (sid, supid, serial_no) VALUES (27, 34, 27)
