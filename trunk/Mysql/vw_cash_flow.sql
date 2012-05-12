-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 12, 2012 at 04:41 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pos_db`
--

-- --------------------------------------------------------

--
-- Structure for view `vw_cash_flow`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_cash_flow` AS (select `c`.`id` AS `id`,`c`.`tgl_cash` AS `tgl_cash`,`c`.`money_cash` AS `money_cash`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `jual_sebelumnya`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `jual`,if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `beli_sebelumnya`,if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (convert(date_format(`b`.`tgl_input`,'%Y-%m-%d') using latin1) = `b`.`tgl_bayar`) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`b`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d')))),0) AS `beli`,if(((select count(0) AS `COUNT(*)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`d`.`retur` * `d`.`harga_beli`)) AS `SUM(d.retur*d.harga_beli)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `retur`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum(`j`.`komisi`) AS `SUM(j.komisi)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `komisi`,((if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) - (((if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (convert(date_format(`b`.`tgl_input`,'%Y-%m-%d') using latin1) = `b`.`tgl_bayar`) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`b`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d')))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`d`.`retur` * `d`.`harga_beli`)) AS `SUM(d.retur*d.harga_beli)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where (`b`.`flag_supplier` and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum(`j`.`komisi`) AS `SUM(j.komisi)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0))) AS `laba`,`c`.`cash` AS `cash`,(((if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) - (((if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (convert(date_format(`b`.`tgl_input`,'%Y-%m-%d') using latin1) = `b`.`tgl_bayar`) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`b`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d')))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`d`.`retur` * `d`.`harga_beli`)) AS `SUM(d.retur*d.harga_beli)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum(`j`.`komisi`) AS `SUM(j.komisi)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0))) - `c`.`cash`) AS `kas`,((((if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (convert(date_format(`j`.`tgl_input`,'%Y-%m-%d') using latin1) = `j`.`tgl_bayar`) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`j`.`bayar` + `j`.`piutang`)) AS `SUM(j.bayar+j.piutang)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`j`.`tgl_input`,'%Y-%m-%d')) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) - (((if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (convert(date_format(`b`.`tgl_input`,'%Y-%m-%d') using latin1) = `b`.`tgl_bayar`) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`b`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d')))),0) + if(((select count(0) AS `COUNT(*)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`b`.`bayar` + `b`.`hutang`)) AS `SUM(b.bayar+b.hutang)` from `tbl_beli` `b` where ((`b`.`flag_supplier` = 0) and (date_format(`c`.`tgl_cash`,'%Y-%m-%d') <> date_format(`b`.`tgl_input`,'%Y-%m-%d')) and (`b`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum((`d`.`retur` * `d`.`harga_beli`)) AS `SUM(d.retur*d.harga_beli)` from (`tbl_beli` `b` join `tbl_beli_details` `d` on((`d`.`no_beli` = `b`.`no_beli`))) where ((`b`.`flag_supplier` = 0) and (`d`.`tgl_retur` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0)) + if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select sum(`j`.`komisi`) AS `SUM(j.komisi)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_komisi` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0))) - `c`.`cash`) + `c`.`money_cash`) AS `kas_total`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where (date_format(`j`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d'))) > 0),(select count(`j`.`kd_pasien`) AS `COUNT(j.kd_pasien)` from `tbl_jual` `j` where (date_format(`j`.`tgl_input`,'%Y-%m-%d') = date_format(`c`.`tgl_cash`,'%Y-%m-%d'))),0) AS `pasien`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select count(`j`.`kd_pasien`) AS `COUNT(j.kd_pasien)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `lunas`,if(((select count(0) AS `COUNT(*)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))) > 0),(select count(`j`.`kd_pasien`) AS `COUNT(j.kd_pasien)` from `tbl_jual` `j` where ((`j`.`flag_kreditor` = 0) and (`j`.`flag_debitor` = 0) and (`j`.`tgl_bayar` = convert(date_format(`c`.`tgl_cash`,'%Y-%m-%d') using latin1)))),0) AS `pay_komisi`,`c`.`flag` AS `flag` from `tbl_cash` `c`);

--
-- VIEW  `vw_cash_flow`
-- Data: None
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
