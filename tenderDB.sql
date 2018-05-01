-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Хост: localhost:3306
-- Время создания: Окт 31 2017 г., 08:15
-- Версия сервера: 5.5.58-0ubuntu0.14.04.1
-- Версия PHP: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tenderDB`
--

-- --------------------------------------------------------

--
-- Структура таблицы `billingOptions`
--

CREATE TABLE `billingOptions` (
  `id` int(10) UNSIGNED NOT NULL,
  `groupId` int(10) UNSIGNED NOT NULL,
  `fullAccessTrial` int(11) NOT NULL DEFAULT '0',
  `periodicPayment` decimal(10,2) NOT NULL DEFAULT '0.00',
  `aperiodicPayment` decimal(10,2) NOT NULL DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `billingOptions`
--

INSERT INTO `billingOptions` (`id`, `groupId`, `fullAccessTrial`, `periodicPayment`, `aperiodicPayment`) VALUES
(1, 2, 0, '0.00', '0.00'),
(2, 3, 0, '0.00', '0.00');

-- --------------------------------------------------------

--
-- Структура таблицы `blog`
--

CREATE TABLE `blog` (
  `id` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `blog`
--

INSERT INTO `blog` (`id`, `userId`, `createdAt`) VALUES
(1, 1, '2017-08-23 09:23:12');

-- --------------------------------------------------------

--
-- Структура таблицы `blog_lang`
--

CREATE TABLE `blog_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `blogId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `blog_lang`
--

INSERT INTO `blog_lang` (`id`, `blogId`, `lang`, `title`, `text`) VALUES
(1, 1, 'en', 'пкпкпкп', '<p>кпкпкпк</p>\r\n'),
(2, 1, 'ru', 'кпкпкп', '<p>кпкпкпкп</p>\r\n'),
(3, 1, 'az', 'уакапка', '<p>ькпкпьщкп</p>\r\n\r\n<p>кпклтпкшопшокпо</p>\r\n\r\n<p>кпдпькщпокп</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `cities`
--

CREATE TABLE `cities` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `iso2` char(2) NOT NULL,
  `population` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cities`
--

INSERT INTO `cities` (`id`, `name`, `country`, `iso2`, `population`) VALUES
(1, 'Bakı', 'Azerbaijan', 'AZ', 2122300),
(2, 'Gəncə', 'Azerbaijan', 'AZ', 303268),
(3, 'Sumqayıt', 'Azerbaijan', 'AZ', 279159),
(4, 'Hacıvar', 'Azerbaijan', 'AZ', 94788),
(5, 'Şəki', 'Azerbaijan', 'AZ', 64968),
(6, 'Lənkəran', 'Azerbaijan', 'AZ', 60180),
(7, 'Yevlax', 'Azerbaijan', 'AZ', 53716),
(8, 'Göyçay', 'Azerbaijan', 'AZ', 35348),
(9, 'Tovuz', 'Azerbaijan', 'AZ', 12626),
(10, 'Qəbələ', 'Azerbaijan', 'AZ', 11867),
(11, 'Gədəbəy', 'Azerbaijan', 'AZ', 8657),
(12, 'Goranboy', 'Azerbaijan', 'AZ', 7333),
(13, 'Oğuz', 'Azerbaijan', 'AZ', 6876),
(14, 'Zaqatala', 'Azerbaijan', 'AZ', 0),
(15, 'Mingəçevir', 'Azerbaijan', 'AZ', 0),
(16, 'Xızı', 'Azerbaijan', 'AZ', 0),
(17, 'Xırdalan', 'Azerbaijan', 'AZ', 0),
(18, 'Heydərabad', 'Azerbaijan', 'AZ', 0),
(19, 'Zəngilan', 'Azerbaijan', 'AZ', 0),
(20, 'Ağstafa', 'Azerbaijan', 'AZ', 0),
(21, 'Ucar', 'Azerbaijan', 'AZ', 0),
(22, 'Göygöl', 'Azerbaijan', 'AZ', 0),
(23, 'Xocavənd', 'Azerbaijan', 'AZ', 0),
(24, 'Xaçmaz', 'Azerbaijan', 'AZ', 0),
(25, 'Kəlbəcər', 'Azerbaijan', 'AZ', 0),
(26, 'Yardımlı', 'Azerbaijan', 'AZ', 0),
(27, 'Daşkəsən', 'Azerbaijan', 'AZ', 0),
(28, 'Kürdəmir', 'Azerbaijan', 'AZ', 0),
(29, 'Hacıqabul', 'Azerbaijan', 'AZ', 0),
(30, 'Qax', 'Azerbaijan', 'AZ', 0),
(31, 'Qazax', 'Azerbaijan', 'AZ', 0),
(32, 'Tərtər', 'Azerbaijan', 'AZ', 0),
(33, 'Biləsuvar', 'Azerbaijan', 'AZ', 0),
(34, 'Şəmkir', 'Azerbaijan', 'AZ', 0),
(35, 'Qubadlı', 'Azerbaijan', 'AZ', 0),
(36, 'Quba', 'Azerbaijan', 'AZ', 0),
(37, 'Qusar', 'Azerbaijan', 'AZ', 0),
(38, 'Babək', 'Azerbaijan', 'AZ', 0),
(39, 'Füzuli', 'Azerbaijan', 'AZ', 0),
(40, 'Cəbrayıl', 'Azerbaijan', 'AZ', 0),
(41, 'Salyan', 'Azerbaijan', 'AZ', 0),
(42, 'Xocalı', 'Azerbaijan', 'AZ', 0),
(43, 'Astara', 'Azerbaijan', 'AZ', 0),
(44, 'Culfa', 'Azerbaijan', 'AZ', 0),
(45, 'Ağdaş', 'Azerbaijan', 'AZ', 0),
(46, 'Lerik', 'Azerbaijan', 'AZ', 0),
(47, 'Masallı', 'Azerbaijan', 'AZ', 0),
(48, 'Ağdam', 'Azerbaijan', 'AZ', 0),
(49, 'Beyləqan', 'Azerbaijan', 'AZ', 0),
(50, 'Ağsu', 'Azerbaijan', 'AZ', 0),
(51, 'Qobustan', 'Azerbaijan', 'AZ', 0),
(52, 'Bərdə', 'Azerbaijan', 'AZ', 0),
(53, 'Ordubad', 'Azerbaijan', 'AZ', 0),
(54, 'Balakən', 'Azerbaijan', 'AZ', 0),
(55, 'İsmayıllı', 'Azerbaijan', 'AZ', 0),
(56, 'Şuşa', 'Azerbaijan', 'AZ', 0),
(57, 'Samux', 'Azerbaijan', 'AZ', 0),
(58, 'Ağcabədi', 'Azerbaijan', 'AZ', 0),
(59, 'Ağdam', 'Azerbaijan', 'AZ', 0),
(60, 'Dəvəçi', 'Azerbaijan', 'AZ', 0),
(61, 'İmişli', 'Azerbaijan', 'AZ', 0),
(62, 'Saatlı', 'Azerbaijan', 'AZ', 0),
(63, 'Naxçıvan', 'Azerbaijan', 'AZ', 0),
(64, 'Siyəzən', 'Azerbaijan', 'AZ', 0),
(65, 'Şahbuz', 'Azerbaijan', 'AZ', 0),
(66, 'Cəlilabad', 'Azerbaijan', 'AZ', 0),
(67, 'Sabirabad', 'Azerbaijan', 'AZ', 0),
(68, 'Neftçala', 'Azerbaijan', 'AZ', 0),
(69, 'Laçın', 'Azerbaijan', 'AZ', 0),
(70, 'Naftalan', 'Azerbaijan', 'AZ', 0),
(71, 'Zərdab', 'Azerbaijan', 'AZ', 0),
(72, 'Şərur', 'Azerbaijan', 'AZ', 0),
(73, 'Qıvraq', 'Azerbaijan', 'AZ', 0);

-- --------------------------------------------------------

--
-- Структура таблицы `help`
--

CREATE TABLE `help` (
  `id` int(10) UNSIGNED NOT NULL,
  `sort` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `help`
--

INSERT INTO `help` (`id`, `sort`) VALUES
(2, 8),
(4, 1),
(5, 2),
(6, 3),
(7, 4),
(8, 5),
(9, 6),
(10, 7);

-- --------------------------------------------------------

--
-- Структура таблицы `help_lang`
--

CREATE TABLE `help_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `pageId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `help_lang`
--

INSERT INTO `help_lang` (`id`, `pageId`, `lang`, `title`, `text`) VALUES
(4, 2, 'en', 'Proposals to participants in tenders', '<p>To master the production of demanded, socially and economically significant goods;</p>\r\n\r\n<p>To begin preparation for participation in tenders through study of legislation on tenders;</p>\r\n\r\n<p>To improve your technical training to work on the platform;</p>\r\n\r\n<p>To prepare financial security for participation in procurement;</p>\r\n\r\n<p>To study attentively the tender documentation of the companies-customers;</p>\r\n\r\n<p>To draw up correctly the necessary documents.</p>\r\n'),
(5, 2, 'ru', 'Советы, желающему участвовать в тендерах', '<p>Осваивайте производство востребованных, социально и экономически значимых товаров;</p>\r\n\r\n<p>Начинайте подготовку к участию в тендерах через изучение законодательства по тендерам;</p>\r\n\r\n<p>Совершенствуйте свою техническую подготовку к работе на платформе;</p>\r\n\r\n<p>Подготовьте финансовое обеспечение для участия в закупках;</p>\r\n\r\n<p>Внимательно изучайте конкурсную документацию компаний-заказчиков;</p>\r\n\r\n<p>Правильно оформляйте необходимые документы.</p>\r\n'),
(6, 2, 'az', 'Tenderdə iştirak etmək istəyən şəxslərə tövsiyyələr', '<p>Daha tələbatlı, sosial və iqtisadi cəhətdən m&uuml;h&uuml;m məhsulların istehsalını &ouml;yrənin;</p>\r\n\r\n<p>Tenderlərdə tender qanunvericiliyinin &ouml;yrənilməsi yolu ilə iştirak etməyə hazırlıqlara başlayın;</p>\r\n\r\n<p>Platforma ilə işləmək &uuml;&ccedil;&uuml;n texniki hazırlığı təkmilləşdirin;</p>\r\n\r\n<p>Satınalmalarda iştirak &uuml;&ccedil;&uuml;n maliyyə təminatını hazırlayın;</p>\r\n\r\n<p>Sifariş&ccedil;i şirkətlərin m&uuml;sabiqə sənədlərini diqqətlə araşdırın;</p>\r\n\r\n<p>Zəruri sənədləri d&uuml;zg&uuml;n qaydada tərtib edin.</p>\r\n'),
(10, 4, 'en', 'What is a tender?', '<p>A tender is a reverse auction when there is one buyer of goods, work or services and several suppliers, representing a competitive basis. The announcement of the tender provides the buyer with the suppliers.&nbsp;</p>\r\n'),
(11, 4, 'ru', 'Что такое тендер? ', '<p>Тендер &ndash; это обратный аукцион, когда есть один закупщик товара, работы &nbsp;или услуги и несколько поставщиков, представляя собой конкурсную основу. Объявление тендера обеспечивает связь закупщика с поставщиками.&nbsp;</p>\r\n'),
(12, 4, 'az', 'Tender nədir? ', '<p>Тender - məhsul, işləri və ya xidmətləri əldə edən yeganə alıcı və bir-birinə rəqabət &ouml;z&uuml;l&uuml;n&uuml; yaradan bir ne&ccedil;ə satıcıdan ibarət auksiona əks anlayışdır. Tenderin elan edilməsi alıcı ilə satıcıların əlaqəsini təmin edir.</p>\r\n'),
(13, 5, 'en', 'Types of tenders', '<p>Tenders are of two types, state and commercial. Procurement for state needs is carried out on budgetary funds. Commercial tenders are different in that customers themselves determine the rules for conducting transactions, establish conditions and conduct tenders for own or raised funds.</p>\r\n\r\n<p>Tenders are growing in popularity around the world. According to statistics, about 30% of chaffers are posted specially for small and medium businesses.</p>\r\n'),
(14, 5, 'ru', 'Виды тендеров', '<p>Тендеры бывают двух видов, государственные и коммерческие.<strong> </strong>Закупки для государственных нужд осуществляются на бюджетные средства. Коммерческие тендеры отличаются тем, что заказчики сами определяют регламент проведения сделок, устанавливают условия и проводят тендеры на собственные или привлеченные средства.</p>\r\n\r\n<p>Тендеры приобретают в мире все большую популярность. По статистике около 30% торгов размещаются специально для малого и среднего бизнеса.</p>\r\n'),
(15, 5, 'az', 'Tenderin növləri', '<p>Tenderlər d&ouml;vlət və kommersiya olmaqla iki n&ouml;və b&ouml;l&uuml;n&uuml;r. D&ouml;vlət ehtiyyacları &uuml;&ccedil;&uuml;n satınalmalar b&uuml;dcə vəsaitləri əsasında həyata ke&ccedil;irilir. Kommersiya tenderlərinin fərqi ondan ibarətdir ki, burada m&uuml;ştərilərin &ouml;z&uuml; s&ouml;vdələşmələrin aparılması qaydalarını, şərtlərini m&uuml;əyyən edir, şəxsi və ya cəlb edilmiş vəsaitlər &uuml;zrə tenderləri həyata ke&ccedil;irir.</p>\r\n\r\n<p>Tenderlər getdikcə d&uuml;nyada daha &ccedil;ox məşhurlaşır. Statistikaya g&ouml;rə təqribən torqların 30%-i x&uuml;susi olaraq ki&ccedil;ik və orta biznes &uuml;&ccedil;&uuml;n yerləşdirilir.</p>\r\n'),
(16, 6, 'en', 'How does it work?', '<p>The platform will help You in obtaining price proposals for the purchase of goods in electronic form. For the application, You need to register and, using the control panel, create a tender. In one tender, within the same category, can be any number of positions. The information about the purchase is sent to the suppliers in accordance with the chosen business category. All tenders by category are sent directly to Your e-mail. You just have to join the tender corresponding to the specifics of Your work.</p>\r\n'),
(17, 6, 'ru', 'Как это работает?', '<p>Платформа поможет Вам в получение ценовых предложений на закупку товаров в электронном виде. Информация о закупке рассылается поставщикам, авторизированным на платформе, в соответствии с выбранной категорией. Все тендеры по категориям можно также увидеть прямо на платформе. Предложения по тендерам отправляются покупателям на электронную почту.</p>\r\n'),
(18, 6, 'az', 'Bu necə işləyir?', '<p>Platforma malların elektron şəkildə satınalması &uuml;&ccedil;&uuml;n qiymət təkliflərinin əldə edilməsində Sizə yardım g&ouml;stərəcək. M&uuml;raciət etmək &uuml;&ccedil;&uuml;n, Siz qeydiyyatdan ke&ccedil;məli və idarəetmə panelindən istifadə etməklə tender yaratmalısınız. Bir meyar &uuml;zrə bir tenderdə istənilən sayda vəziyyətlər ola bilər. Satınalmalar &uuml;zrə məlumatlar se&ccedil;ilmiş biznes meyarı &uuml;zrə platformamızda qeydiyyatdan ke&ccedil;ən satıcılara g&ouml;ndərilir. Meyarlar &uuml;zrə b&uuml;t&uuml;n tenderlər elektron po&ccedil;tunuza g&ouml;ndərilir. Sizə isə işlərinizin x&uuml;susiyyətinə uyğun gələn tenderə qoşulmaq qalır.</p>\r\n'),
(19, 7, 'en', 'Requirements to the supplier', '<p>The purchaser must establish technical requirements for the supplier. Tender documentation should contain technical and commercial part. To select the most profitable supplier and guarantees for its integrity, the purchaser has the right to demand from the supplier economic security for the performance of the contract.</p>\r\n'),
(20, 7, 'ru', 'Требования к поставщику', '<p>Закупщик должен установить технические требования к поставщику. Тендерная документация должна содержать техническую и коммерческую часть. Для выбора наиболее выгодного поставщика и гарантий его добросовестности, закупщик вправе потребовать от поставщика экономическое обеспечение исполнения контракта.</p>\r\n'),
(21, 7, 'az', 'Satıcıya tələblər', '<p>Satınalan şəxs satıcıya texniki tələblər m&uuml;əyyən etməlidir. Tender sənədləşməsi texniki və kommersiya hissələrindən ibarət olmalıdır. Ən əlverişli və vicdanlı olması zəmanətinin y&uuml;ksək olduğu satıcının se&ccedil;ilməsi &uuml;&ccedil;&uuml;n satınalan satıcıdan m&uuml;qavilənin icrasının iqtisadi təminatını tələb etmək h&uuml;ququna malikdir.</p>\r\n'),
(22, 8, 'en', 'Responsibility of suppliers', '<p>Failure to perform contractual obligations entails the entry of the company in the register of unfair suppliers and the need for compensation for damages.</p>\r\n'),
(23, 8, 'ru', 'Ответственность поставщиков', '<p>Неисполнение обязанностей по контракту влечет за собой попадание компании в реестр недобросовестных поставщиков и необходимость возмещения ущерба.</p>\r\n'),
(24, 8, 'az', 'Satıcıların məsuliyyəti', '<p>M&uuml;qavilə &uuml;zrə &ouml;hdəliklərin yerinə yetirilməməsi şirkətin qərəzli satıcıların reyestrinə d&uuml;şməsinə və təzminatın &ouml;dənilməsi zəruriliyinə gətirib &ccedil;ıxarır.</p>\r\n'),
(25, 9, 'en', 'Appeal procedure', '<p>The appeal&nbsp;must be recognized as justified and properly executed. The appeal&nbsp;must be accompanied by all the necessary documents indicating the fact of the breach by the buyer.</p>\r\n'),
(26, 9, 'ru', 'Процедура обжалования', '<p>Жалоба должна быть признана обоснованной и правильно оформленной. К жалобе должны прилагаться все необходимые документы, указывающие факт допущения нарушения закупщиком.</p>\r\n'),
(27, 9, 'az', 'Şikayət verilmə proseduru', '<p>Şikayət əsaslı və d&uuml;zg&uuml;n qaydada tərtib olunmalıdır. Həmin şikayətə satınalan tərəfindən pozuntuların yol verilməsi faktları qeyd edilmiş b&uuml;t&uuml;n zəruri sənədlər əlavə edilməlidir.</p>\r\n'),
(28, 10, 'en', 'Feedback', '<p>Using the feedback provided on the platform, You will be able to obtain any necessary information.</p>\r\n'),
(29, 10, 'ru', 'Обратная связь', '<p>Воспользовавшись обратной связью, указанной на платформе, Вы сможете получить любую необходимую для Вас информацию.</p>\r\n'),
(30, 10, 'az', 'Əlaqə', '<p>Bizə m&uuml;raciət etməklə, hər hansı bir&nbsp;zəruri məsələ ilə əlaqədar, hərtərəfli məlumat&nbsp;əldə edə bilərsiniz.&nbsp;</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `industries`
--

CREATE TABLE `industries` (
  `id` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `industries`
--

INSERT INTO `industries` (`id`) VALUES
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26),
(27),
(28),
(29);

-- --------------------------------------------------------

--
-- Структура таблицы `industries_lang`
--

CREATE TABLE `industries_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `industryId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `industries_lang`
--

INSERT INTO `industries_lang` (`id`, `industryId`, `lang`, `name`) VALUES
(13, 5, 'az', 'Tikinti və təmir'),
(14, 5, 'ru', 'Строительство и ремонт '),
(15, 5, 'en', 'Construction and building materials '),
(16, 6, 'az', 'Elektronika və elektron mallar'),
(17, 6, 'ru', 'Электроника и оборудование '),
(18, 6, 'en', 'Electronics and electronic equipment '),
(19, 7, 'az', 'Nəqliyyat və daşınma'),
(20, 7, 'ru', 'Транспорт и перевозки '),
(21, 7, 'en', 'Transport and logistic '),
(22, 8, 'az', 'Avtomobil, avto ehtiyat hissələri'),
(23, 8, 'ru', 'Авто-запчасти  '),
(24, 8, 'en', 'Automotive products '),
(25, 9, 'az', 'Neft, kimyəvi maddələr və əczaçılıq'),
(26, 9, 'ru', 'Нефть, химикаты и фармацевтические препараты'),
(27, 9, 'en', 'Oil, chemicals and pharmaceuticals'),
(28, 10, 'az', 'Energetika və xammal'),
(29, 10, 'ru', 'Энергетика и сырье  '),
(30, 10, 'en', 'Energy and raw materials '),
(31, 11, 'az', 'Tibb, klinikalar və kosmetika'),
(32, 11, 'ru', 'Медицина, клиники и косметика '),
(33, 11, 'en', 'Medicine, clinics and cosmetics '),
(34, 12, 'az', 'İT və telekommunikasiya'),
(35, 12, 'ru', 'ИТ и телекоммуникации '),
(36, 12, 'en', 'IT and communications '),
(37, 13, 'az', 'İstirahət və əyləncə'),
(38, 13, 'ru', 'Досуг и развлечения '),
(39, 13, 'en', 'Entertainment'),
(40, 14, 'az', 'Ərzaq məhsulları və ictimai iaşə'),
(41, 14, 'ru', 'Пищевые продукты и общепит  '),
(42, 14, 'en', 'Food products and catering '),
(43, 15, 'az', 'Reklam və poliqrafiya'),
(44, 15, 'ru', 'Реклама и полиграфия '),
(45, 15, 'en', 'Advertising, printing and publishing '),
(46, 16, 'en', 'Tourism and recreation '),
(47, 16, 'ru', 'Туризм и отдых '),
(48, 16, 'az', 'Turizm və istirahət'),
(49, 17, 'en', 'Science and education '),
(50, 17, 'ru', 'Наука и образование '),
(51, 17, 'az', 'Elm və təhsil'),
(52, 18, 'en', 'Wood and furniture productions '),
(53, 18, 'ru', 'Мебель'),
(54, 18, 'az', 'Mebel'),
(55, 19, 'en', 'Industry'),
(56, 19, 'ru', 'Промышленность'),
(57, 19, 'az', 'Sənaye'),
(58, 20, 'en', 'Finance and insurance '),
(59, 20, 'ru', 'Финансы и страхование '),
(60, 20, 'az', 'Maliyyə və sığorta'),
(61, 21, 'en', 'Legal services '),
(62, 21, 'ru', 'Юридические услуги '),
(63, 21, 'az', 'Hüquqi xidmətlər'),
(64, 22, 'en', 'Sport, health and beauty '),
(65, 22, 'ru', 'Спорт, здоровье и красота '),
(66, 22, 'az', 'İdman, sağlamlıq və gözəllik'),
(67, 23, 'en', 'Pets and plans '),
(68, 23, 'ru', 'Животные и растения  '),
(69, 23, 'az', 'Heyvanlar və bitkilər'),
(70, 24, 'en', 'Safety and security '),
(71, 24, 'ru', 'Безопасность, охрана '),
(72, 24, 'az', 'Təhlükəsizlik, mühafizə'),
(73, 25, 'en', 'Agriculture '),
(74, 25, 'ru', 'Сельское хозяйство '),
(75, 25, 'az', 'Kənd təsərrüfatı'),
(76, 26, 'en', 'Utility services '),
(77, 26, 'ru', 'Коммунальные службы '),
(78, 26, 'az', 'Kommunal xidmətlər'),
(79, 27, 'en', 'Engineering'),
(80, 27, 'ru', 'Инженерия '),
(81, 27, 'az', 'Mühəndislik '),
(82, 28, 'en', 'Textile production '),
(83, 28, 'ru', 'Текстильное производство '),
(84, 28, 'az', 'Tekstil istehsalı'),
(85, 29, 'en', 'Professional equipment'),
(86, 29, 'ru', 'Профессиональное оборудование '),
(87, 29, 'az', 'Peşəkar avadanlıqlar');

-- --------------------------------------------------------

--
-- Структура таблицы `mailerQueue`
--

CREATE TABLE `mailerQueue` (
  `id` int(10) UNSIGNED NOT NULL,
  `mail_from` varchar(255) NOT NULL,
  `name_from` varchar(255) NOT NULL,
  `mail_to` varchar(255) NOT NULL,
  `name_to` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `sendAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `mailerQueue`
--

INSERT INTO `mailerQueue` (`id`, `mail_from`, `name_from`, `mail_to`, `name_to`, `subject`, `text`, `status`, `createdAt`, `sendAt`) VALUES
(1, 'noreply@example.com', 'tenders.az', 'zzzxx@zz.com', 'qqqqqqqqqqqqq', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/6\">New Tender 21.08.17 11:35</a>\n        </p>\n        <br>\n        <p>Описание: Tender1</p>\n    </body>\n</html>', 1, '2017-08-28 08:34:35', '2017-10-30 13:49:45'),
(2, 'noreply@example.com', 'tenders.az', 'r.c.rustam@gmail.com', 'Pro100', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/6\">New Tender 21.08.17 11:35</a>\n        </p>\n        <br>\n        <p>Описание: Tender1</p>\n    </body>\n</html>', 1, '2017-08-28 08:34:35', '2017-10-30 13:49:46'),
(3, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/9\">Router </a>\n        </p>\n        <br>\n        <p>Описание: Router </p>\n    </body>\n</html>', 1, '2017-08-29 06:09:42', '2017-10-30 13:49:46'),
(4, 'noreply@example.com', 'tenders.az', 'zzzxx@zz.com', 'qqqqqqqqqqqqq', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/10\">new tender</a>\n        </p>\n        <br>\n        <p>Описание: new tender</p>\n    </body>\n</html>', 1, '2017-08-29 11:26:57', '2017-10-30 13:49:46'),
(5, 'noreply@example.com', 'tenders.az', 'r.c.rustam@gmail.com', 'Pro100', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/10\">new tender</a>\n        </p>\n        <br>\n        <p>Описание: new tender</p>\n    </body>\n</html>', 1, '2017-08-29 11:26:57', '2017-10-30 13:49:46'),
(6, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/11\">еще один тендер</a>\n        </p>\n        <br>\n        <p>Описание: еще один раз</p>\n    </body>\n</html>', 1, '2017-08-29 11:38:08', '2017-10-30 13:49:46'),
(7, 'noreply@example.com', 'tenders.az', 'zzzxx@zz.com', 'qqqqqqqqqqqqq', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/12\">тендер 2</a>\n        </p>\n        <br>\n        <p>Описание: тендер 2</p>\n    </body>\n</html>', 1, '2017-08-29 11:40:20', '2017-10-30 13:49:46'),
(8, 'noreply@example.com', 'tenders.az', 'r.c.rustam@gmail.com', 'Pro100', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/12\">тендер 2</a>\n        </p>\n        <br>\n        <p>Описание: тендер 2</p>\n    </body>\n</html>', 1, '2017-08-29 11:40:20', '2017-10-30 13:49:46'),
(9, 'noreply@example.com', 'tenders.az', 'rustam.rustamov@pmdgroup.az', 'IdbI Group', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/12\">тендер 2</a>\n        </p>\n        <br>\n        <p>Описание: тендер 2</p>\n    </body>\n</html>', 1, '2017-08-29 11:40:20', '2017-10-30 13:49:46'),
(10, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/13\">Компьютеры</a>\n        </p>\n        <br>\n        <p>Описание: Компьютеры</p>\n    </body>\n</html>', 1, '2017-08-30 08:34:34', '2017-10-30 13:49:46'),
(11, 'noreply@example.com', 'tenders.az', 'zeuz1@list.ru', 'Test suplier 2', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/15\">test</a>\n        </p>\n        <br>\n        <p>Описание: test</p>\n    </body>\n</html>', 1, '2017-09-06 09:44:08', '2017-10-30 14:30:01'),
(12, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/14\">Для модерации</a>\n        </p>\n        <br>\n        <p>Описание: проверить</p>\n    </body>\n</html>', 1, '2017-09-12 09:56:23', '2017-10-30 14:30:01'),
(13, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/ru/tenders/18\">tender test</a>\n        </p>\n        <br>\n        <p>Описание: test</p>\n    </body>\n</html>', 1, '2017-09-25 10:25:25', '2017-10-30 14:30:01'),
(14, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/az/tenders/16\">Для еды и питья компании</a>\n        </p>\n        <br>\n        <p>Описание: Для еды и питья компании ------------ краткое описание-------------без деталей</p>\n    </body>\n</html>', 1, '2017-10-02 05:35:30', '2017-10-30 14:30:01'),
(15, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендены', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендены</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://tend.netant.az/ru/tenders/20\">покупка домена и создание сайта</a>\n        </p>\n        <br>\n        <p>Описание: покупка домена и создание сайта ----- короткое описание</p>\n    </body>\n</html>', 1, '2017-10-13 07:41:13', '2017-10-30 14:30:02'),
(16, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>Tenders</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://mytender.az/ru/tenders/19\">Test foot and Beverage</a>\n        </p>\n        <br>\n        <p>Описание: Test foot and Beverage -------- short description</p>\n    </body>\n</html>', 1, '2017-10-20 12:39:25', '2017-10-30 14:30:02'),
(17, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>mytender</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://mytender.az/ru/tenders/22\">RR</a>\n        </p>\n        <br>\n        <p>Описание: Kkkd</p>\n    </body>\n</html>', 1, '2017-10-21 18:01:21', '2017-10-30 14:30:02'),
(18, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>mytender</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"http://mytender.az/ru/tenders/17\">TV</a>\n        </p>\n        <br>\n        <p>Описание: TV</p>\n    </body>\n</html>', 1, '2017-10-21 18:02:37', '2017-10-30 14:30:02'),
(19, 'noreply@example.com', 'tenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>mytender</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"http://mytender.az/az/tenders/21\">üefrtyui</a>\n        </p>\n        <br>\n        <p>Təsvir: Test foot and Beverage -------- short description</p>\n    </body>\n</html>', 1, '2017-10-22 10:28:22', '2017-10-30 14:30:02'),
(20, 'noreply@example.com', 'tenders.az', 'rustam.rustamov@pmdgroup.az', 'IdbI Group', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>mytender</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"http://mytender.az/az/tenders/21\">üefrtyui</a>\n        </p>\n        <br>\n        <p>Təsvir: Test foot and Beverage -------- short description</p>\n    </body>\n</html>', 1, '2017-10-22 10:28:22', '2017-10-30 14:30:02'),
(21, 'noreply@example.com', 'mytenders.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDERS</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"http://mytender.az/az/tenders/28\">Test</a>\n        </p>\n        <br>\n        <p>Təsvir: qqqqqq</p>\n    </body>\n</html>', 1, '2017-10-25 06:55:50', '2017-10-30 15:30:01'),
(22, 'noreply@example.com', 'mytenders.az', 'rustam.rustamov@pmdgroup.az', 'IdbI Group', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDERS</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"http://mytender.az/az/tenders/28\">Test</a>\n        </p>\n        <br>\n        <p>Təsvir: qqqqqq</p>\n    </body>\n</html>', 1, '2017-10-25 06:55:50', '2017-10-30 15:30:01'),
(23, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/26\">mail.mytender.az</a>\n        </p>\n        <br>\n        <p>Təsvir: xdcfgv</p>\n    </body>\n</html>', 1, '2017-10-26 08:01:26', '2017-10-30 15:30:01'),
(24, 'noreply@mytender.az', 'mytender.az', 'taleh@pooltech.az', 'Pooltech MMC', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/26\">mail.mytender.az</a>\n        </p>\n        <br>\n        <p>Təsvir: xdcfgv</p>\n    </body>\n</html>', 1, '2017-10-26 08:01:26', '2017-10-30 15:30:01'),
(25, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/27\">züxeri</a>\n        </p>\n        <br>\n        <p>Təsvir: erytuyiuiopöcfgvbhjn</p>\n    </body>\n</html>', 1, '2017-10-26 08:09:55', '2017-10-30 15:30:02'),
(26, 'noreply@mytender.az', 'mytender.az', 'taleh@pooltech.az', 'Pooltech MMC', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/27\">züxeri</a>\n        </p>\n        <br>\n        <p>Təsvir: erytuyiuiopöcfgvbhjn</p>\n    </body>\n</html>', 1, '2017-10-26 08:09:55', '2017-10-30 15:30:02'),
(27, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/29\">Test</a>\n        </p>\n        <br>\n        <p>Təsvir: Test</p>\n    </body>\n</html>', 1, '2017-10-26 08:10:26', '2017-10-30 15:30:02'),
(28, 'noreply@mytender.az', 'mytender.az', 'taleh@pooltech.az', 'Pooltech MMC', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/29\">Test</a>\n        </p>\n        <br>\n        <p>Təsvir: Test</p>\n    </body>\n</html>', 1, '2017-10-26 08:10:26', '2017-10-30 15:30:02'),
(29, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/31\">Anty Boss</a>\n        </p>\n        <br>\n        <p>Описание: Нефтехимическое состовляющее</p>\n    </body>\n</html>', 1, '2017-10-27 19:20:17', '2017-10-30 15:30:02'),
(30, 'noreply@mytender.az', 'mytender.az', 'taleh@pooltech.az', 'Pooltech MMC', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/31\">Anty Boss</a>\n        </p>\n        <br>\n        <p>Описание: Нефтехимическое состовляющее</p>\n    </body>\n</html>', 1, '2017-10-27 19:20:17', '2017-10-30 15:30:02'),
(31, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'New tenders', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>New tenders</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/en/tenders/32\">Transport Tender</a>\n        </p>\n        <br>\n        <p>Description: Transport Tender -------- short description</p>\n    </body>\n</html>', 1, '2017-10-30 08:27:35', '2017-10-30 16:30:01'),
(32, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'New tenders', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>New tenders</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/en/tenders/33\">Transport Tender 2</a>\n        </p>\n        <br>\n        <p>Description: Test foot and Beverage -------- short description</p>\n    </body>\n</html>', 1, '2017-10-30 08:30:38', '2017-10-30 16:30:01'),
(33, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/34\">IT </a>\n        </p>\n        <br>\n        <p>Описание: Computers and ups</p>\n    </body>\n</html>', 1, '2017-10-30 14:23:44', '2017-10-30 16:30:02'),
(34, 'noreply@mytender.az', 'mytender.az', 'rustam.rustamov@pmdgroup.az', 'INNEXIM', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/34\">IT </a>\n        </p>\n        <br>\n        <p>Описание: Computers and ups</p>\n    </body>\n</html>', 1, '2017-10-30 14:23:44', '2017-10-30 16:30:02'),
(35, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/35\">Кабельные коммуникации</a>\n        </p>\n        <br>\n        <p>Описание: Кабельные коммуникации</p>\n    </body>\n</html>', 1, '2017-10-30 16:03:49', '2017-10-30 16:30:02'),
(36, 'noreply@mytender.az', 'mytender.az', 'rustam.rustamov@pmdgroup.az', 'INNEXIM', 'Новые тендеры', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Новые тендеры</h3>\n        <br>\n        <p>\n            Тендер:\n            <a href=\"https://mytender.az/ru/tenders/35\">Кабельные коммуникации</a>\n        </p>\n        <br>\n        <p>Описание: Кабельные коммуникации</p>\n    </body>\n</html>', 1, '2017-10-30 16:03:49', '2017-10-30 16:30:02'),
(37, 'noreply@mytender.az', 'mytender.az', 'evilkraft@gmail.com', 'Test suplier', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/36\">HUB installing</a>\n        </p>\n        <br>\n        <p>Təsvir: HUBS and SWITCHS</p>\n    </body>\n</html>', 1, '2017-10-31 06:28:35', '2017-10-31 06:30:01'),
(38, 'noreply@mytender.az', 'mytender.az', 'rustam.rustamov@pmdgroup.az', 'INNEXIM', 'Yeni tenderlər', '<!DOCTYPE html>\n<html lang=\"en\">\n    <head>\n        <title>MYTENDER</title>\n    </head>\n    <body>\n        <h3>Yeni tenderlər</h3>\n        <br>\n        <p>\n            Tender:\n            <a href=\"https://mytender.az/az/tenders/36\">HUB installing</a>\n        </p>\n        <br>\n        <p>Təsvir: HUBS and SWITCHS</p>\n    </body>\n</html>', 1, '2017-10-31 06:28:35', '2017-10-31 06:30:01');

-- --------------------------------------------------------

--
-- Структура таблицы `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `alias` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pages`
--

INSERT INTO `pages` (`id`, `alias`) VALUES
(2, 'about'),
(3, 'blog'),
(1, 'contacts'),
(5, 'partners'),
(6, 'rules'),
(4, 'services'),
(7, 'why');

-- --------------------------------------------------------

--
-- Структура таблицы `pages_lang`
--

CREATE TABLE `pages_lang` (
  `id` int(10) UNSIGNED NOT NULL,
  `pageId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `keywords` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pages_lang`
--

INSERT INTO `pages_lang` (`id`, `pageId`, `lang`, `title`, `keywords`, `description`, `text`) VALUES
(1, 1, 'en', 'Contacts', '', '', '<p>office@mytender.az</p>\r\n'),
(2, 1, 'ru', 'Контакты', '', '', '<p>office@mytender.az</p>\r\n'),
(3, 1, 'az', 'Əlaqə', '', '', '<p>office@mytender.az</p>\r\n'),
(4, 2, 'en', 'About us', '', '', '<p>The platform mytender.az is a practical and complete&nbsp;solution for conducting business activities in the B2B (business-to-business) segment, focused on providing reliable and high-quality services in the field of procurement.</p>\r\n\r\n<p><strong>Our mission:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><small>To provide assistance to the business segment in finding new business opportunities;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>To assist in conducting transparent and effective business activities;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>To make the business accessible and competitive;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>To meet the standards of international business.</small></p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Mytender.az is a platform for entrepreneurs who will become a catalyst for each other in conducting of mutually beneficial and successful business. The platform is a kind of link in the provision of opportunities to promote, implement and develop trade and market relations.</p>\r\n\r\n<p>Mytender.az is a platform for business, for all who appreciate their time and money.</p>\r\n'),
(5, 2, 'ru', 'О нас', '', '', '<p>Платформа mytender.az &ndash; представляет собой практичное и комплексное решение для ведения предпринимательской деятельности в сегменте B2B (business-to-business), ориентированный на оказании надежных и качественных услуг в сфере закупок.</p>\r\n\r\n<p><strong>Наша миссия:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><small>Предоставить содействие бизнес-сегменту в нахождении новых бизнес возможностей;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Помощь в ведении прозрачной и эффективной предпринимательской деятельности;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Сделать бизнес доступным и конкурентоспособным;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Соответствовать стандартам международного бизнеса.</small></p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Mytender.az &ndash; платформа для предпринимателей, которые станут катализатором друг для друга в ведении взаимовыгодного и успешного бизнеса. Платформа является своего рода связующим звеном в предоставлении возможности продвигать, реализовывать и развивать торгово-рыночные отношения.</p>\r\n\r\n<p>Mytender.az &ndash; это платформа для бизнеса, для всех кто ценит свое время и деньги.</p>\r\n'),
(6, 2, 'az', 'Haqqımızda', '', '', '<p>Mytender.az platforması &nbsp;satınalmalar sahəsində etibarlı və keyfiyyətli xidmətlərin g&ouml;stərilməsinə istiqamətlənmiş B2B (business-to-business) seqmentində sahibkarlıq fəaliyyətinin aparılması &uuml;&ccedil;&uuml;n praktiki və kompleks həllərdən ibarətdir.</p>\r\n\r\n<p><strong>Missiyamız</strong><strong>:</strong></p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><small>Yeni biznes imkanlarının tapılması &uuml;zrə biznes-seqmentinə yardım g&ouml;stərmək;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Şəffaf və səmərəli sahibkarlıq fəaliyyətinin aparılmasına k&ouml;mək etmək;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Biznesin əl&ccedil;atan və rəqabətədavamlı olmasını təmin etmək;</small></p>\r\n	</li>\r\n	<li>\r\n	<p><small>Beynəxalq biznes standartları ilə uyğunlaşmaq.</small></p>\r\n	</li>\r\n</ul>\r\n\r\n<p>Mytender.az - qarşılıqlı faydalı və uğurlu biznesin aparılmasında qarşılıqlı olaraq bir-birinə katalizator olacaq sahibkarlar &uuml;&ccedil;&uuml;n nəzərdə tutulmuş platformadır. Bu platforma ticarət və bazar m&uuml;nasibətlərinin təşviq edilməsi, həyata ke&ccedil;irilməsi və inkişaf etdirilməsi imkanlarının təmin edilməsi &uuml;zrə bir n&ouml;v k&ouml;rp&uuml; olacaqdır.</p>\r\n\r\n<p>Mytender.az - biznes, həm&ccedil;inin vaxtını və pulunu dəyərləndirən şəxslər &uuml;&ccedil;&uuml;n platformadır.</p>\r\n'),
(7, 3, 'en', 'The Blog', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(8, 3, 'ru', 'Блог', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(9, 3, 'az', 'Blog', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(10, 4, 'en', 'Our services', '', '', '<p>The platform mytender.az provides the following services to entrepreneurs:</p>\r\n\r\n<p>✔&nbsp; Tender support and execution of cases of a person wishing to participate in the transaction;</p>\r\n\r\n<p>✔&nbsp; Selection of tenders, which correspond to the purposes and desires of the customer;</p>\r\n\r\n<p>✔&nbsp; Legal and expert evaluation of the order, tender documentation, possible risks;</p>\r\n\r\n<p>✔&nbsp; Preparation and execution of applications;</p>\r\n\r\n<p>✔&nbsp; Consulting activities at all stages of the tender process;</p>\r\n\r\n<p>✔&nbsp; Consulting in the B2B segment;</p>\r\n\r\n<p>✔&nbsp; Business announcements and mailings for new projects, start-ups and tenders.</p>\r\n\r\n<p>* The above services are paid. For additional information, please contact by e-mail office@mytender.az&nbsp;</p>\r\n'),
(11, 4, 'ru', 'Услуги', '', '', '<p>Платформа mytender.az предоставляет следующие услуги предпринимателям:</p>\r\n\r\n<p>✔&nbsp; Тендерное сопровождение и оформление дел лица, желающего принять участие в сделке;</p>\r\n\r\n<p>✔&nbsp; Подбор тендеров, которые соответствуют целям и желаниям заказчика;</p>\r\n\r\n<p>✔&nbsp; Юридическая и экспертная оценка заказа, тендерной документации, возможных рисков;</p>\r\n\r\n<p>✔&nbsp; Подготовка и оформление заявок;</p>\r\n\r\n<p>✔&nbsp; Консультационная деятельность на всех этапах тендерного процесса;</p>\r\n\r\n<p>✔&nbsp; Консалтинг в сегменте B2B;</p>\r\n\r\n<p>✔&nbsp; Бизнес-объявления и рассылки по новым проектам, стратапам и тендерам.</p>\r\n\r\n<p>*Вышеуказанные услуги являются платными. Для того чтобы воспользоваться указанными услугами, пожалуйста оставьте заявку по электронной почте: office@mytender.az</p>\r\n'),
(12, 4, 'az', 'Xidmətlər', '', '', '<p>Mytender.az platforması sahibkarlara aşağıdakı xidmətləri g&ouml;stərir:</p>\r\n\r\n<p>✔&nbsp; Tender m&uuml;şayiəti və s&ouml;vdələşmədə iştirak etmək istəyən şəxsin sənədlərinin qeydiyyatı;</p>\r\n\r\n<p>✔&nbsp; Sifariş&ccedil;inin məqsədlərinə və istəklərinə uyğun gələn tenderlərin se&ccedil;ilməsi;</p>\r\n\r\n<p>✔&nbsp; Sifarişin, tender sənədlərinin, m&uuml;mk&uuml;n risklərin h&uuml;quqi və ekspert qiymətləndirilməsi;</p>\r\n\r\n<p>✔&nbsp; M&uuml;raciətlərin hazırlanması və qeydiyyatının aparılması;</p>\r\n\r\n<p>✔&nbsp; Tender prosesinin b&uuml;t&uuml;n mərhələlərində məsləhət&ccedil;ilik fəaliyyəti;</p>\r\n\r\n<p>✔&nbsp; B2B seqmenti &uuml;zrə konsaltinq;</p>\r\n\r\n<p>✔&nbsp; Biznes elanları və yeni layihələr, start-aplar və tenderlər &uuml;zrə paylaşmalar.</p>\r\n\r\n<p>*Yuxarıda qeyd olunan xidmətlər &ouml;dənişlidir. Qeyd olunan xidmətlərdən istifadə etmək &uuml;&ccedil;&uuml;n zəhmət olmasa office@mytender.az elektron po&ccedil;tuna əmri&nbsp;&uuml;zrə əlaqə saxlamağınız xahiş olunur.</p>\r\n'),
(13, 5, 'en', 'Our partners', '', '', ''),
(14, 5, 'ru', 'Партнеры', '', '', ''),
(15, 5, 'az', 'Tərəfdaşlarımız', '', '', ''),
(16, 6, 'en', 'Terms of Use and Privacy Policy', '', '', '<p><strong>1. Basic provisions</strong>. Mytender.az (hereinafter - the platform) undertakes to keep your privacy on the Internet. This Privacy Policy is about the collection, procession and storage of your personal data. This platform attaches high priority to protecting the personal information of users. By using the platform, the user agrees to the application of the rules for the collection and use of the data set forth in this document.</p>\r\n\r\n<p><strong>2. Information</strong><strong>.</strong></p>\r\n\r\n<p><strong>2.1 Information collected. </strong>The platform collects the following data about the users of the site:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Full name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● E-mail address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Phone number</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Taxpayer ID</p>\r\n\r\n<p><strong>2.2&nbsp;Use of information</strong><strong>. </strong>Here are some ways to use the user&#39;s personal information:<strong> </strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to provide information and services that the user requests;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to respond to user requests.</p>\r\n\r\n<p><strong>2.3 Storage of information. </strong>The platform stores your personal information for the duration of the activity of your user account or for the time necessary to provide you with services. We can store personal information even after deactivating your user account and / or stopping the use of any specific services,&nbsp;to the extent necessary for the performance of our legal duties, for resolving disputes with users of the&nbsp;platform, preventing fraud and abuse, execution of our agreements and protection of our legitimate interests.</p>\r\n\r\n<p><strong>2.4 Information disclosure</strong><strong>. </strong>The platform does not transfer the user&#39;s personal data to third parties without the user&#39;s consent. The platform reserves the right to delete invalid accounts or accounts with forged names and registration data.</p>\r\n\r\n<p><strong>3. Advertising messages. </strong>By providing your email address or any other contact information (for example, your phone number or username on the social network), you agree to receive promotional messages, messages or calls from the platform staff. Accordingly, the platform employees have the right to call or send you mailings or messages via e-mail, SMS, personal text messages, make marketing calls or use similar&nbsp;forms communication. If you do not want to receive such advertisements or calls, you can notify the platform at any time, or follow the instructions on unsubscribing contained in the advertisements you received.</p>\r\n\r\n<p><strong>4. Security. </strong>The platform has adopted security measures designed to protect the personal information that you share with us, including physical, electronic and procedural measures. Among other things, the platform offers secure access to most of our services using the HTTPS protocol; transfer of confidential payment information (for example, a credit card number) through our specially designed forms that are protected by an encrypted connection of the industry standard SSL / TLS. The platform also regularly monitors the system for possible vulnerabilities and attacks, and is constantly looking for new solutions to improve the security of our services.</p>\r\n\r\n<p><strong>5. Terms of use</strong>.</p>\r\n\r\n<p><strong>5.1</strong> The platform asks users to avoid conflict situations and other violations, which can lead to undesirable consequences. In case this happens, the platform, having analyzed the situation, undertakes to act appropriately to prevent such actions henceforth.</p>\r\n\r\n<p><strong>5.2</strong> This Privacy policy, its interpretation, and any claims and disputes related to this instrument are regulated, interpreted and executed only and exclusively in accordance with the basic internal laws of the Republic of Azerbaijan. Hereby, you agree that any claims and disputes shall be resolved only by a competent court&nbsp;located in the Republic of Azerbaijan.</p>\r\n\r\n<p><strong>6. Deleting</strong><strong> </strong><strong>an</strong><strong> </strong><strong>account</strong><strong>. </strong>You can request the removal of your Personal Information from our blogs, communities or forums by contacting us at to the addresses: <a href=\"mailto:info@mytender.az\">info@mytender.az</a> or <a href=\"mailto:privacy@mytender.az\">privacy@mytender.az</a>.</p>\r\n'),
(17, 6, 'ru', 'Правила пользования и политика конфиденциальности.', '', '', '<p><strong>1. Основные положения. </strong>Mytender.az (далее &ndash; платформа) обязуется хранить Вашу конфиденциальность в сети Интернет.&nbsp;Настоящая Политика Конфиденциальности, рассказывает о том, как собираются, обрабатываются и хранятся Ваши личные данные. Данная платформа уделяет большое внимание защите личной информации пользователей.&nbsp;Пользуясь платформой, пользователь дает согласие на применение правил сбора и использования данных, изложенных в настоящем документе.&nbsp;</p>\r\n\r\n<p><strong>2. Информация.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;Собираемая информация. </strong>Платформа собирает следующую информацию о пользователях сайта:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Фамилия, Имя</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Адрес электронной почты</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Номер телефона</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Название компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Адрес компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Идентификационный номер налогоплательщика</p>\r\n\r\n<p><strong>2.2&nbsp;Использование информации. </strong>Ниже описаны некоторые способы использования личной информации пользователя:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для предоставления информации и услуг, которые&nbsp;&nbsp;запрашивает пользователь;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для ответа на запросы пользователя.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Хранение информации. </strong>Платформа хранит вашу персональную информацию в течение всего времени активности вашей пользовательской учётной записи либо в течение времени, необходимого для оказания вам услуг. Хранение персональной информации может осуществляться нами даже после деактивации вашей пользовательской учётной записи и/или прекращения использования каких-либо конкретных услуг, в той мере, какой это необходимо для исполнения наших юридических обязанностей, для урегулирования споров в отношении пользователей платформы, предотвращения мошенничества и злоупотреблений, исполнения наших соглашений и защиты наших законных интересов.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong><strong>Раскрытие информации</strong><strong>. </strong>Платформа не продает личные данные пользователя и не передает их третьим лицам без согласия на то пользователя. Платформа оставляет за собой право удалять недействительные учетные записи или учетные записи с поддельными названиями и регистрационными данными.</p>\r\n\r\n<p><strong>3.&nbsp;Рекламные сообщения. </strong>Предоставляя адрес вашей электронной почты или любую другую контактную информацию (например, ваш номер телефона или имя пользователя в социальной сети), вы соглашаетесь на получение рекламных рассылок, сообщений или звонков от сотрудников платформы. Соответственно, сотрудники платформы, вправе звонить или направлять вам рекламные рассылки или сообщения по электронной почте, SMS, личные текстовые сообщения, делать маркетинговые звонки или использовать аналогичные формы общения. Если вы не хотите получать такие рекламные сообщения или звонки, вы можете уведомить платформу в любое время, или выполнить инструкции по отказу от подписки, содержащиеся в рекламных сообщениях, которые вы получили.</p>\r\n\r\n<p><strong>4.&nbsp;Безопасность. </strong>Платформа приняла меры безопасности, предназначенные для защиты персональной информации, которой вы делитесь с нами, в том числе физические, электронные и процедурные меры. Среди прочего, платформа предлагает безопасный доступ к большинству ресурсов наших услуг по протоколу HTTPS; передачу конфиденциальной информации по оплате (например, номер кредитной карты) через наши специально разработанные формы, которые защищены шифрованным соединением отраслевого стандарта SSL/TLS. Платформа также регулярно отслеживает систему на предмет возможных уязвимых мест и атак, и постоянно ищем новые решения для повышения безопасности наших услуг.</p>\r\n\r\n<p><strong>5.&nbsp;Правила пользования.</strong></p>\r\n\r\n<p><strong>5.1 &nbsp;</strong>Платформа просит пользователей<strong> </strong>избегать конфликтные ситуации и другие нарушения, которые могут повлечь за собою нежелательные последствия. В случае если такое имеет место быть, платформа, проанализировав ситуацию обязуется предпринять надлежащие меры по недопущению подобных действий впредь.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Настоящая политика конфиденциальности, её толкование, и любые претензии и споры, связанные с настоящим документом, регулируются, трактуются и исполняются только и исключительно в соответствии с основными внутренними законами Азерабайджанской Республики. Настоящим, вы соглашаетесь, что любые претензии и споры подлежат разрешению исключительно компетентным судом, находящимся в Азербайджанской Республике.</p>\r\n\r\n<p><strong>6.&nbsp;Удаление учетной записи. </strong>Вы можете запросить удаление вашей Персональной информации из наших блогов, сообществ или форумов, обратившись к нам по адресу: <a href=\"mailto:info@mytender.az\">info@mytender.az</a> или <a href=\"mailto:privacy@mytender.az\">privacy@mytender.az</a></p>\r\n'),
(18, 6, 'az', 'İstifadə qaydaları və məxfilik siyasəti.', '', '', '<p><strong>1. Əsas m&uuml;ddəalar.</strong><strong> </strong>Mytender.az (bundan sonra platforma adlandırılacaq) İnternet şəbəkəsində məxfiliyinizi qorumağı &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r. Hazırki Məxfilik Siyasəti Sizin şəxsi məlumatlarınızın toplanması, işlənməsi və saxlanılması barədə məlumatları ehtiva edir. Platformadan istifadə etməklə istifadə&ccedil;i hazırki sənəddə yer alan məlumatların toplanması və istifadəsi qaydalarının tətbiq edilməsinə razılığını bildirir.</p>\r\n\r\n<p><strong>2. Məlumat.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;</strong><strong>Toplanılan məlumat</strong><strong>. </strong>Platforma sayt istifadə&ccedil;iləri haqqında aşağıdakı məlumatları toplayır:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Adı, soyadı</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Elektron po&ccedil;t &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Telefon n&ouml;mrəsini</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin adını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Vergi &ouml;dəyicisinin eyniləşdirmə n&ouml;mrəsini</p>\r\n\r\n<p><strong>2.2&nbsp;</strong><strong>Məlumatların istifadə edilməsi. </strong>Aşağıda istifadə&ccedil;inin şəxsi məlumatlarının bir ne&ccedil;ə istifadə yolları təsvir edilmişdir:<br />\r\n&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● istifadə&ccedil;inin tələb etdiyi məlumatların və xidmətlərin təqdim edilməsi &uuml;&ccedil;&uuml;n;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● istifadə&ccedil;inin m&uuml;raciətlərinə cavab vernək &uuml;&ccedil;&uuml;n.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Məlumatların saxlanılması. </strong>Platforma sizin şəxsi məlumatlarınızı istifadə&ccedil;i hesabınızın aktiv olduğu m&uuml;ddətdə və ya xidmətlərin g&ouml;stərilməsi &uuml;&ccedil;&uuml;n zəruri olan vaxt ərzində saxlayır. Şəxsi məlumatların saxlanılması h&uuml;quqi &ouml;hdəliklərimizin yerinə yetirilməsinin, platforma istifadə&ccedil;ilərinin m&uuml;bahisələrinin tənzimlənməsinin, saxtakarlığın və sui-istifadənin qarşısının alınmasının, razılaşmalarımızın icrasının və qanuni mənafelərimizin qorunmasının zəruriliyi baxımından, hətta, sizin istifadə&ccedil;i hesabınızın ləğv edilməsindən və / və ya hər hansı x&uuml;susi xidmətlərin istifadəsinin dayandırılmasından sonra da həyata ke&ccedil;irilə bilər.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong>​​​​​​​<strong>Məlumatların a&ccedil;ıqlanması. </strong>Platforma istifadə&ccedil;inin şəxsi məlumatlarını həmin istifadə&ccedil;inin razılığı olmadan &uuml;&ccedil;&uuml;nc&uuml; şəxslərə &ouml;t&uuml;rm&uuml;r. Platforma etibarsız hesabların və ya saxta adları və qeydiyyat məlumatlarını ehtiva edən hesabların silinməsi h&uuml;ququna malikdir.</p>\r\n\r\n<p><strong>3.&nbsp;Reklam xarakterli mesajlar. </strong>Elektron po&ccedil;t &uuml;nvanınızı və ya digər istənilən əlaqə məlumatınızı (məsələn, telefon n&ouml;mrəsini və ya sosial şəbəkədə istifadə&ccedil;i adını) təqdim etməklə, Siz platforma əməkdaşlarından reklam xarakterli paylaşmaların, mesajların və ya zənglərin qəbul edilməsinə razılığınızı bildirirsiniz. M&uuml;vafiq olaraq, platforma əməkdaşları elektron po&ccedil;tunuza reklam xarakterli paylaşmaları və ya mesajları, SMS, şəxsi mətn mesajlarını g&ouml;ndərmək, marektinq zəngləri etmək və ya analoji əlaqə formalarından istifadə etmək h&uuml;ququna malikdir. Bu c&uuml;r reklam xarakterli mesajları və ya zəngləri qəbul etmək istəmədiyiniz təqdirdə, istənilən vaxt platformaya bildiriş g&ouml;ndərə və ya aldığınız reklam xarakterli mesajlarda yer alan abunə&ccedil;ilikdən imtina təlimatına riayət edə bilərsiniz.</p>\r\n\r\n<p><strong>4.&nbsp;Təhl&uuml;kəsizlik. </strong>Platforma bizimlə paylaşdığınız şəxsi məlumatların fiziki, elektron və icra tədbirləri də olmaqla təhl&uuml;kəsizlik tədbirlərini həyata ke&ccedil;irəcəkdir. Bundan savayı, platforma HTTPS protokolu &uuml;zrə bir sıra xidmətlər resursuna təhl&uuml;kəsiz girişi, SSL / TLS sahə standartının şifrələnmiş birləşməsi ilə qorunan x&uuml;susi tərtib edilmiş formalar vasitəsilə &ouml;dəniş (məsələn, kredit kartının n&ouml;mrəsi) yolu ilə məxfi məlumatların &ouml;t&uuml;r&uuml;lməsini də təklif edir. Platforma, həm&ccedil;inin, m&uuml;təmadi olaraq m&uuml;mk&uuml;n &ccedil;atışmazlıqların və h&uuml;cumların baş verə biləcəyi &uuml;zrə sistemə nəzarət edir. Xidmətlərimizin təhl&uuml;kəsizliyinin artırılması &uuml;&ccedil;&uuml;n yeni həllər yolunu axtarırıq.</p>\r\n\r\n<p><strong>5.&nbsp;İstifadə qaydaları.</strong></p>\r\n\r\n<p><strong>5.1 </strong>Platforma istifadə&ccedil;ilərdən xoşagəlməz nəticələrə gətirib &ccedil;ıxara biləcək m&uuml;bahisəli halların və digər pozuntuların yaranmamasını tələb edir. Belə hallara yol verildiyi təqdirdə, platforma yaranmış vəziyyəti təhlil edərək gələcəkdə buna bənzər halların yol verilməməsi &uuml;zrə m&uuml;vafiq tədbirləri həyata ke&ccedil;irməyi &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Hazırki məxfilik siyasəti, onun təfsiri və hazırki sənədlə əlaqədar istənilən iradlar və m&uuml;bahisələr yalnız və m&uuml;stəsna olaraq Azərbaycan Respublikasının əsas daxili qanunları ilə tənzimlənir, təfsir edilir və icra edilir. Bununla da, siz iradların və m&uuml;bahisələrin m&uuml;stəsna olaraq Azərbaycan Respublikasında yerləşən səlahiyyətli məhkəmələr tərəfindən həll edilməsinə razılığınızı bildirirsiniz.</p>\r\n\r\n<p><strong>6.&nbsp;Hesabın silinməsi. </strong>Siz <a href=\"mailto:info@mytender.az\">info@mytender.az</a> və ya <a href=\"mailto:privacy@mytender.az\">privacy@mytender.az</a> elektron &uuml;nvanları &uuml;zrə m&uuml;raciət etməklə bloqlarımızdan, toplumlarımızdan və ya forumlarımızdan şəxsi məlumatlarınızın silinməsini tələb edə bilərsiniz.</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(19, 7, 'en', 'Why mytender.az?', '', '', '<p>✔ Free registration</p>\r\n\r\n<p>✔ Low tariffs for the provision of services</p>\r\n\r\n<p>✔ Individual approach</p>\r\n\r\n<p>✔ Transparent business activities in conducting transactions</p>\r\n\r\n<p>✔ Positioning in the B2B market</p>\r\n\r\n<p>✔ Cost and time effectiveness</p>\r\n\r\n<p>✔ Control of purchases / deliveries remotely</p>\r\n\r\n<p>✔ Entrance both to the local and international market B2B</p>\r\n\r\n<p>✔ Accessibility and automation</p>\r\n\r\n<p>✔ Mutually beneficial partnership</p>\r\n'),
(20, 7, 'ru', 'Почему mytender.az?', '', '', '<p>✔ Бесплатная регистрация</p>\r\n\r\n<p>✔ Невысокие тарифы предоставления услуг</p>\r\n\r\n<p>✔ Индивидуальный подход</p>\r\n\r\n<p>✔ Прозрачная предпринимательская деятельность в ведении сделок</p>\r\n\r\n<p>✔ Позиционирование на рынке B2B</p>\r\n\r\n<p>✔ Экономия средств и времени</p>\r\n\r\n<p>✔ Контроль по закупкам/поставкам дистанционно</p>\r\n\r\n<p>✔ Выход как на локальный, так и международный рынок B2B</p>\r\n\r\n<p>✔ Доступность и автоматизация</p>\r\n\r\n<p>✔ Взаимовыгодное партнерство</p>\r\n'),
(21, 7, 'az', 'Niyə mytender.az?', '', '', '<p>✔ Pulsuz qeydiyyat</p>\r\n\r\n<p>✔ Xidmətlərin g&ouml;stərilməsi &uuml;zrə aşağı tariflər</p>\r\n\r\n<p>✔ Fərdi yanaşma</p>\r\n\r\n<p>✔ S&ouml;vdələşmələrin aparılmasında şəffaf sahibkarlıq fəaliyyəti</p>\r\n\r\n<p>✔ B2B bazarında yerləşdirmə</p>\r\n\r\n<p>✔ Pula və vaxta qənaət</p>\r\n\r\n<p>✔ Məsafədən satınalmalara / &ccedil;atdırılmalara nəzarət</p>\r\n\r\n<p>✔ Həm yerli, həm də beynəlxalq B2B bazarına &ccedil;ıxış</p>\r\n\r\n<p>✔ M&uuml;mk&uuml;nl&uuml;k və avtomatlaşdırma</p>\r\n\r\n<p>✔ Qarşılıqlı faydalı əməkdaşlıq</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `tenderAccess`
--

CREATE TABLE `tenderAccess` (
  `id` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `tenderId` int(10) UNSIGNED NOT NULL,
  `participate` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tenderAccess`
--

INSERT INTO `tenderAccess` (`id`, `userId`, `tenderId`, `participate`) VALUES
(51, 1, 24, 1),
(55, 1, 26, 1),
(56, 1, 27, 1),
(59, 3, 24, 1),
(60, 1, 29, 1),
(61, 1, 30, 1),
(62, 1, 31, 1),
(63, 3, 26, 0),
(64, 3, 30, 1),
(65, 1, 32, 1),
(66, 1, 33, 1),
(67, 1, 34, 1),
(68, 1, 35, 1),
(69, 1, 36, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `tenderFiles`
--

CREATE TABLE `tenderFiles` (
  `id` int(11) NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `tenderId` int(10) UNSIGNED DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `secret` varchar(30) DEFAULT NULL,
  `uploadedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tenderFiles`
--

INSERT INTO `tenderFiles` (`id`, `userId`, `tenderId`, `file`, `caption`, `type`, `size`, `secret`, `uploadedAt`) VALUES
(13, 2, NULL, 'tender_59d496c291ade8.87081237.doc', 'Alqı_Satqı müqaviləsi.doc', 'application/msword', 33280, '59d496aba5ed47.18944622', '2017-10-04 08:07:30'),
(14, 2, NULL, 'tender_59d496cd63baf9.65411237.xlsx', 'alkopan Qazax Əhəng z.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 17489, '59d496aba5ed47.18944622', '2017-10-04 08:07:41'),
(18, 2, NULL, 'tender_59e9fd715f5016.29135275.pdf', 'pencere.pdf', 'application/pdf', 94528, '59e9fcdea3a664.92529583', '2017-10-20 13:43:13'),
(19, 2, NULL, 'tender_59e9fd9eb4a360.15062736.xlsx', 'check.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 79120, '59e9fcdea3a664.92529583', '2017-10-20 13:43:58'),
(20, 2, NULL, 'tender_59e9fdb74f9061.76141220.txt', 'For Kostya_ mytenderaz.txt', 'text/plain', 1481, '59e9fcdea3a664.92529583', '2017-10-20 13:44:23'),
(22, 2, NULL, 'tender_59ef8d0b967706.01183497.txt', 'New Text Document.txt', 'text/plain', 748, '59ef8ccbdd72e2.02869019', '2017-10-24 18:57:15'),
(23, 2, 24, 'tender_59f023ed5779a8.14762696.txt', 'resume.txt', 'text/plain', 1332, '59f023cd25e5c9.42935601', '2017-10-25 05:41:01'),
(25, 2, 29, 'tender_59f0a005483066.35739653.docx', 'Документ Microsoft Word _13_.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 12872, '59f09fbdbc5852.80052095', '2017-10-25 14:30:29'),
(27, 55, NULL, 'tender_59f6ddc355e890.47646226.txt', 'resume.txt', 'text/plain', 1332, '59f6dd20cec9b6.38581586', '2017-10-30 08:07:31'),
(28, 55, 32, 'tender_59f6e22e3d0437.99662121.txt', 'resume.txt', 'text/plain', 1332, '59f6e1d392cee7.91081469', '2017-10-30 08:26:22'),
(30, 55, 33, 'tender_59f6e31dad00c8.81060829.txt', 'resume.txt', 'text/plain', 1332, '59f6e2eb1cda25.12418156', '2017-10-30 08:30:21');

-- --------------------------------------------------------

--
-- Структура таблицы `tenderMsgs`
--

CREATE TABLE `tenderMsgs` (
  `id` int(11) UNSIGNED NOT NULL,
  `tenderAccessId` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `tenderId` int(10) UNSIGNED NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `readedAt` timestamp NULL DEFAULT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tenderMsgs`
--

INSERT INTO `tenderMsgs` (`id`, `tenderAccessId`, `userId`, `tenderId`, `createdAt`, `readedAt`, `text`) VALUES
(98, 59, 1, 24, '2017-10-26 07:28:43', '2017-10-26 05:28:48', 'Yeni təchizatçılar'),
(99, 59, 3, 24, '2017-10-26 07:28:43', '2017-10-26 05:29:16', '<p>2e4567</p>\r\n'),
(100, 64, 1, 30, '2017-10-30 08:03:05', '2017-10-30 07:04:22', 'New supplier'),
(101, 64, 3, 30, '2017-10-30 08:03:05', '2017-10-30 07:04:22', '<p>Хочу участвовать!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `tenders`
--

CREATE TABLE `tenders` (
  `id` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `industry` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `description_full` text NOT NULL,
  `contact` int(10) UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `finishedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tenders`
--

INSERT INTO `tenders` (`id`, `userId`, `name`, `createdAt`, `industry`, `description`, `description_full`, `contact`, `status`, `finishedAt`) VALUES
(24, 2, 'SILVANOLS.AZ', '2017-10-25 05:41:02', 6, 'Test foot and Beverage -------- short description', '<p>dtththththth</p>\r\n', 41, -1, '2017-10-26 11:41:00'),
(26, 2, 'mail.mytender.az', '2017-10-25 06:49:42', 6, 'Телевизоры', '<p>Требуются Телевизоры</p>\r\n\r\n<p>Технические характеристики:&nbsp;</p>\r\n\r\n<p>Диагональ: 52</p>\r\n\r\n<p>Количество: 100</p>\r\n\r\n<p>Производитель: не важно</p>\r\n\r\n<p>Доставка: да</p>\r\n\r\n<p>&nbsp;</p>\r\n', 41, 1, '2017-11-04 09:48:00'),
(27, 2, 'Züxeri', '2017-10-25 06:50:22', 5, 'Fiber cement', '<p>Fiber - Spectra fiber (38 &micro;m in diameter) and Snia fiber (20 &micro;m in diameter) (Both are high modulus polyethylene fibers probably with different surface finish, supplied by different manufacturers).</p>\r\n\r\n<p>Matrix - Plain matrix (w/c=0.5 and no admixture) and SF matrix (silica fume/c=0.20, w/c=0.27, superplasticizer/c=0.05). Curing condition -</p>\r\n\r\n<p>Specimens are moisture-cured until the date of testing. Age of testing - 0.5, 1, 1.5, 2, 7, 14, 21, 28 days. For each material system, at least 3 specimens are tested at each age.</p>\r\n', 41, 1, '2017-11-24 09:50:00'),
(29, 2, 'Test', '2017-10-25 14:31:14', 6, 'Test', '<p>Test</p>\r\n\r\n<p>test</p>\r\n\r\n<p>test test</p>\r\n', 41, -1, '2017-10-30 17:21:00'),
(30, 55, 'INNEXIM', '2017-10-26 10:02:24', 7, 'Logistic operations', '<p>4 zone Europe and worlwide</p>\r\n\r\n<p>Need logistic services from Italy and&nbsp;Spain to Azerbaijan.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Kindly ask you to send offers through.</p>\r\n\r\n<p>If reffered&nbsp;prices and services is Ok we will make negotiating directly</p>\r\n', 44, 1, '2017-11-05 13:00:00'),
(31, 65, 'Anty Boss', '2017-10-27 19:19:32', 9, 'Нефтехимическое состовляющее', '<p>Мазут, нефтепродукты, масла</p>\r\n\r\n<p>Для получения лополнительной информации просим отправить сообщение.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, 1, '2017-12-29 23:00:00'),
(32, 55, 'Transport Tender', '2017-10-30 08:27:01', 7, 'Transport Tender -------- short description', '<p>Transport Tender -------- Full description</p>\r\n', 44, 1, '2017-11-04 11:25:00'),
(33, 55, 'Transport Tender 2', '2017-10-30 08:30:23', 7, 'Test foot and Beverage -------- short description', '<p>Transport Tender -------- full description</p>\r\n', 44, 1, '2017-11-04 11:29:00'),
(34, 2, 'IT ', '2017-10-30 14:22:01', 12, 'Computers and ups', '<p>Upon request</p>\r\n', 41, 1, '2017-11-05 17:21:00'),
(35, 55, 'Кабельные коммуникации', '2017-10-30 16:03:08', 12, 'Кабельные коммуникации', '<p>Кабели 3х4, 2х3</p>\r\n\r\n<p>количество: 100</p>\r\n\r\n<p>срок поставки: 5-10 дней</p>\r\n\r\n<p>&nbsp;</p>\r\n', 44, 1, '2017-11-05 19:01:00'),
(36, 55, 'HUB installing', '2017-10-31 06:26:25', 12, 'HUBS and SWITCHS', '<p>Needed services on HUB and SWITCH installing</p>\r\n\r\n<p>Capacity: two buildings</p>\r\n', 44, 1, '2017-11-05 09:28:00');

-- --------------------------------------------------------

--
-- Структура таблицы `userContacts`
--

CREATE TABLE `userContacts` (
  `id` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `userContacts`
--

INSERT INTO `userContacts` (`id`, `userId`, `name`, `position`, `phone`, `email`, `status`) VALUES
(3, 2, 'My Contact 1', 'My Position 2', '0555555555', 'zz@zz.com', 0),
(4, 2, 'My Contact 2', 'My Position 2', '0553333333', 'zz2@zz.com', 0),
(5, 2, 'My Contact 3', 'My Position 3', '0558878787', 'zz3@zz.com', 0),
(14, 21, 'Rustam', 'Manager', '0502884460', 'r.c.rustam@icloud.com', 0),
(15, 24, 'kam', 'as', '0124352323', 'k.agasi@gmail.com', 1),
(34, 43, 'Zaur', 'Direktor', '0502636700', 'zeynalov.zaur@gmail.com', 1),
(35, 44, 'Asif', 'CEO', '0502115685', 'aliyev.asif.r@gmail.com', 1),
(39, 21, 'RR', 'Manager', '122233337', 'r.c.rustam@icloud.com', 1),
(40, 2, 'ertyuio', 'ertyuiop', '0505036634', 'tem@tem.az', 0),
(41, 2, 'ZA', 'Manager', '0505050505', 'tem2@tem.az', 1),
(42, 52, 'Saf', 'Manager', '0505050505', 'tem2345678@tem.az', 1),
(44, 55, 'R.C.', 'Manager', '0522003123', 'r.c.rustam@gmail.com', 1),
(45, 56, 'Farid', 'Logistic Manager', '0502780210', 'farid.rustamov@originalmotors.az', 1),
(46, 57, 'Gunay Tender', 'Accaunt manager', '4518978789', 'gunayhuseyn@gmail.com', 1),
(47, 58, 'Rustem Sharipov', 'Menecer', '0505036634', 'office@saf-pencere.az', 1),
(48, 65, 'Arty Boss', 'Owner', '00718945509598686', 'fashionarea@hotmail.com', 1),
(49, 66, 'Chase', 'WY', 'ZW', 'chaseoshaughnessy@gmail.com', 1),
(50, 67, 'Christopher', 'YL', '0388 2177223', 'christopheraspinall@arcor.de', 1),
(51, 68, 'test_temp', 'Direktor', '0125555555', 'teamsag@gmail.com', 1),
(52, 69, 'ertyuio', 'ertyuiop', '0505036634', 'tem@tem.az', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `userGroups`
--

CREATE TABLE `userGroups` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `userGroups`
--

INSERT INTO `userGroups` (`id`, `name`) VALUES
(1, 'Administrators'),
(2, 'Buyers'),
(3, 'Suppliers');

-- --------------------------------------------------------

--
-- Структура таблицы `userIndustries`
--

CREATE TABLE `userIndustries` (
  `id` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `industryId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `userIndustries`
--

INSERT INTO `userIndustries` (`id`, `userId`, `industryId`) VALUES
(7, 3, 1),
(2, 3, 2),
(1, 3, 3),
(3, 3, 4),
(8, 3, 5),
(22, 3, 6),
(27, 3, 7),
(28, 3, 8),
(16, 3, 9),
(29, 3, 10),
(30, 3, 11),
(31, 3, 12),
(14, 4, 2),
(6, 51, 4),
(21, 63, 5),
(32, 63, 7),
(26, 64, 0),
(23, 64, 5),
(24, 64, 6),
(25, 64, 9),
(33, 70, 5),
(34, 70, 6),
(35, 70, 7),
(36, 70, 9),
(37, 70, 10),
(38, 70, 12);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `login` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `groupId` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `voen` int(10) UNSIGNED DEFAULT NULL,
  `country` char(3) DEFAULT NULL,
  `city` int(10) UNSIGNED DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `site` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `description` text,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `activationCode` varchar(255) DEFAULT NULL,
  `fullAccessTo` date DEFAULT NULL,
  `stars` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `login`, `password`, `createdAt`, `groupId`, `name`, `voen`, `country`, `city`, `address`, `phone`, `email`, `site`, `facebook`, `description`, `status`, `activationCode`, `fullAccessTo`, `stars`) VALUES
(1, 'admin', '$2y$10$vHgC0W89hRuVIPXHrAw5QujjnixOYkpDyagDXn7wY.CmoJmVxGVb2', '2017-07-28 08:02:27', 1, 'Admin', 0, NULL, 0, '', '', 'office@mytender.az', '', '', '', 1, 'eeef80f7660b283a3b799938a84416cc', NULL, 0),
(2, 'test-b', '$2y$10$1JL4esyfyf5yLhJ77CTDhurSZJPBSJ2dEz52h4TbAvmnjpwo4iMtu', '2017-08-04 06:41:42', 2, 'Test Buyer', 1234567898, 'AZ', 1, 'ZA', '0555555555', 'zeuz@list.ru', '', '', 'Test', 1, '3f6b8a99b77a42b247003aa4e2563b23', NULL, 5),
(3, 'test-s', '$2y$10$t1O0Er5Sln7xIyfrjLYByuJJzBtueP0rj.bKpz/.3zEBNQ/nW5upi', '2017-08-04 06:43:36', 3, 'Test suplier', 1212121212, 'AZ', 1, 'ZD', '0552222222', 'evilkraft@gmail.com', '', '', 'Test and test', 1, '2ef8e52d8794260dccf2eb3c40a042ef', NULL, 4),
(4, 'test-s2', '$2y$10$vsB9/tuFvDTmwoaQTTVHeuSAk8uygoVER4Q1CniV.nM2IGs0Sxze2', '2017-08-09 11:30:22', 3, 'Test suplier 2', 3434343434, 'AZ', 2, 'test', '0552222222', 'zeuz1@list.ru', '', '', 'test test test', 1, '3f6b8a99b77a42b247003aa4e2563b23', NULL, 0),
(21, 'Guest', '$2y$10$rtZe3fZNTI7E2JKez0tJoO77dHtmaUy8qCMitTE2eGscVvxQOieEa', '2017-08-22 06:11:24', 2, 'Best Solutions', 1700322123, 'AZ', 1, 'S.Badalbeyli', '0502884460', 'r.c.rustam@icloud.com', '', '', '', 1, '5829fa1e492fe8863f558d8e9a25ca0e', '2017-08-24', 4),
(24, 'innovation', '$2y$10$UavGg5wLhL2ZA36fuFREjOQnt8yUF8RAZv5W/BIh8Qhnjup4mXMkC', '2017-08-22 08:22:42', 2, 'k&A', 1235438761, 'AZ', 1, 'hasan aliyev 35', '0124445555', 'k.agasi@gmail.com', '', '', '', 1, '91e343c820489d4ffa63cebcfa2dc44a', '2017-08-24', 0),
(43, 'zaur', '$2y$10$Va0Yz8kpYDS75KNCacrqDemWXLksPYors6Wx589ju.Xj358lKlkGq', '2017-08-28 08:58:50', 2, '3Z MMC', 1700170000, 'AZ', 1, 'A.Aliyev 1', '0502636700', 'zeynalov.zaur@gmail.com', 'http://1415.az', '', '', 1, 'ba20d010dab1a2b1cd477ae670366934', '2017-08-30', 0),
(44, 'asifus', '$2y$10$LtwnDf8rsGZElZemxxMAtOrmXetDJ8SQpUNJJvnf./tgysL839gC.', '2017-08-28 19:08:31', 2, 'Asal', 1234567890, 'AZ', 1, 'Suleyman Rustam ', '0502115685', 'aliyev.asif.r@gmail.com', '', '', '', 1, 'e0a5db857d9d7dece68c149c5d066938', '2017-08-30', 3),
(51, 'ko_w_ka@inbox.ru', '$2y$10$5O/Ebi7nF.up/hWinDY8weW6NbgTvj/KIHDv2F6KXhlX7q3Lm2Xju', '2017-10-09 09:03:53', 3, 'Netant', 1234567890, 'AZ', 1, 'kommunisticheskaya 5', '+994559879898', 'ko_w_ka@inbox.ru', '', '', '', 0, '67f8e648eda2987f8ab5a939779e5c20', '2017-10-14', 0),
(52, 'admin123', '$2y$10$IM4pMaoPzYD252IOPGgNhu8qNIg1ozpWnWlDbkK.Mpn2K4K2w8sGq', '2017-10-24 10:51:58', 2, 'Test2', 4294967295, 'AZ', 1, 'SF', '999090909', 'teamsag@germail.com', '', '', '', 0, '2a4b2da78da0cf2ad8f1a5407cce28a3', NULL, 0),
(55, 'innexim', '$2y$10$eOboGwpWxdJdo8tokTBsyOPZ7AvVkizn5yQMk3SCa.9D85eqYaW.2', '2017-10-24 11:44:09', 2, 'INNEXIM', 0, 'CA', 0, '-', '0523002020', 'r.c.rustam@gmail.com', 'http://innexim.com', '', '', 1, 'c9fc98c061b0abd5304c2c3d192416ed', NULL, 0),
(56, 'Farid', '$2y$10$NjWg45B25rZIZ1JxRLV2Y.oANYGUUyvhcGT5jvIhJSAS/ZYZ9hQ/q', '2017-10-25 07:07:50', 2, 'Original Motors', 1701299101, 'AZ', 1, 'Aliyar Aliyev 52A', '0502780210', 'rustamof@hotmail.com', 'http://originalmotors.com', '', '', 1, '83d95a5965ad83b3201cf06d892633fc', NULL, 0),
(57, 'gunay', '$2y$10$TV9w8oFyoaL9yIy0Pfb50ewmHYDti00G8e5ZN0bhddNk968CHwsXK', '2017-10-25 08:01:23', 2, 'Netant', 1239876540, 'AZ', 1, 'gfjgjtdm', '4969696', 'gunayhuseyn@gmail.com', '', '', '', 1, '75cd10ebbdb74046329e61bb64e862db', NULL, 0),
(58, 'rustam-saf', '$2y$10$94wh18bKb23Y.c6r032jf.qjA4/xOB4CE1F2w7uY93wrckRmAsCeS', '2017-10-25 08:56:10', 2, 'Saf pencere', 1111111111, 'AZ', 1, 'Nobel Prospekti', '0124092835', 'office@saf-pencere.az', 'http://www.saf-pencere.az', 'https://www.facebook.com/saf.pencere/', '', 1, 'f25d8851517d80059bed61c91cb2c9c8', NULL, 0),
(63, 'farid-saf', '$2y$10$gnwL0MQoPPkh5/920DSjFuhXTjxYAgF4L9c0peVOj0btsD8dn3Jrq', '2017-10-25 10:04:18', 3, 'Saf pencere', 1111111111, 'AZ', 1, 'Nobel Prospekti', '0124092835', 'saf.pencere@gmail.com', 'http://www.saf-pencere.az', 'https://www.facebook.com/saf.pencere/', '123', 0, '89f04d27e0a82e47fb2d00e5b32c6ffe', NULL, 0),
(64, 'Pooltech', '$2y$10$i2ffpLVOZT4qTQHnuEYQyexnHf.b2UvEZvHwLKozvgej5fK38d1.u', '2017-10-25 16:09:18', 3, 'Pooltech MMC', 1201778181, 'AZ', 1, 'Nərimanov rayonu, Hacı Murad 1', '+994552049422', 'taleh@pooltech.az', 'http://www.pooltech.az', '', '', 1, '4c596a0d8c4fb752b40a6bb688b62778', NULL, 0),
(65, 'Fashion', '$2y$10$6SYhXTsTkx5sd9zCj9zd8eRZWZY/BPqU8kPF6P5uKZ5ZRV1RfN/v6', '2017-10-27 18:53:31', 2, 'IDBI', 1111111111, 'AZ', 1, 'Centralnaya', '0071895786996999', 'fashionarea@hotmail.com', '', '', '', 1, '691401df2a0e858b368ee0119dd6d39e', NULL, 0),
(66, 'Chase', '$2y$10$WXl04J7Hd1MlqrrEvGvgLu/KGvYwgydfkUBH66YliLIFMPD1Fmd6u', '2017-10-30 01:57:27', 2, 'site signs', 0, 'CA', 0, '', 'LR', 'chaseoshaughnessy@gmail.com', 'http://www.signsavers.co.uk/', '', 'We are a group of volunteers and opening a brand new scheme in our community.\r\nYour web site provided us with useful information to work on. You\'ve \r\nperformed a formidable job and our entire community will likely be thankful to you.', 0, '5e37afb0d1949d8546743662ec66efb5', NULL, 0),
(67, 'Christopher', '$2y$10$MAkGOR3VT95DKhXy6K5e4.H6.n87sN3ieWrryVDEW1BQvgFrfb.DS', '2017-10-30 01:58:22', 2, 'safety signs', 0, 'CA', 0, '', '0388 2177223', 'christopheraspinall@arcor.de', 'http://www.signsavers.co.uk/', '', 'Just want to say your article is as amazing. The clearness in your publish is simply cool and i could suppose you\'re a professional on this subject.\r\nWell along with your permission allow me to grab your feed to keep updated with coming near near post.\r\n\r\nThanks 1,000,000 and please continue the gratifying work.', 0, '4b9fcd11f8b26c3006e671ba38557e0e', NULL, 0),
(68, 'teamsag1', '$2y$10$U22MBO/DBT7qwVvlFADttONR7waEeTG5zC1kEyatPd4dzH6iIFjpu', '2017-10-30 07:47:38', 2, 'Test_temporary', 2222222222, 'AZ', 1, 'Nobel Prospekti 45', '01255555555', 'teamsag@gmail.com', '', '', '', 0, '016a6ce80cce79cd37f713566959169c', NULL, 0),
(69, 'admin1111', '$2y$10$inkMzw3TdaoX.gqdyASxEObLztXcKOUOXsuJwtSaiH8EwQ5KmOxb.', '2017-10-30 12:19:13', 2, 'суауауау', 555555555, 'AZ', 1, 'увувувув увуву', '0124110680', 'keoroot@gmail.com', '', '', '', 0, '88e2bc630c06205647b9a3a7bcfbe503', NULL, 0),
(70, 'innexim1', '$2y$10$Ya8F/Gy3Y2YA1ARYGnf3EeNDRRx7sbU4LWCO9YsT5sQNOpmsS7Fr.', '2017-10-30 14:18:16', 3, 'INNEXIM', 0, 'CA', 0, 'SDAF', '09230120100', 'rustam.rustamov@pmdgroup.az', '', '', '', 1, 'fd44db8237425423b7a4e5d6db3a21a1', NULL, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `votes`
--

CREATE TABLE `votes` (
  `voter` int(10) UNSIGNED NOT NULL,
  `votedFor` int(10) UNSIGNED NOT NULL,
  `stars` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `votes`
--

INSERT INTO `votes` (`voter`, `votedFor`, `stars`) VALUES
(2, 3, 4),
(2, 22, 1),
(2, 45, 3),
(3, 2, 5),
(3, 21, 3),
(3, 39, 1),
(3, 44, 3),
(21, 45, 5),
(45, 21, 5);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `billingOptions`
--
ALTER TABLE `billingOptions`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blogId` (`blogId`);

--
-- Индексы таблицы `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `help`
--
ALTER TABLE `help`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `help_lang`
--
ALTER TABLE `help_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pageId` (`pageId`);

--
-- Индексы таблицы `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `industryId` (`industryId`),
  ADD KEY `lang` (`lang`);

--
-- Индексы таблицы `mailerQueue`
--
ALTER TABLE `mailerQueue`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `alias` (`alias`);

--
-- Индексы таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pageId` (`pageId`);

--
-- Индексы таблицы `tenderAccess`
--
ALTER TABLE `tenderAccess`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `tenderId` (`tenderId`);

--
-- Индексы таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `tenderId` (`tenderId`);

--
-- Индексы таблицы `tenderMsgs`
--
ALTER TABLE `tenderMsgs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`),
  ADD KEY `tenderId` (`tenderId`),
  ADD KEY `tenderAccessId` (`tenderAccessId`);

--
-- Индексы таблицы `tenders`
--
ALTER TABLE `tenders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `userContacts`
--
ALTER TABLE `userContacts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `userGroups`
--
ALTER TABLE `userGroups`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `userIndustries`
--
ALTER TABLE `userIndustries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_indust_idx` (`userId`,`industryId`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Индексы таблицы `votes`
--
ALTER TABLE `votes`
  ADD PRIMARY KEY (`voter`,`votedFor`),
  ADD KEY `votedFor` (`votedFor`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `billingOptions`
--
ALTER TABLE `billingOptions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT для таблицы `blog`
--
ALTER TABLE `blog`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT для таблицы `help`
--
ALTER TABLE `help`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT для таблицы `help_lang`
--
ALTER TABLE `help_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT для таблицы `industries`
--
ALTER TABLE `industries`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT для таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT для таблицы `mailerQueue`
--
ALTER TABLE `mailerQueue`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблицы `tenderAccess`
--
ALTER TABLE `tenderAccess`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;
--
-- AUTO_INCREMENT для таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT для таблицы `tenderMsgs`
--
ALTER TABLE `tenderMsgs`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;
--
-- AUTO_INCREMENT для таблицы `tenders`
--
ALTER TABLE `tenders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT для таблицы `userContacts`
--
ALTER TABLE `userContacts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;
--
-- AUTO_INCREMENT для таблицы `userGroups`
--
ALTER TABLE `userGroups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `userIndustries`
--
ALTER TABLE `userIndustries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `blog`
--
ALTER TABLE `blog`
  ADD CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  ADD CONSTRAINT `blog_lang_ibfk_1` FOREIGN KEY (`blogId`) REFERENCES `blog` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `help_lang`
--
ALTER TABLE `help_lang`
  ADD CONSTRAINT `help_lang_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `help` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  ADD CONSTRAINT `industries_lang_ibfk_1` FOREIGN KEY (`industryId`) REFERENCES `industries` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  ADD CONSTRAINT `pages_lang_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenderAccess`
--
ALTER TABLE `tenderAccess`
  ADD CONSTRAINT `tenderaccess_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenderaccess_ibfk_2` FOREIGN KEY (`tenderId`) REFERENCES `tenders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  ADD CONSTRAINT `tenderfiles_ibfk_1` FOREIGN KEY (`tenderId`) REFERENCES `tenders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenderfiles_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenderMsgs`
--
ALTER TABLE `tenderMsgs`
  ADD CONSTRAINT `tendermsgs_ibfk_1` FOREIGN KEY (`tenderAccessId`) REFERENCES `tenderAccess` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tendermsgs_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tendermsgs_ibfk_3` FOREIGN KEY (`tenderId`) REFERENCES `tenders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenders`
--
ALTER TABLE `tenders`
  ADD CONSTRAINT `tenders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `userContacts`
--
ALTER TABLE `userContacts`
  ADD CONSTRAINT `usercontacts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `userIndustries`
--
ALTER TABLE `userIndustries`
  ADD CONSTRAINT `userIndustries_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
