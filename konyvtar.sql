-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1
-- Létrehozás ideje: 2024. Ápr 07. 19:21
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `konyvtar`
--
CREATE DATABASE IF NOT EXISTS `konyvtar` DEFAULT CHARACTER SET utf8 COLLATE utf8_hungarian_ci;
USE `konyvtar`;

-- --------------------------------------------------------

--
-- A nézet helyettes szerkezete `csoportositas`
-- (Lásd alább az aktuális nézetet)
--
DROP VIEW IF EXISTS `csoportositas`;
CREATE TABLE `csoportositas` (
`id` int(11)
,`name` varchar(255)
,`birth` date
,`Kölcsönzés azonosítója` int(11)
,`kolcsonzo_id` int(11)
,`iro` varchar(255)
,`mufaj` varchar(255)
,`cim` text
);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kolcsonsesek`
--

DROP TABLE IF EXISTS `kolcsonsesek`;
CREATE TABLE `kolcsonsesek` (
  `id` int(11) NOT NULL,
  `kolcsonzo_id` int(11) NOT NULL,
  `iro` varchar(255) NOT NULL,
  `mufaj` varchar(255) NOT NULL,
  `cim` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kolcsonsesek`
--

INSERT INTO `kolcsonsesek` (`id`, `kolcsonzo_id`, `iro`, `mufaj`, `cim`) VALUES
(1, 1, 'J.K. Rowling', 'Fantasy', 'Harry Potter és a Bölcsek Köve'),
(2, 2, 'Agatha Christie', 'Krimi', 'Hálószoba Kilencvenötben'),
(3, 3, 'George Orwell', 'Dystópia', '1984'),
(4, 4, 'Harper Lee', 'Regény', 'Ne bántsátok a feketerigót!'),
(5, 5, 'Gabriel García Márquez', 'Realizmus', 'Száz év magány'),
(6, 6, 'J.R.R. Tolkien', 'Fantasy', 'A Gyűrűk Ura'),
(7, 7, 'Jane Austen', 'Romantikus', 'Büszkeség és balítélet'),
(8, 8, 'Fyodor Dostoyevsky', 'Dráma', 'Bűn és bűnhődés'),
(9, 9, 'Leo Tolstoy', 'Eposz', 'Háború és béke'),
(10, 10, 'Mark Twain', 'Kaland', 'Huckleberry Finn kalandjai'),
(11, 1, 'Stephen King', 'Horror', 'Az'),
(12, 2, 'Gillian Flynn', 'Thriller', 'Én, a lány'),
(13, 3, 'Ernest Hemingway', 'Klasszikus', 'Az öreg és a tenger'),
(14, 4, 'Virginia Woolf', 'Modernizmus', 'Hullámok'),
(15, 5, 'Terry Pratchett', 'Fantasy', 'A Kolorádói óra'),
(16, 6, 'Emily Brontë', 'Romantikus', 'Üvöltő szelek'),
(17, 7, 'Ray Bradbury', 'Sci-fi', '451 Fahrenheit'),
(18, 8, 'Philip K. Dick', 'Sci-fi', 'A Mátrix'),
(19, 9, 'Arthur Conan Doyle', 'Detektív', 'Sherlock Holmes kalandjai'),
(20, 10, 'Herman Melville', 'Klasszikus', 'Moby Dick'),
(21, 1, 'Suzanne Collins', 'Sci-fi', 'Az éhezők viadala'),
(22, 2, 'Margaret Atwood', 'Dystópia', 'A szolgálólány meséje'),
(23, 3, 'H.G. Wells', 'Sci-fi', 'A háború a világokban'),
(24, 4, 'Roald Dahl', 'Gyermek', 'Matilda'),
(25, 5, 'Douglas Adams', 'Sci-fi', 'Galaxis útikalauz stopposoknak'),
(26, 6, 'J.D. Salinger', 'Regény', 'Zabhegyező'),
(27, 7, 'Ken Kesey', 'Modernizmus', 'A sikoly'),
(28, 8, 'Kazuo Ishiguro', 'Fikció', 'Az eltemetett óriás'),
(29, 9, 'Aldous Huxley', 'Sci-fi', 'Szép új világ'),
(30, 10, 'Michael Crichton', 'Sci-fi', 'Jurassic Park');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `kolcsonzok`
--

DROP TABLE IF EXISTS `kolcsonzok`;
CREATE TABLE `kolcsonzok` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `birth` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

--
-- A tábla adatainak kiíratása `kolcsonzok`
--

INSERT INTO `kolcsonzok` (`id`, `name`, `birth`) VALUES
(1, 'Kovács Ádám', '1990-05-15'),
(2, 'Tóth Bianka', '1985-11-23'),
(3, 'Nagy Gergő', '1978-09-02'),
(4, 'Szabó Anna', '1993-03-10'),
(5, 'Horváth Péter', '1980-07-18'),
(6, 'Kiss Katalin', '1975-01-30'),
(7, 'Molnár Bence', '1987-12-04'),
(8, 'Farkas Zsuzsa', '1995-06-28'),
(9, 'Bálint Dávid', '1972-10-07'),
(10, 'Szűcs Eszter', '1983-04-16'),
(11, 'Takács Gábor', '1991-08-22'),
(12, 'Simon Virág', '1979-02-14'),
(13, 'Varga Tamás', '1988-10-31'),
(14, 'Papp Nikolett', '1996-09-09'),
(15, 'Kovács Márton', '1981-12-19');

-- --------------------------------------------------------

--
-- Nézet szerkezete `csoportositas`
--
DROP TABLE IF EXISTS `csoportositas`;

DROP VIEW IF EXISTS `csoportositas`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `csoportositas`  AS SELECT `kolcsonzok`.`id` AS `id`, `kolcsonzok`.`name` AS `name`, `kolcsonzok`.`birth` AS `birth`, `kolcsonsesek`.`id` AS `Kölcsönzés azonosítója`, `kolcsonsesek`.`kolcsonzo_id` AS `kolcsonzo_id`, `kolcsonsesek`.`iro` AS `iro`, `kolcsonsesek`.`mufaj` AS `mufaj`, `kolcsonsesek`.`cim` AS `cim` FROM (`kolcsonzok` join `kolcsonsesek` on(`kolcsonzok`.`id` = `kolcsonsesek`.`kolcsonzo_id`)) ;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `kolcsonsesek`
--
ALTER TABLE `kolcsonsesek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kolcsonzo_id` (`kolcsonzo_id`);

--
-- A tábla indexei `kolcsonzok`
--
ALTER TABLE `kolcsonzok`
  ADD PRIMARY KEY (`id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `kolcsonsesek`
--
ALTER TABLE `kolcsonsesek`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT a táblához `kolcsonzok`
--
ALTER TABLE `kolcsonzok`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `kolcsonsesek`
--
ALTER TABLE `kolcsonsesek`
  ADD CONSTRAINT `kolcsonsesek_ibfk_1` FOREIGN KEY (`kolcsonzo_id`) REFERENCES `kolcsonzok` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
