-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 09, 2024 at 03:27 PM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hospital_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `user_id`, `first_name`, `last_name`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 1, 'Test', 'Admin', 'Admin', '2024-06-07 22:25:46', '2024-06-07 22:25:46');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `user_id`, `first_name`, `last_name`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 2, 'Test ', 'Doctor 1', 'Doctor', '2024-06-07 22:27:09', '2024-06-07 22:27:09'),
(2, 6, 'Testing', 'Doc 2', 'Doctor', '2024-06-07 22:56:29', '2024-06-07 22:56:29'),
(3, 7, 'TestTest', 'Doctor 3', 'Doctor', '2024-06-07 22:57:23', '2024-06-07 22:57:23'),
(4, 9, 'Testings', 'Doc 4', 'Doctor', '2024-06-07 23:06:10', '2024-06-07 23:06:10');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `medical_records`
--

CREATE TABLE `medical_records` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `patient_id` bigint(20) UNSIGNED NOT NULL,
  `doctor_id` bigint(20) UNSIGNED NOT NULL,
  `illness` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `diagnosis` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `treatment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remarks` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `medical_records`
--

INSERT INTO `medical_records` (`id`, `patient_id`, `doctor_id`, `illness`, `diagnosis`, `treatment`, `remarks`, `created_at`, `updated_at`) VALUES
(3, 4, 4, 'Test Illness 2 with editttt', 'Test Diagnosis 2 with editttt', 'Test Treatment 2 with editttt', 'Test Treatment 2 with editttt', '2024-06-08 20:37:40', '2024-06-09 00:01:09'),
(4, 3, 3, 'Test Illness 3 test doctorrrr', 'Test Diagnosis 31123123213', 'Test Treatment 3', 'Test Remarks 3', '2024-06-08 20:38:12', '2024-06-09 04:47:38');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_06_05_015242_create_personal_access_tokens_table', 1),
(5, '2024_06_05_032339_create_admins_table', 1),
(6, '2024_06_05_032457_create_doctors_table', 1),
(7, '2024_06_05_032501_create_patients_table', 1),
(8, '2024_06_05_033454_create_medical_records_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `user_id`, `first_name`, `last_name`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 3, 'Patient', 'Testing 1', 'Patient', '2024-06-07 22:44:30', '2024-06-07 22:44:30'),
(2, 4, 'Patient', 'TestTest2', 'Patient', '2024-06-07 22:48:24', '2024-06-07 22:48:24'),
(3, 5, 'Patient', 'Testingsss', 'Patient', '2024-06-07 22:54:07', '2024-06-07 22:54:07'),
(4, 8, 'Patient', 'Test 123', 'Patient', '2024-06-07 23:02:14', '2024-06-07 23:02:14');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'Admin Dashboard', '2e2792b341446ee3c1acf0d4cad8fe5c9ac0ed2a080b2c3036cd30be817d5ff0', '[\"*\"]', NULL, NULL, '2024-06-07 22:26:17', '2024-06-07 22:26:17'),
(2, 'App\\Models\\User', 1, 'Admin Dashboard', '8d558d2a8aab2832f242abfca6f85b18bc13ce1057ed296e3ee001cc52aec484', '[\"*\"]', NULL, NULL, '2024-06-07 22:27:31', '2024-06-07 22:27:31'),
(3, 'App\\Models\\User', 1, 'Admin Dashboard', '513516abcb6937632cab8b1e0e19f65fbce117b683214322d5251e439e12140d', '[\"*\"]', NULL, NULL, '2024-06-07 22:44:13', '2024-06-07 22:44:13'),
(4, 'App\\Models\\User', 1, 'Admin Dashboard', '3cf071dcf3425a2ca51eea8bb79fabb50ccd514461331b5ce3e9783e6a44e769', '[\"*\"]', NULL, NULL, '2024-06-07 22:48:07', '2024-06-07 22:48:07'),
(5, 'App\\Models\\User', 4, 'Admin Dashboard', 'ca1f793ab1de89dd38a18d3ba2f6391449046001509d59d8527a6da4b27c3261', '[\"*\"]', NULL, NULL, '2024-06-07 22:51:48', '2024-06-07 22:51:48'),
(6, 'App\\Models\\User', 4, 'Admin Dashboard', '32cc24661a21d328e16597cece6c14e534b1de58785a9d7d47b4083cc514fea8', '[\"*\"]', NULL, NULL, '2024-06-07 22:52:00', '2024-06-07 22:52:00'),
(7, 'App\\Models\\User', 1, 'Admin Dashboard', '1a268c380c0c76d3362993fc5d84f81c30ab303bdcd4cd314114245c4107a4cf', '[\"*\"]', NULL, NULL, '2024-06-07 22:52:58', '2024-06-07 22:52:58'),
(8, 'App\\Models\\User', 4, 'Admin Dashboard', '820c9e22ebd4d06bd9a99f16f673f4d5dda7d8ed123f083dff47ff06815b1090', '[\"*\"]', NULL, NULL, '2024-06-07 22:53:34', '2024-06-07 22:53:34'),
(9, 'App\\Models\\User', 4, 'Admin Dashboard', 'd933d232cfd7012db0ccd6f8680ab1fde8cadbee9f10bb412bab7c78fac7a84b', '[\"*\"]', NULL, NULL, '2024-06-07 22:57:05', '2024-06-07 22:57:05'),
(10, 'App\\Models\\User', 4, 'Admin Dashboard', '7ce4a0de37be6066f3d26f22e1a48d500e4256d925444cca70dbe105bab44388', '[\"*\"]', NULL, NULL, '2024-06-07 22:59:10', '2024-06-07 22:59:10'),
(11, 'App\\Models\\User', 4, 'Admin Dashboard', '3220d89c251b21f0318634ff81041adb746253c33b33180f0032f689a51231a2', '[\"*\"]', NULL, NULL, '2024-06-07 23:01:57', '2024-06-07 23:01:57'),
(12, 'App\\Models\\User', 7, 'Admin Dashboard', '404dbdde9f168ce5fbce025a7b8e5eed2e273bb028a1842e13ca390816032d8e', '[\"*\"]', NULL, NULL, '2024-06-07 23:05:53', '2024-06-07 23:05:53'),
(13, 'App\\Models\\User', 4, 'Admin Dashboard', '376bd0fa327e81009ff33e6ad954142bd59f17f45d70ca04dad128a9b45cb08f', '[\"*\"]', NULL, NULL, '2024-06-07 23:20:01', '2024-06-07 23:20:01'),
(14, 'App\\Models\\User', 1, 'Admin Dashboard', 'ebc8cba7a70eea3f8c2449eba83e601a887dc1566d5a84c639ff8a6a7d3f243b', '[\"*\"]', NULL, NULL, '2024-06-07 23:21:42', '2024-06-07 23:21:42'),
(15, 'App\\Models\\User', 1, 'Admin Dashboard', '9adacbe636d4e02b9d1e18948d90428d0ebb5eb28be3cd309dfb095d95cbaa0f', '[\"*\"]', NULL, NULL, '2024-06-08 20:28:48', '2024-06-08 20:28:48'),
(16, 'App\\Models\\User', 4, 'Admin Dashboard', '38b8c76756dda88d43875ce819cb2989de2e09082521fda2a7617d694fe40d05', '[\"*\"]', NULL, NULL, '2024-06-09 01:56:45', '2024-06-09 01:56:45'),
(17, 'App\\Models\\User', 1, 'Admin Dashboard', '322afb354111a1d928c0caf7569c68c06c80a913d1ff7d52fef42eed3075f682', '[\"*\"]', NULL, NULL, '2024-06-09 02:10:17', '2024-06-09 02:10:17'),
(18, 'App\\Models\\User', 5, 'Admin Dashboard', '4b7e3ec9bc6b01fc1bdc2c931031cf704e74535b16553fb721792ea1787f1d39', '[\"*\"]', NULL, NULL, '2024-06-09 02:10:29', '2024-06-09 02:10:29'),
(19, 'App\\Models\\User', 7, 'Admin Dashboard', 'a245f2a3ae89e5781b59ced02c54bbf036029ed4f604b58bf8c03fee3597555f', '[\"*\"]', NULL, NULL, '2024-06-09 02:15:52', '2024-06-09 02:15:52'),
(20, 'App\\Models\\User', 1, 'Admin Dashboard', '43d558c8fdb57ae3d34cbf2664bd7a88b6600ec61924738979b01a5a7209cf34', '[\"*\"]', NULL, NULL, '2024-06-09 02:16:23', '2024-06-09 02:16:23'),
(21, 'App\\Models\\User', 7, 'Admin Dashboard', 'b68d8eaf2ce9ca0d4302d75a42044c5bf0954f705acc46420d3bd671d5ada4b4', '[\"*\"]', NULL, NULL, '2024-06-09 02:16:49', '2024-06-09 02:16:49'),
(22, 'App\\Models\\User', 7, 'Admin Dashboard', '074ab9369de469fbf10cef7842ce1c614c0adfb1effb24466bdd29ab722092ca', '[\"*\"]', NULL, NULL, '2024-06-09 04:37:39', '2024-06-09 04:37:39');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'admin@gmail.com', NULL, '$2y$12$cLiOtbnlyogmoot0wiivLulq591Cx2NtqYTYurriqEciy7EbwpPN.', NULL, '2024-06-07 22:25:46', '2024-06-07 22:25:46'),
(2, 'doctest@gmail.com', NULL, '$2y$12$EcmYjQz8/o57XF5gT5.K8uhQCn4esDij.UcqHRRKSbIvphr/s.u0q', NULL, '2024-06-07 22:27:09', '2024-06-07 22:27:09'),
(3, 'patienttest@gmail.com', NULL, '$2y$12$XJSuXO1ZIgW5T04aDXvAreUJNCDNO.CmtSvQPiZBrGace51NWXtYO', NULL, '2024-06-07 22:44:30', '2024-06-07 22:44:30'),
(4, 'patienttest1@gmail.com', NULL, '$2y$12$tHi/e8ItISBZvqDX7yn4iuNjrgtX4.BGuVk.BxOzLAb/BI/QyEkni', NULL, '2024-06-07 22:48:24', '2024-06-07 22:48:24'),
(5, 'patienttest2@gmail.com', NULL, '$2y$12$cvLpTQfuGN1OquqkAMOjhuonLtuA/gPCUoXpeszCEuJpT6RI4JoEO', NULL, '2024-06-07 22:54:07', '2024-06-07 22:54:07'),
(6, 'doctortest1@gmail.com', NULL, '$2y$12$lMhwhIb1yBTyqmMyolDUK.7r0RhndbN1tJ621hfucNhrq1XQgOXv2', NULL, '2024-06-07 22:56:29', '2024-06-07 22:56:29'),
(7, 'doctortest2@gmail.com', NULL, '$2y$12$WANLHfrD2weQy0FVLTB/vOm7Vfvy.H1GApVBotUrTpYA4C8Re2mZ.', NULL, '2024-06-07 22:57:23', '2024-06-07 22:57:23'),
(8, 'patienttest3@gmail.com', NULL, '$2y$12$YvppG5k8RWslgKxJQ5tfuu5Ys6ELEZOwBh5ZTEgf5zcK3x1You4Vy', NULL, '2024-06-07 23:02:14', '2024-06-07 23:02:14'),
(9, 'doctortest3@gmail.com', NULL, '$2y$12$Ez6CEX7A8RXE0seTJCzF6edbEBAhVlHATK4ERYoxE6o/HUVPHUcDm', NULL, '2024-06-07 23:06:10', '2024-06-07 23:06:10');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD KEY `admins_user_id_foreign` (`user_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctors_user_id_foreign` (`user_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `medical_records`
--
ALTER TABLE `medical_records`
  ADD PRIMARY KEY (`id`),
  ADD KEY `medical_records_patient_id_foreign` (`patient_id`),
  ADD KEY `medical_records_doctor_id_foreign` (`doctor_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `patients_user_id_foreign` (`user_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `medical_records`
--
ALTER TABLE `medical_records`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admins`
--
ALTER TABLE `admins`
  ADD CONSTRAINT `admins_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `doctors`
--
ALTER TABLE `doctors`
  ADD CONSTRAINT `doctors_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `medical_records`
--
ALTER TABLE `medical_records`
  ADD CONSTRAINT `medical_records_doctor_id_foreign` FOREIGN KEY (`doctor_id`) REFERENCES `doctors` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `medical_records_patient_id_foreign` FOREIGN KEY (`patient_id`) REFERENCES `patients` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `patients`
--
ALTER TABLE `patients`
  ADD CONSTRAINT `patients_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
