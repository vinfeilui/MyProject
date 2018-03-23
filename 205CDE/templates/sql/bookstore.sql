-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 22, 2018 at 01:40 AM
-- Server version: 5.7.21-0ubuntu0.16.04.1
-- PHP Version: 7.0.28-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
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
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `name`, `author`, `description`, `price`, `stock`, `category`, `pic_url`, `import_date`) VALUES
(1, 'The Martian', 'Andy Weir', 'A book about a weird man.', 999, 101, 'romance', 'https://i.imgur.com/3uQzbcK.png', '2018-03-18 19:42:03'),
(2, 'Harry Potter', 'JJ Bowling', 'A book about a nerd.', 1, 0, 'romance', 'https://i.imgur.com/S4DkkJg.png', '2018-03-18 19:42:52'),
(3, 'Three pigs', 'Winson', 'Silly book.', 200, 20, 'comics', 'https://i.imgur.com/PhLZuHs.png', '2018-03-18 22:18:48'),
(4, 'The Happy Lemon', 'P. Young', 'Lemon is sour.', 99, 54, 'comics', 'https://marketplace.canva.com/MAB___U-clw/1/0/thumbnail_large/canva-yellow-lemon-children-book-cover-MAB___U-clw.jpg', '2018-03-19 08:38:00'),
(5, 'The Great Gatsby', 'F. Scott', 'A great business man.', 179, 11, 'comics', 'https://i.imgur.com/BbOtbCd.jpg', '2018-03-19 08:39:42'),
(25, 'Insanity', 'Mr. Nuts', 'Everyone is insane.', 299, 15, 'romance', 'https://i.imgur.com/Qi4E9VM.jpg', '2018-03-19 21:44:33'),
(27, 'What\'s Your Poo Tell You', 'P. Young', 'Lemon is sour.', 99, 54, 'comics', 'https://i.imgur.com/OJDDP8N.jpg', '2018-03-19 08:38:00'),
(28, 'She Is Waiting You', 'litlle ghost', 'He does too.', 88, 12, 'romance', 'https://www.creativeparamita.com/wp-content/uploads/2013/12/She-is-waiting-for-you1.jpg', '2018-03-19 23:06:39'),
(29, 'The Devil Is Gay', 'Thor', 'How about the angel', 99, 23, 'romance', 'https://queerty-prodweb.s3.amazonaws.com/wp/docs/2013/12/devil-is-gay.jpg', '2018-03-19 23:08:49'),
(30, 'Mistletoe Madness', 'dwa', 'Two lovely boys', 8964, 222, 'romance', 'https://i.imgur.com/01aedvP.jpg', '2018-03-19 23:12:21'),
(31, 'Buffy Rides Again!', 'Buffy', 'A story of a hero.', 24, 228, 'romance', 'https://www.jeffandwill.com/wp-content/uploads/2011/05/xbuffyridesagain.jpg', '2018-03-19 23:15:46'),
(32, 'Haunted', 'MR anonymous ', 'ousanonymousanonymousanony', 231, 2, 'horror', 'https://images-na.ssl-images-amazon.com/images/I/61SRCkVyRHL._SX322_BO1,204,203,200_.jpg', '2018-03-19 23:17:33'),
(36, 'Scary Night', 'Author Name', 'A story about a man\'s scary night.', 230, 22, 'horror', 'https://www.bookcover4u.com/pro/Horror-book-cover-design-N1507831337HOB-Scary-Night-scary-spooky-night-scary-night.jpg', '2018-03-20 06:25:41'),
(38, 'The Happy Lemon', 'P. Young', 'Lemon is sour.', 99, 54, 'comics', 'https://marketplace.canva.com/MAB___U-clw/1/0/thumbnail_large/canva-yellow-lemon-children-book-cover-MAB___U-clw.jpg', '2018-03-19 08:38:00'),
(39, 'Travel', 'travel', 'travel', 10, 100, 'travel', '', '2018-03-21 05:18:08');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `content` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `comment_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `userid`, `bookid`, `content`, `comment_date`) VALUES
(1, 1, 1, 'This book sucks.', '2018-03-21 01:30:39'),
(3, 3, 1, 'This books sucks', '2018-03-21 02:13:12'),
(19, 3, 3, '10/10 would by again', '2018-03-21 03:22:16'),
(20, 2, 3, 'Nice story', '2018-03-21 03:24:01'),
(22, 2, 33, 'It\'s not scary at all! Refund!', '2018-03-21 03:25:03'),
(23, 4, 31, 'This is gross', '2018-03-21 04:18:25'),
(24, 3, 30, 'This is gross too', '2018-03-21 04:28:59'),
(25, 4, 29, 'The devil is not gay! Refund!', '2018-03-21 04:54:25'),
(26, 4, 25, 'This book is scary.', '2018-03-21 07:33:05'),
(27, 5, 2, 'sucks', '2018-03-21 10:52:44');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `paid` varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'No'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `bookid`, `userid`, `order_date`, `paid`) VALUES
(1, 30, 4, '2018-03-21 04:31:31', 'No'),
(2, 33, 4, '2018-03-21 04:32:29', 'No'),
(3, 32, 4, '2018-03-21 04:32:29', 'No'),
(4, 5, 3, '2018-03-21 04:56:31', 'No'),
(5, 5, 1, '2018-03-21 05:15:58', 'No'),
(6, 30, 4, '2018-03-21 07:38:55', 'No'),
(7, 39, 4, '2018-03-21 07:39:15', 'No'),
(8, 31, 4, '2018-03-21 10:46:52', 'No'),
(9, 5, 5, '2018-03-21 10:53:42', 'No'),
(10, 4, 5, '2018-03-21 10:53:42', 'No'),
(11, 32, 5, '2018-03-21 11:00:51', 'No');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `id` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `bookid` int(11) NOT NULL,
  `order_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
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
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `address`, `username`, `password`, `register_date`) VALUES
(1, 'penny cheung', 'penny@penny.com', 'penny\'s home', 'penny', '1234', '2018-03-18 19:30:50'),
(2, 'vincent', 'vincent@gmail.com', 'vincents home', 'vincent', '1234', '2018-03-18 22:18:15'),
(3, 'hurry potter', 'hurry@potter.com', 'Hogwarts 115', 'hurry', '1234', '2018-03-18 23:16:56'),
(5, 'j123', 'jj123dwa,dwadaw', 'jjjjjjjj', 'jjjj', '1234', '2018-03-21 10:52:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
