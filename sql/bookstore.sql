-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- 主機: localhost
-- 產生時間： 2018 年 03 月 20 日 23:41
-- 伺服器版本: 5.7.21-0ubuntu0.16.04.1
-- PHP 版本： 7.0.25-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `bookstore`
--

-- --------------------------------------------------------

--
-- 資料表結構 `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `author` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `category` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pic_url` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `import_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 資料表的匯出資料 `books`
--

INSERT INTO `books` (`id`, `name`, `author`, `description`, `price`, `stock`, `category`, `pic_url`, `import_date`) VALUES
(1, 'The Martian', 'Andy Weir', 'A book about a weird man.', 999, 101, 'romance', 'https://i.imgur.com/3uQzbcK.png', '2018-03-18 19:42:03'),
(2, 'Harry Potter', 'JJ Bowling', 'A book about a nerd.', 1, 22, 'romance', 'https://i.imgur.com/S4DkkJg.png', '2018-03-18 19:42:52'),
(3, 'Three pigs', 'Winson', 'Silly book.', 200, 20, 'comics', 'https://i.imgur.com/PhLZuHs.png', '2018-03-18 22:18:48'),
(4, 'The Happy Lemon', 'P. Young', 'Lemon is sour.', 99, 54, 'comics', 'https://marketplace.canva.com/MAB___U-clw/1/0/thumbnail_large/canva-yellow-lemon-children-book-cover-MAB___U-clw.jpg', '2018-03-19 08:38:00'),
(5, 'The Great Gatsby', 'F. Scott', 'A great business man.', 179, 11, 'comics', 'https://i.imgur.com/BbOtbCd.jpg', '2018-03-19 08:39:42'),
(25, 'Insanity', 'Mr. Nuts', 'Everyone is insane.', 299, 15, 'romance', 'https://i.imgur.com/Qi4E9VM.jpg', '2018-03-19 21:44:33'),
(27, 'What\'s Your Poo Tell You', 'P. Young', 'Lemon is sour.', 99, 54, 'comics', 'https://i.imgur.com/OJDDP8N.jpg', '2018-03-19 08:38:00'),
(28, 'She Is Waiting You', 'litlle ghost', 'He does too.', 88, 12, 'romance', 'https://www.creativeparamita.com/wp-content/uploads/2013/12/She-is-waiting-for-you1.jpg', '2018-03-19 23:06:39'),
(29, 'The Devil Is Gay', 'Thor', 'How about the angel', 99, 23, 'romance', 'https://queerty-prodweb.s3.amazonaws.com/wp/docs/2013/12/devil-is-gay.jpg', '2018-03-19 23:08:49'),
(30, 'Mistletoe Madness', 'dwa', 'Two lovely boys', 8964, 222, 'romance', 'https://i.imgur.com/01aedvP.jpg', '2018-03-19 23:12:21'),
(31, 'Buffy Rides Again!', 'Buffy', 'A story of a hero.', 24, 228, 'romance', 'https://www.jeffandwill.com/wp-content/uploads/2011/05/xbuffyridesagain.jpg', '2018-03-19 23:15:46'),
(32, 'Haunted', 'MR anonymous ', 'anonymousanonymousanonymousanonymousanony', 231, 2, 'horror', 'https://images-na.ssl-images-amazon.com/images/I/61SRCkVyRHL._SX322_BO1,204,203,200_.jpg', '2018-03-19 23:17:33'),
(33, 'Haunted', 'MR anonymous ', 'anonymousanonymousanonymousanonymousanony', 231, 0, 'horror', 'https://images-na.ssl-images-amazon.com/images/I/61SRCkVyRHL._SX322_BO1,204,203,200_.jpg', '2018-03-19 23:17:33');

-- --------------------------------------------------------

--
-- 資料表結構 `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 資料表的匯出資料 `orders`
--

INSERT INTO `orders` (`id`, `bookid`, `userid`, `order_date`, `paid`) VALUES
(200173, 1, 3, '2018-03-19 21:16:39', 'No'),
(200174, 2, 3, '2018-03-19 21:16:39', 'No'),
(200175, 2, 1, '2018-03-19 21:22:22', 'No'),
(200176, 1, 1, '2018-03-19 21:22:22', 'No'),
(200177, 1, 4, '2018-03-19 23:01:41', 'No'),
(200178, 2, 4, '2018-03-19 23:01:41', 'No'),
(200179, 4, 4, '2018-03-19 23:01:41', 'No'),
(200180, 3, 4, '2018-03-19 23:01:41', 'No'),
(200181, 5, 4, '2018-03-19 23:01:41', 'No'),
(200182, 32, 2, '2018-03-20 02:30:04', 'No');

-- --------------------------------------------------------

--
-- 資料表結構 `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 資料表結構 `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `register_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 資料表的匯出資料 `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `address`, `username`, `password`, `register_date`) VALUES
(1, 'penny cheung', 'penny@penny.com', 'penny\'s home', 'penny', '1234', '2018-03-18 19:30:50'),
(2, 'vincent', 'vincent@gmail.com', 'vincents home', 'vincent', '1234', '2018-03-18 22:18:15'),
(3, 'hurry potter', 'hurry@potter.com', 'Hogwarts 115', 'hurry', '1234', '2018-03-18 23:16:56'),
(4, 'wong', 'wong213@gmail.com', 'wong\'s homeeee', 'wong', '1234', '2018-03-19 23:00:45'),
(5, 'cheung', 'cheung', 'cheung', 'cheung', '1234', '2018-03-20 00:03:02');

--
-- 已匯出資料表的索引
--

--
-- 資料表索引 `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`id`);

--
-- 資料表索引 `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- 在匯出的資料表使用 AUTO_INCREMENT
--

--
-- 使用資料表 AUTO_INCREMENT `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
--
-- 使用資料表 AUTO_INCREMENT `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=200183;
--
-- 使用資料表 AUTO_INCREMENT `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用資料表 AUTO_INCREMENT `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
