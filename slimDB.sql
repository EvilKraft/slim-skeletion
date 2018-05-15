-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Май 15 2018 г., 16:57
-- Версия сервера: 5.7.19
-- Версия PHP: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `slimDB`
--

-- --------------------------------------------------------

--
-- Структура таблицы `blog`
--

CREATE TABLE `blog` (
  `blogId` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `blog`
--

INSERT INTO `blog` (`blogId`, `userId`, `createdAt`) VALUES
(1, 1, '2017-08-23 09:23:12');

-- --------------------------------------------------------

--
-- Структура таблицы `blog_lang`
--

CREATE TABLE `blog_lang` (
  `langId` int(10) UNSIGNED NOT NULL,
  `blogId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `blog_lang`
--

INSERT INTO `blog_lang` (`langId`, `blogId`, `lang`, `title`, `text`) VALUES
(1, 1, 'en', 'пкпкпкп', '<p>кпкпкпк</p>\r\n'),
(2, 1, 'ru', 'кпкпкп', '<p>кпкпкпкп</p>\r\n'),
(3, 1, 'az', 'уакапка', '<p>ькпкпьщкп</p>\r\n\r\n<p>кпклтпкшопшокпо</p>\r\n\r\n<p>кпдпькщпокп</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `cities`
--

CREATE TABLE `cities` (
  `cityId` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `country` varchar(50) NOT NULL,
  `iso2` char(2) NOT NULL,
  `population` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `cities`
--

INSERT INTO `cities` (`cityId`, `name`, `country`, `iso2`, `population`) VALUES
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
  `helpId` int(10) UNSIGNED NOT NULL,
  `sort` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `help`
--

INSERT INTO `help` (`helpId`, `sort`) VALUES
(2, 8),
(4, 1),
(5, 2),
(6, 3),
(7, 4),
(8, 5),
(9, 6),
(10, 7),
(11, 9),
(12, 10),
(13, 11),
(14, 12),
(15, 13),
(16, 14);

-- --------------------------------------------------------

--
-- Структура таблицы `help_lang`
--

CREATE TABLE `help_lang` (
  `langId` int(10) UNSIGNED NOT NULL,
  `pageId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `help_lang`
--

INSERT INTO `help_lang` (`langId`, `pageId`, `lang`, `title`, `text`) VALUES
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
(30, 10, 'az', 'Əlaqə', '<p>Bizə m&uuml;raciət etməklə, hər hansı bir&nbsp;zəruri məsələ ilə əlaqədar, hərtərəfli məlumat&nbsp;əldə edə bilərsiniz.&nbsp;</p>\r\n'),
(31, 11, 'en', 'For buyers: how to make an electronic tender?', '<p>&nbsp;</p>\r\n\r\n<p>Step 1. Register on the platform.</p>\r\n\r\n<p>Step 2. Login to account.</p>\r\n\r\n<p>Step 3. In the Tenders window, find the icon &quot;<strong>+</strong>&quot;, that means, &quot;<strong>Add a tender</strong>&quot;.</p>\r\n\r\n<p>Step 4. Fill in all the required fields.</p>\r\n\r\n<p>Step 5. Attach the required file (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Step 6. Click on the icon &ldquo;<strong>Create</strong>&rdquo;.</p>\r\n\r\n<p>Step 7. After moderation by the webpage administration, your tender will appear in the general list.</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(32, 11, 'ru', 'Для покупателей: как создать электронный тендер?', '<p>Шаг 1. Зарегистрироваться на платформе.</p>\r\n\r\n<p>Шаг 2. Войти в личный кабинет.</p>\r\n\r\n<p>Шаг 3. В окне тендеры, найти иконку&nbsp;<strong>&laquo;+&raquo;</strong>, означающий <strong>&laquo;добавить тендер&raquo;</strong></p>\r\n\r\n<p>Шаг 4. Заполнить все необходимые поля.</p>\r\n\r\n<p>Шаг 5. Вложить необходимый файл (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Шаг 6. Нажать на иконку&nbsp;<strong>&laquo;Cоздать&raquo;</strong>.</p>\r\n\r\n<p>Шаг 7. После модерации со стороны администрации, Ваш тендер появится в общем списке.</p>\r\n'),
(33, 11, 'az', 'Alıcılar üçün: elektron tenderi nece yaratmalı?', '<p>Addım 1. Platformada qeydiyyatdan ke&ccedil;mək.</p>\r\n\r\n<p>Addım 2. Şəxsi kabinetə daxil olmaq.</p>\r\n\r\n<p>Addım 3. Tenderlər pəncərəsində <strong>&ldquo;Tender əlavə edin&rdquo;</strong> mənasını bildirən <strong>&ldquo;+&rdquo;</strong> işarəsini tapın.</p>\r\n\r\n<p>Addım 4. B&uuml;t&uuml;n zəruri olan sahələri doldurun.</p>\r\n\r\n<p>Addım 5. Zəruri olan faylı daxil edin (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Addım 6. <strong>&ldquo;Yarat&rdquo;</strong> işarəsini vurun.</p>\r\n\r\n<p>Addım 7. Web-səhifənin administrasiya tərəfindən moderasiya aparılmasından sonrası Sizin tender &uuml;mumi siyahıda g&ouml;r&uuml;nəcək.&nbsp;</p>\r\n'),
(34, 12, 'en', 'For suppliers: how to participate in the electronic tender?', '<p>Step 1. Register on the platform.</p>\r\n\r\n<p>Step 2. Login to account.</p>\r\n\r\n<p>Step 3. In the Tenders window, accordingly to Your chosen activity category, a list of tenders will be displayed.</p>\r\n\r\n<p>Step 4. Choose the tender You are interested in and click on the icon <strong>&quot;Lock&quot;</strong> to participate in it.</p>\r\n\r\n<p>Step 5. Click on the icon <strong>&laquo;Participate&raquo;</strong>.&nbsp;</p>\r\n\r\n<p>Step 6. Fill in all the required fields and attach the required file (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Step 7. Click on the icon <strong>&laquo;Participate&raquo;</strong>.</p>\r\n'),
(35, 12, 'ru', 'Для поставщиков: как принять участие в электронном тендере?', '<p>Шаг 1. Зарегистрироваться на платформе.</p>\r\n\r\n<p>Шаг 2. Войти в личный кабинет.</p>\r\n\r\n<p>Шаг 3. В окне тендеры, в соответствии с выбранной Вами категорией деятельности, отображается список тендеров.</p>\r\n\r\n<p>Шаг 4. Выберите интересующий Вас тендер и нажмите на иконку&nbsp;<strong>&laquo;Замок&raquo;</strong> для участия в нем.</p>\r\n\r\n<p>Шаг 5. Нажмите на иконку&nbsp;<strong>&laquo;Принять участие&raquo;</strong>.&nbsp;</p>\r\n\r\n<p>Шаг 6. Заполнить все необходимые поля и вложить необходимый файл (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Шаг 7. Нажать на иконку&nbsp;<strong>&laquo;Учавствовать&raquo;</strong>.</p>\r\n'),
(36, 12, 'az', 'Təchizatçılar üçün: elektron tenderdə necə iştirak etməli?', '<p>Addım 1. &nbsp;Platformada qeydiyyatdan ke&ccedil;mək.</p>\r\n\r\n<p>Addım 2. Şəxsi kabinetə daxil olmaq.</p>\r\n\r\n<p>Addım 3. Sizin se&ccedil;diyiniz fəaliyyət kateqoriyasına m&uuml;vafiq olaraq tenderlər pəncərəsində tenderlərin siyahısı əks olunur.</p>\r\n\r\n<p>Addım 4. Sizi maraqlandıran tenderi se&ccedil;in və burada iştirak etmək &uuml;&ccedil;&uuml;n <strong>&ldquo;Qıfıl&rdquo;</strong> işarəsini vurun.</p>\r\n\r\n<p>Addım 5. <strong>&ldquo;İştirak et&rdquo;</strong> işarəsini vurun.&nbsp;</p>\r\n\r\n<p>Addım 6. B&uuml;t&uuml;n zəruri olan sahələri doldurun və zəruri olan faylı daxil edin (*pdf, *docs, *txt, *xlsx).</p>\r\n\r\n<p>Addım 7. <strong>&ldquo;İştirak et&rdquo;</strong> işarəsini vurun.</p>\r\n'),
(37, 13, 'en', 'Can a company register as a buyer and a supplier simultaneously?', '<p>Yes.&nbsp;</p>\r\n\r\n<p>For this, in the field<strong> &ldquo;Contacts&rdquo;</strong> upon registration, the data of the buyer and the supplier should not coincide.</p>\r\n\r\n<p>That is, the e-mail and contact name indicated in the field <strong>&ldquo;Contacts&rdquo; </strong>should be unique.</p>\r\n'),
(38, 13, 'ru', 'Может ли компания, регистрироваться в качестве покупателя и поставщика одновременно?', '<p>Да.&nbsp;</p>\r\n\r\n<p>Для этого в графе <strong>&laquo;</strong><strong>К</strong><strong>онтакты&raquo;</strong> при регистрации, данные покупателя и поставщика не должны совпадать.</p>\r\n\r\n<p>То есть, указываемая в графе <strong>&laquo;Контакты&raquo;</strong> электронная почта и контактное лицо должным быть уникальными.</p>\r\n'),
(39, 13, 'az', 'Şirkət eyni zamanda həm alıcı və həm də təchizatçı qismində qeydiyyatdan keçə bilər?', '<p>Bəli.&nbsp;</p>\r\n\r\n<p>Bunun &uuml;&ccedil;&uuml;n qeydiyyat zamanı <strong>&ldquo;Əlaqələr&rdquo;</strong> qrafasında alıcı və təchizat&ccedil;ının məlumatları &uuml;st-&uuml;stə d&uuml;şməməlidir.</p>\r\n\r\n<p>Yəni, <strong>&ldquo;Əlaqələr&rdquo;</strong> qrafasında g&ouml;stərilən elektron po&ccedil;t &uuml;nvanı və əlaqədar şəxs fərqli olmalıdırlar. &nbsp;&nbsp;</p>\r\n'),
(40, 14, 'en', 'Will users receive e-mails via the tenders made?', '<p>Yes.</p>\r\n\r\n<p>With each new tender created, users will receive news both to e-mail and to their account. In addition, all necessary information will be sent to all users periodically.</p>\r\n'),
(41, 14, 'ru', 'Будут ли пользователи получать электронную рассылку по созданным тендерам?', '<p>Да.</p>\r\n\r\n<p>При каждом созданном новом тендере, пользователи будут получать рассылку как на электронную почту, так и в личный кабинет. Также всем пользователям будет направляться периодически необходимая новостная информация.</p>\r\n'),
(42, 14, 'az', 'Yaradılmış tenderlər üzrə istifadəçilər elektron göndərişlər alacaqlar?', '<p>Bəli.</p>\r\n\r\n<p>Hər bir yeni tenderin yaradılması zamanı istifadə&ccedil;ilər həm elektron po&ccedil;t qutularına, həm də şəxsi kabinetlərinə g&ouml;ndərişlər alacaqlar. Eləcə də istifadə&ccedil;ilərə m&uuml;təmadi olaraq b&uuml;t&uuml;n zəruri olan məlumatlar g&ouml;ndəriləcək.</p>\r\n'),
(43, 15, 'en', 'Can a user change personal data and/or information about company?', '<p>Yes.</p>\r\n\r\n<p>Logging into account, in the window <strong>&ldquo;Settings&rdquo;</strong>, need to be selected the item <strong>&ldquo;Profile&rdquo;</strong>. Then it will be possible to make the necessary changes.</p>\r\n'),
(44, 15, 'ru', 'Может ли пользователь менять данные о себе и/или компании?', '<p>Да.</p>\r\n\r\n<p>Войдя в личный кабинет, в окне <strong>&laquo;</strong><strong>Н</strong><strong>астройки&raquo;</strong>, необходимо выбрать пункт <strong>&laquo;Профиль&raquo;</strong>. Далее будет возможным осуществлять необходимые изменения.</p>\r\n'),
(45, 15, 'az', 'İstifadəçi özü və/və ya şirkət haqqında məlumatları dəyişdirə bilər?', '<p>Bəli.</p>\r\n\r\n<p>Şəxsi kabinetə daxil olaraq <strong>&ldquo;Ayarlar&rdquo;</strong> pəncərəsində <strong>&ldquo;Profil&rdquo;</strong> bəndini se&ccedil;mək lazımdır. Bundan sonra zəruri olan d&uuml;zəlişləri həyata ke&ccedil;irmək m&uuml;mk&uuml;n olacaq.</p>\r\n'),
(46, 16, 'en', 'How does mail work in user’s account?', '<p>With the help of a mailbox to the&nbsp;personal&nbsp;account, buyers and suppliers can freely send messages to each other regarding the issues of a particular tender.</p>\r\n'),
(47, 16, 'ru', 'Как работает почта в личном кабинете пользователя?', '<p>При помощи почтового ящика в личном кабинете, покупатели и поставщики могут свободно отправлять сообщения друг другу, касательно вопросов того или иного тендера.</p>\r\n'),
(48, 16, 'az', 'İstifadəçinin şəxsi kabinetindəki poçt necə çalışır?', '<p>Şəxsi kabinetdəki po&ccedil;t qutusunun k&ouml;məkliyi ilə alıcılar və&nbsp;təchizat&ccedil;ılar sərbəst<br />\r\nşəkildə biri birilərinə&nbsp;bu və ya digər tenderlərə aid olan sualları g&ouml;ndərə bilərlər.</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `industries`
--

CREATE TABLE `industries` (
  `industryId` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `industries`
--

INSERT INTO `industries` (`industryId`) VALUES
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
  `langId` int(10) UNSIGNED NOT NULL,
  `industryId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `industries_lang`
--

INSERT INTO `industries_lang` (`langId`, `industryId`, `lang`, `name`) VALUES
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
-- Структура таблицы `pages`
--

CREATE TABLE `pages` (
  `pageId` int(10) UNSIGNED NOT NULL,
  `alias` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `pages`
--

INSERT INTO `pages` (`pageId`, `alias`) VALUES
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
  `langId` int(10) UNSIGNED NOT NULL,
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

INSERT INTO `pages_lang` (`langId`, `pageId`, `lang`, `title`, `keywords`, `description`, `text`) VALUES
(1, 1, 'en', 'Contacts', '', '', '<p>office@mytender.az</p>\r\n'),
(2, 1, 'ru', 'Контакты', '', '', '<p>office@mytender.az</p>\r\n'),
(3, 1, 'az', 'Əlaqə', '', '', '<p>office@mytender.az</p>\r\n'),
(4, 2, 'en', 'About us', '', '', '<p><big><em>The platform MYTENDER.AZ&nbsp;is a practical and complete&nbsp;solution for conducting business activities in the B2B (business-to-business) segment, focused on providing reliable and high-quality services in the field of procurement.</em></big></p>\r\n\r\n<p><big><em>At the peak of the development of information and digital technologies in all spheres of human life, including the economies of many countries in the world, the use and provision of transparent, reliable and high-quality services in the field of entrepreneurship is becoming more urgent. The current trend of digitalization of various segments of the economy is of particular importance.&nbsp;The goal of the&nbsp;platform MYTENDER.AZ is to achieve maximum transparency of trade relations. And this is clearly reflected in the slogan - &quot;The Way to Transparency.&quot; </em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><strong><em><big>Our mission:</big></em></strong></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><big><em>To provide assistance to the business segment in finding new business opportunities.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>To assist in conducting transparent and effective business activities.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>To make the business accessible and competitive.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>To meet the standards of international business.</em></big></p>\r\n\r\n	<hr /></li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>MYTENDER.AZ&nbsp;is a platform for entrepreneurs who will become a catalyst for each other in conducting of mutually beneficial and successful business. The platform is a kind of link in the provision of opportunities to promote, implement and develop trade and market relations.</em></big></p>\r\n\r\n<p><big><em>MYTENDER.AZ&nbsp;is a platform for business, for all who appreciate their time and money.</em></big></p>\r\n'),
(5, 2, 'ru', 'О нас', '', '', '<p><big><em>Платформа MYTENDER.AZ&nbsp;&ndash; представляет собой практичное и комплексное решение для ведения предпринимательской деятельности в сегменте B2B (business-to-business), ориентированный на оказании надежных и качественных услуг в сфере закупок.</em></big></p>\r\n\r\n<p><big><em>На пике развития информационных и цифровых технологий во всех сферах жизнедеятельности человека, включая экономику множеств стран мира, становится все более актуальным использование и предоставление прозрачных, надежных и качественных услуг в сфере предпринимательства. Особую роль здесь играет сегодняшняя тенденция цифровизации различных сегментов экономики.&nbsp;Целью&nbsp;платформы MYTENDER.AZ является достижения максимальной прозрачности в торговых отношениях.&nbsp;</em><em>Это ясно отражено в слогане платформы&nbsp;&ndash; &laquo;Путь к прозрачности&raquo;. </em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em><strong>Наша миссия:</strong></em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><big>​​​​<em>Предоставить содействие бизнес-сегменту в нахождении новых бизнес возможностей.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Помощь в ведении прозрачной и эффективной предпринимательской деятельности.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Сделать бизнес доступным и конкурентоспособным.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Соответствовать стандартам международного бизнеса.</em></big></p>\r\n\r\n	<hr /></li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>MYTENDER.AZ&nbsp;&ndash; платформа для предпринимателей, которые станут катализатором друг для друга в ведении взаимовыгодного и успешного бизнеса. Платформа является своего рода связующим звеном в предоставлении возможности продвигать, реализовывать и развивать торгово-рыночные отношения.</em></big></p>\r\n\r\n<p><big><em>MYTENDER.AZ&nbsp;&ndash; это платформа для бизнеса, для всех кто ценит свое время и деньги.</em></big></p>\r\n'),
(6, 2, 'az', 'Haqqımızda', '', '', '<p><big><em>MYTENDER.AZ&nbsp;platforması &nbsp;satınalmalar sahəsində etibarlı və keyfiyyətli xidmətlərin g&ouml;stərilməsinə istiqamətlənmiş B2B (business-to-business) seqmentində sahibkarlıq fəaliyyətinin aparılması &uuml;&ccedil;&uuml;n praktiki və kompleks həllərdən ibarətdir.</em></big></p>\r\n\r\n<p><big><em>İnformasiya və rəqəmsal texnologiyaların inkişafının ən zirvə n&ouml;qtəsində d&uuml;nyanın bir &ccedil;ox &ouml;lkələrinin iqtisadiyyatı da daxil olmaqla insan fəaliyyətinin b&uuml;t&uuml;n sferalarında sahibkarlığa aid şəffaf, etibarlı və keyfiyyətli xidmətlərin istifadəsi və təqdim edilməsi daha &ccedil;ox aktual olur. Burada x&uuml;susi rolu bug&uuml;nk&uuml; iqtisadiyyatın m&uuml;xtəlif seqmentlərinin rəqəmsallaşdırılması tendensiyası oynayır. MYTENDER.AZ platformanın&nbsp;məqsədi ticarət əlaqələrinin maksimal şəffaflığının əldə edilməsidir. Və bu artıq ş&uuml;ardan da məlum olur &ndash; &ldquo;Şəffaflığa doğru&nbsp;yol&rdquo;. </em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em><strong>Missiyamız:</strong></em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p><big><em>Yeni biznes imkanlarının tapılması &uuml;zrə biznes-seqmentinə yardım g&ouml;stərmək.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Şəffaf və səmərəli sahibkarlıq fəaliyyətinin aparılmasına k&ouml;mək etmək.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Biznesin əl&ccedil;atan və rəqabətədavamlı olmasını təmin etmək.</em></big></p>\r\n\r\n	<hr /></li>\r\n	<li>\r\n	<p><big><em>Beynəxalq biznes standartları ilə uyğunlaşmaq.</em></big></p>\r\n\r\n	<hr /></li>\r\n</ul>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>MYTENDER.AZ - qarşılıqlı faydalı və uğurlu biznesin aparılmasında qarşılıqlı olaraq bir-birinə katalizator olacaq sahibkarlar &uuml;&ccedil;&uuml;n nəzərdə tutulmuş platformadır. Bu platforma ticarət və bazar m&uuml;nasibətlərinin təşviq edilməsi, həyata ke&ccedil;irilməsi və inkişaf etdirilməsi imkanlarının təmin edilməsi &uuml;zrə bir n&ouml;v k&ouml;rp&uuml; olacaqdır.</em></big></p>\r\n\r\n<p><big><em>MYTENDER.AZ - biznes, həm&ccedil;inin vaxtını və pulunu dəyərləndirən şəxslər &uuml;&ccedil;&uuml;n platformadır.</em></big></p>\r\n'),
(7, 3, 'en', 'The Blog', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(8, 3, 'ru', 'Блог', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(9, 3, 'az', 'Blog', '', '', '<p>sfsd fsdf ыва ыва ыва</p>\r\n'),
(10, 4, 'en', 'Our services', '', '', '<p>&nbsp;</p>\r\n\r\n<p><em><strong><big>The platform MYTENDER.AZ provides the following services to entrepreneurs:</big></strong></em></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Tender support and execution of cases of a person wishing to participate in the transaction</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Selection of tenders, which correspond to the purposes and desires of the customer</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Legal and expert evaluation of the order, tender documentation, possible risks</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Preparation and execution of applications</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Consulting activities at all stages of the tender process</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Consulting in the B2B segment</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Business announcements and mailings for new projects, start-ups and tenders</em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>►&nbsp;The above services are paid. </em></big></p>\r\n\r\n<p><big><em>For additional information, please contact by e-mail <strong>office@mytender.az</strong>&nbsp;</em></big></p>\r\n'),
(11, 4, 'ru', 'Услуги', '', '', '<p>&nbsp;</p>\r\n\r\n<p><big><em><strong>Платформа MYTENDER.AZ&nbsp;предоставляет следующие услуги предпринимателям:</strong></em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Тендерное сопровождение и оформление дел лица, желающего принять участие в сделке</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Подбор тендеров, которые соответствуют целям и желаниям заказчика</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Юридическая и экспертная оценка заказа, тендерной документации, возможных рисков</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Подготовка и оформление заявок</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Консультационная деятельность на всех этапах тендерного процесса</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Консалтинг в сегменте B2B</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Бизнес-объявления и рассылки по новым проектам, стратапам и тендерам</em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>►&nbsp;Вышеуказанные услуги являются платными. </em></big></p>\r\n\r\n<p><big><em>Для того чтобы воспользоваться указанными услугами, пожалуйста оставьте заявку по электронной почте&nbsp;<strong>office@mytender.az</strong></em></big></p>\r\n'),
(12, 4, 'az', 'Xidmətlər', '', '', '<p>&nbsp;</p>\r\n\r\n<p><big><em><strong>MYTENDER.AZ platforması sahibkarlara aşağıdakı xidmətləri g&ouml;stərir:</strong></em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Tender m&uuml;şayiəti və s&ouml;vdələşmədə iştirak etmək istəyən şəxsin sənədlərinin qeydiyyatı</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Sifariş&ccedil;inin məqsədlərinə və istəklərinə uyğun gələn tenderlərin se&ccedil;ilməsi</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Sifarişin, tender sənədlərinin, m&uuml;mk&uuml;n risklərin h&uuml;quqi və ekspert qiymətləndirilməsi</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; M&uuml;raciətlərin hazırlanması və qeydiyyatının aparılması</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Tender prosesinin b&uuml;t&uuml;n mərhələlərində məsləhət&ccedil;ilik fəaliyyəti</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; B2B seqmenti &uuml;zrə konsaltinq</em></big></p>\r\n\r\n<p><big><em>&nbsp; &nbsp;✔&nbsp; Biznes elanları və yeni layihələr, start-aplar və tenderlər &uuml;zrə paylaşmalar</em></big></p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><big><em>►&nbsp;Yuxarıda qeyd olunan xidmətlər &ouml;dənişlidir. </em></big></p>\r\n\r\n<p><big><em>Qeyd olunan xidmətlərdən istifadə etmək &uuml;&ccedil;&uuml;n zəhmət olmasa <strong>office@mytender.az </strong>elektron po&ccedil;t vasitəsi ilə&nbsp;əlaqə saxlamağınız xahiş olunur.</em></big></p>\r\n'),
(13, 5, 'en', 'Our partners', '', '', ''),
(14, 5, 'ru', 'Партнеры', '', '', ''),
(15, 5, 'az', 'Tərəfdaşlarımız', '', '', ''),
(16, 6, 'en', 'Terms of Use and Privacy Policy', '', '', '<p><strong>1. Basic provisions</strong>. Mytender.az (hereinafter - the platform) undertakes to keep your privacy on the Internet. This Privacy Policy is about the collection, procession and storage of your personal data. This platform attaches high priority to protecting the personal information of users. By using the platform, the user agrees to the application of the rules for the collection and use of the data set forth in this document.</p>\r\n\r\n<p><strong>2. Information</strong><strong>.</strong></p>\r\n\r\n<p><strong>2.1 Information collected. </strong>The platform collects the following data about the users of the site:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Full name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● E-mail address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Phone number</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Taxpayer ID</p>\r\n\r\n<p><strong>2.2&nbsp;Use of information</strong><strong>. </strong>Here are some ways to use the user&#39;s personal information:<strong> </strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to provide information and services that the user requests;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to respond to user requests.</p>\r\n\r\n<p><strong>2.3 Storage of information. </strong>The platform stores your personal information for the duration of the activity of your user account or for the time necessary to provide you with services. We can store personal information even after deactivating your user account and / or stopping the use of any specific services,&nbsp;to the extent necessary for the performance of our legal duties, for resolving disputes with users of the&nbsp;platform, preventing fraud and abuse, execution of our agreements and protection of our legitimate interests.</p>\r\n\r\n<p><strong>2.4 Information disclosure</strong><strong>. </strong>The platform does not transfer the user&#39;s personal data to third parties without the user&#39;s consent. The platform reserves the right to delete invalid accounts or accounts with forged names and registration data.</p>\r\n\r\n<p><strong>3. Advertising messages. </strong>By providing your email address or any other contact information (for example, your phone number or username on the social network), you agree to receive promotional messages, messages or calls from the platform staff. Accordingly, the platform employees have the right to call or send you mailings or messages via e-mail, SMS, personal text messages, make marketing calls or use similar&nbsp;forms communication. If you do not want to receive such advertisements or calls, you can notify the platform at any time, or follow the instructions on unsubscribing contained in the advertisements you received.</p>\r\n\r\n<p><strong>4. Security. </strong>The platform has adopted security measures designed to protect the personal information that you share with us, including physical, electronic and procedural measures. Among other things, the platform offers secure access to most of our services using the HTTPS protocol; transfer of confidential payment information (for example, a credit card number) through our specially designed forms that are protected by an encrypted connection of the industry standard SSL / TLS. The platform also regularly monitors the system for possible vulnerabilities and attacks, and is constantly looking for new solutions to improve the security of our services.</p>\r\n\r\n<p><strong>5. Terms of use</strong>.</p>\r\n\r\n<p><strong>5.1</strong> The platform asks users to avoid conflict situations and other violations, which can lead to undesirable consequences. In case this happens, the platform, having analyzed the situation, undertakes to act appropriately to prevent such actions henceforth.</p>\r\n\r\n<p><strong>5.2</strong> This Privacy policy, its interpretation, and any claims and disputes related to this instrument are regulated, interpreted and executed only and exclusively in accordance with the basic internal laws of the Republic of Azerbaijan. Hereby, you agree that any claims and disputes shall be resolved only by a competent court&nbsp;located in the Republic of Azerbaijan.</p>\r\n\r\n<p><strong>6. Deleting</strong><strong> </strong><strong>an</strong><strong> </strong><strong>account</strong><strong>. </strong>You can request the removal of your Personal Information from our blogs, communities or forums by contacting us&nbsp;at&nbsp;<a href=\"mailto:office@mytender.az?subject=email&amp;body=email\">office@mytender.az</a></p>\r\n'),
(17, 6, 'ru', 'Правила пользования и политика конфиденциальности.', '', '', '<p><strong>1. Основные положения. </strong>Mytender.az (далее &ndash; платформа) обязуется хранить Вашу конфиденциальность в сети Интернет.&nbsp;Настоящая Политика Конфиденциальности, рассказывает о том, как собираются, обрабатываются и хранятся Ваши личные данные. Данная платформа уделяет большое внимание защите личной информации пользователей.&nbsp;Пользуясь платформой, пользователь дает согласие на применение правил сбора и использования данных, изложенных в настоящем документе.&nbsp;</p>\r\n\r\n<p><strong>2. Информация.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;Собираемая информация. </strong>Платформа собирает следующую информацию о пользователях сайта:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Фамилия, Имя</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Адрес электронной почты</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Номер телефона</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Название компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Адрес компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Идентификационный номер налогоплательщика</p>\r\n\r\n<p><strong>2.2&nbsp;Использование информации. </strong>Ниже описаны некоторые способы использования личной информации пользователя:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для предоставления информации и услуг, которые&nbsp;&nbsp;запрашивает пользователь;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для ответа на запросы пользователя.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Хранение информации. </strong>Платформа хранит вашу персональную информацию в течение всего времени активности вашей пользовательской учётной записи либо в течение времени, необходимого для оказания вам услуг. Хранение персональной информации может осуществляться нами даже после деактивации вашей пользовательской учётной записи и/или прекращения использования каких-либо конкретных услуг, в той мере, какой это необходимо для исполнения наших юридических обязанностей, для урегулирования споров в отношении пользователей платформы, предотвращения мошенничества и злоупотреблений, исполнения наших соглашений и защиты наших законных интересов.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong><strong>Раскрытие информации</strong><strong>. </strong>Платформа не продает личные данные пользователя и не передает их третьим лицам без согласия на то пользователя. Платформа оставляет за собой право удалять недействительные учетные записи или учетные записи с поддельными названиями и регистрационными данными.</p>\r\n\r\n<p><strong>3.&nbsp;Рекламные сообщения. </strong>Предоставляя адрес вашей электронной почты или любую другую контактную информацию (например, ваш номер телефона или имя пользователя в социальной сети), вы соглашаетесь на получение рекламных рассылок, сообщений или звонков от сотрудников платформы. Соответственно, сотрудники платформы, вправе звонить или направлять вам рекламные рассылки или сообщения по электронной почте, SMS, личные текстовые сообщения, делать маркетинговые звонки или использовать аналогичные формы общения. Если вы не хотите получать такие рекламные сообщения или звонки, вы можете уведомить платформу в любое время, или выполнить инструкции по отказу от подписки, содержащиеся в рекламных сообщениях, которые вы получили.</p>\r\n\r\n<p><strong>4.&nbsp;Безопасность. </strong>Платформа приняла меры безопасности, предназначенные для защиты персональной информации, которой вы делитесь с нами, в том числе физические, электронные и процедурные меры. Среди прочего, платформа предлагает безопасный доступ к большинству ресурсов наших услуг по протоколу HTTPS; передачу конфиденциальной информации по оплате (например, номер кредитной карты) через наши специально разработанные формы, которые защищены шифрованным соединением отраслевого стандарта SSL/TLS. Платформа также регулярно отслеживает систему на предмет возможных уязвимых мест и атак, и постоянно ищем новые решения для повышения безопасности наших услуг.</p>\r\n\r\n<p><strong>5.&nbsp;Правила пользования.</strong></p>\r\n\r\n<p><strong>5.1 &nbsp;</strong>Платформа просит пользователей<strong> </strong>избегать конфликтные ситуации и другие нарушения, которые могут повлечь за собою нежелательные последствия. В случае если такое имеет место быть, платформа, проанализировав ситуацию обязуется предпринять надлежащие меры по недопущению подобных действий впредь.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Настоящая политика конфиденциальности, её толкование, и любые претензии и споры, связанные с настоящим документом, регулируются, трактуются и исполняются только и исключительно в соответствии с основными внутренними законами Азерабайджанской Республики. Настоящим, вы соглашаетесь, что любые претензии и споры подлежат разрешению исключительно компетентным судом, находящимся в Азербайджанской Республике.</p>\r\n\r\n<p><strong>6.&nbsp;Удаление учетной записи. </strong>Вы можете запросить удаление вашей Персональной информации из наших блогов, сообществ или форумов, обратившись к нам по адресу <a href=\"mailto:office@mytender.az\">office@mytender.az</a></p>\r\n'),
(18, 6, 'az', 'İstifadə qaydaları və məxfilik siyasəti.', '', '', '<p><strong>1. Əsas m&uuml;ddəalar.</strong><strong> </strong>Mytender.az (bundan sonra platforma adlandırılacaq) İnternet şəbəkəsində məxfiliyinizi qorumağı &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r. Hazırki Məxfilik Siyasəti Sizin şəxsi məlumatlarınızın toplanması, işlənməsi və saxlanılması barədə məlumatları ehtiva edir. Platformadan istifadə etməklə istifadə&ccedil;i hazırki sənəddə yer alan məlumatların toplanması və istifadəsi qaydalarının tətbiq edilməsinə razılığını bildirir.</p>\r\n\r\n<p><strong>2. Məlumat.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;</strong><strong>Toplanılan məlumat</strong><strong>. </strong>Platforma sayt istifadə&ccedil;iləri haqqında aşağıdakı məlumatları toplayır:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Adı, soyadı</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Elektron po&ccedil;t &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Telefon n&ouml;mrəsini</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin adını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Vergi &ouml;dəyicisinin eyniləşdirmə n&ouml;mrəsini</p>\r\n\r\n<p><strong>2.2&nbsp;</strong><strong>Məlumatların istifadə edilməsi. </strong>Aşağıda istifadə&ccedil;inin şəxsi məlumatlarının bir ne&ccedil;ə istifadə yolları təsvir edilmişdir:<br />\r\n&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● istifadə&ccedil;inin tələb etdiyi məlumatların və xidmətlərin təqdim edilməsi &uuml;&ccedil;&uuml;n;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● istifadə&ccedil;inin m&uuml;raciətlərinə cavab vernək &uuml;&ccedil;&uuml;n.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Məlumatların saxlanılması. </strong>Platforma sizin şəxsi məlumatlarınızı istifadə&ccedil;i hesabınızın aktiv olduğu m&uuml;ddətdə və ya xidmətlərin g&ouml;stərilməsi &uuml;&ccedil;&uuml;n zəruri olan vaxt ərzində saxlayır. Şəxsi məlumatların saxlanılması h&uuml;quqi &ouml;hdəliklərimizin yerinə yetirilməsinin, platforma istifadə&ccedil;ilərinin m&uuml;bahisələrinin tənzimlənməsinin, saxtakarlığın və sui-istifadənin qarşısının alınmasının, razılaşmalarımızın icrasının və qanuni mənafelərimizin qorunmasının zəruriliyi baxımından, hətta, sizin istifadə&ccedil;i hesabınızın ləğv edilməsindən və / və ya hər hansı x&uuml;susi xidmətlərin istifadəsinin dayandırılmasından sonra da həyata ke&ccedil;irilə bilər.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong><strong>Məlumatların a&ccedil;ıqlanması. </strong>Platforma istifadə&ccedil;inin şəxsi məlumatlarını həmin istifadə&ccedil;inin razılığı olmadan &uuml;&ccedil;&uuml;nc&uuml; şəxslərə &ouml;t&uuml;rm&uuml;r. Platforma etibarsız hesabların və ya saxta adları və qeydiyyat məlumatlarını ehtiva edən hesabların silinməsi h&uuml;ququna malikdir.</p>\r\n\r\n<p><strong>3.&nbsp;Reklam xarakterli mesajlar. </strong>Elektron po&ccedil;t &uuml;nvanınızı və ya digər istənilən əlaqə məlumatınızı (məsələn, telefon n&ouml;mrəsini və ya sosial şəbəkədə istifadə&ccedil;i adını) təqdim etməklə, Siz platforma əməkdaşlarından reklam xarakterli paylaşmaların, mesajların və ya zənglərin qəbul edilməsinə razılığınızı bildirirsiniz. M&uuml;vafiq olaraq, platforma əməkdaşları elektron po&ccedil;tunuza reklam xarakterli paylaşmaları və ya mesajları, SMS, şəxsi mətn mesajlarını g&ouml;ndərmək, marektinq zəngləri etmək və ya analoji əlaqə formalarından istifadə etmək h&uuml;ququna malikdir. Bu c&uuml;r reklam xarakterli mesajları və ya zəngləri qəbul etmək istəmədiyiniz təqdirdə, istənilən vaxt platformaya bildiriş g&ouml;ndərə və ya aldığınız reklam xarakterli mesajlarda yer alan abunə&ccedil;ilikdən imtina təlimatına riayət edə bilərsiniz.</p>\r\n\r\n<p><strong>4.&nbsp;Təhl&uuml;kəsizlik. </strong>Platforma bizimlə paylaşdığınız şəxsi məlumatların fiziki, elektron və icra tədbirləri də olmaqla təhl&uuml;kəsizlik tədbirlərini həyata ke&ccedil;irəcəkdir. Bundan savayı, platforma HTTPS protokolu &uuml;zrə bir sıra xidmətlər resursuna təhl&uuml;kəsiz girişi, SSL / TLS sahə standartının şifrələnmiş birləşməsi ilə qorunan x&uuml;susi tərtib edilmiş formalar vasitəsilə &ouml;dəniş (məsələn, kredit kartının n&ouml;mrəsi) yolu ilə məxfi məlumatların &ouml;t&uuml;r&uuml;lməsini də təklif edir. Platforma, həm&ccedil;inin, m&uuml;təmadi olaraq m&uuml;mk&uuml;n &ccedil;atışmazlıqların və h&uuml;cumların baş verə biləcəyi &uuml;zrə sistemə nəzarət edir. Xidmətlərimizin təhl&uuml;kəsizliyinin artırılması &uuml;&ccedil;&uuml;n yeni həllər yolunu axtarırıq.</p>\r\n\r\n<p><strong>5.&nbsp;İstifadə qaydaları.</strong></p>\r\n\r\n<p><strong>5.1 </strong>Platforma istifadə&ccedil;ilərdən xoşagəlməz nəticələrə gətirib &ccedil;ıxara biləcək m&uuml;bahisəli halların və digər pozuntuların yaranmamasını tələb edir. Belə hallara yol verildiyi təqdirdə, platforma yaranmış vəziyyəti təhlil edərək gələcəkdə buna bənzər halların yol verilməməsi &uuml;zrə m&uuml;vafiq tədbirləri həyata ke&ccedil;irməyi &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Hazırki məxfilik siyasəti, onun təfsiri və hazırki sənədlə əlaqədar istənilən iradlar və m&uuml;bahisələr yalnız və m&uuml;stəsna olaraq Azərbaycan Respublikasının əsas daxili qanunları ilə tənzimlənir, təfsir edilir və icra edilir. Bununla da, siz iradların və m&uuml;bahisələrin m&uuml;stəsna olaraq Azərbaycan Respublikasında yerləşən səlahiyyətli məhkəmələr tərəfindən həll edilməsinə razılığınızı bildirirsiniz.</p>\r\n\r\n<p><strong>6.&nbsp;Hesabın silinməsi. </strong>Siz <a href=\"mailto:office@mytender.az\">office@mytender.az</a>&nbsp;elektron &uuml;nvan&nbsp;&uuml;zrə m&uuml;raciət etməklə bloqlarımızdan, toplumlarımızdan və ya forumlarımızdan şəxsi məlumatlarınızın silinməsini tələb edə bilərsiniz.</p>\r\n\r\n<p>&nbsp;</p>\r\n'),
(19, 7, 'en', 'Why mytender.az?', '', '', '<p><em><strong><big>✔&nbsp; Free registration</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Low tariffs for the provision of services</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Individual approach</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Transparent business activities in conducting transactions</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Positioning in the B2B market</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Cost and time effectiveness</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Control of purchases/deliveries remotely</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Entrance both to the local and international market B2B</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Accessibility and automation</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Mutually beneficial partnership</big></strong></em></p>\r\n'),
(20, 7, 'ru', 'Почему mytender.az?', '', '', '<p><em><strong><big>✔&nbsp; Бесплатная регистрация</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Невысокие тарифы предоставления услуг</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Индивидуальный подход</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Прозрачная предпринимательская деятельность в ведении сделок</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Позиционирование на рынке B2B</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Экономия средств и времени</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Контроль по закупкам/поставкам дистанционно</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Выход как на локальный, так и международный рынок B2B</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Доступность и автоматизация</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Взаимовыгодное партнерство</big></strong></em></p>\r\n'),
(21, 7, 'az', 'Niyə mytender.az?', '', '', '<p><em><strong><big>✔&nbsp; Pulsuz qeydiyyat</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Xidmətlərin g&ouml;stərilməsi &uuml;zrə aşağı tariflər</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Fərdi yanaşma</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; S&ouml;vdələşmələrin aparılmasında şəffaf sahibkarlıq fəaliyyəti</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; B2B bazarında yerləşdirmə</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Pula və vaxta qənaət</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Məsafədən satınalmalara / &ccedil;atdırılmalara nəzarət</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Həm yerli, həm də beynəlxalq B2B bazarına &ccedil;ıxış</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; M&uuml;mk&uuml;nl&uuml;k və avtomatlaşdırma</big></strong></em></p>\r\n\r\n<p><em><strong><big>✔&nbsp; Qarşılıqlı faydalı əməkdaşlıq</big></strong></em></p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `postFiles`
--

CREATE TABLE `postFiles` (
  `fileId` int(11) NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `tenderId` int(10) UNSIGNED DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `secret` varchar(30) DEFAULT NULL,
  `uploadedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `postIndustries`
--

CREATE TABLE `postIndustries` (
  `id` int(10) UNSIGNED NOT NULL,
  `postId` int(10) UNSIGNED NOT NULL,
  `industryId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `postId` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `finishedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `posts_lang`
--

CREATE TABLE `posts_lang` (
  `langId` int(10) UNSIGNED NOT NULL,
  `postId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `tenderFiles`
--

CREATE TABLE `tenderFiles` (
  `fileId` int(11) NOT NULL,
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

INSERT INTO `tenderFiles` (`fileId`, `userId`, `tenderId`, `file`, `caption`, `type`, `size`, `secret`, `uploadedAt`) VALUES
(13, 2, NULL, 'tender_59d496c291ade8.87081237.doc', 'Alqı_Satqı müqaviləsi.doc', 'application/msword', 33280, '59d496aba5ed47.18944622', '2017-10-04 08:07:30'),
(14, 2, NULL, 'tender_59d496cd63baf9.65411237.xlsx', 'alkopan Qazax Əhəng z.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 17489, '59d496aba5ed47.18944622', '2017-10-04 08:07:41'),
(18, 2, NULL, 'tender_59e9fd715f5016.29135275.pdf', 'pencere.pdf', 'application/pdf', 94528, '59e9fcdea3a664.92529583', '2017-10-20 13:43:13'),
(19, 2, NULL, 'tender_59e9fd9eb4a360.15062736.xlsx', 'check.xlsx', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 79120, '59e9fcdea3a664.92529583', '2017-10-20 13:43:58'),
(20, 2, NULL, 'tender_59e9fdb74f9061.76141220.txt', 'For Kostya_ mytenderaz.txt', 'text/plain', 1481, '59e9fcdea3a664.92529583', '2017-10-20 13:44:23'),
(22, 2, NULL, 'tender_59ef8d0b967706.01183497.txt', 'New Text Document.txt', 'text/plain', 748, '59ef8ccbdd72e2.02869019', '2017-10-24 18:57:15'),
(27, 55, NULL, 'tender_59f6ddc355e890.47646226.txt', 'resume.txt', 'text/plain', 1332, '59f6dd20cec9b6.38581586', '2017-10-30 08:07:31'),
(28, 55, 32, 'tender_59f6e22e3d0437.99662121.txt', 'resume.txt', 'text/plain', 1332, '59f6e1d392cee7.91081469', '2017-10-30 08:26:22'),
(30, 55, 33, 'tender_59f6e31dad00c8.81060829.txt', 'resume.txt', 'text/plain', 1332, '59f6e2eb1cda25.12418156', '2017-10-30 08:30:21'),
(33, 65, NULL, 'tender_59fac07464d782.16007099.docx', '111.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 12676, '59fabfd16d2a80.05180220', '2017-11-02 06:51:32'),
(34, 65, 52, 'tender_59fae470302e74.50839824.docx', 'Testin.docx', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 11365, '59fae3e17b0518.58028254', '2017-11-02 09:25:04');

-- --------------------------------------------------------

--
-- Структура таблицы `tenders`
--

CREATE TABLE `tenders` (
  `tenderId` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `industryId` int(10) UNSIGNED NOT NULL,
  `description` varchar(255) NOT NULL,
  `description_full` text NOT NULL,
  `contact` int(10) UNSIGNED DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `finishedAt` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `tenders`
--

INSERT INTO `tenders` (`tenderId`, `userId`, `name`, `createdAt`, `industryId`, `description`, `description_full`, `contact`, `status`, `finishedAt`) VALUES
(27, 2, 'Züxeri', '2017-10-25 06:50:22', 5, 'Fiber cement', '<p>Fiber - Spectra fiber (38 &micro;m in diameter) and Snia fiber (20 &micro;m in diameter) (Both are high modulus polyethylene fibers probably with different surface finish, supplied by different manufacturers).</p>\r\n\r\n<p>Matrix - Plain matrix (w/c=0.5 and no admixture) and SF matrix (silica fume/c=0.20, w/c=0.27, superplasticizer/c=0.05). Curing condition -</p>\r\n\r\n<p>Specimens are moisture-cured until the date of testing. Age of testing - 0.5, 1, 1.5, 2, 7, 14, 21, 28 days. For each material system, at least 3 specimens are tested at each age.</p>\r\n', 41, -1, '2017-11-24 09:50:00'),
(30, 55, 'INNEXIM', '2017-10-26 10:02:24', 7, 'Logistic operations', '<p>4 zone Europe and worlwide</p>\r\n\r\n<p>Need logistic services from Italy and&nbsp;Spain to Azerbaijan.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Kindly ask you to send offers through.</p>\r\n\r\n<p>If reffered&nbsp;prices and services is Ok we will make negotiating directly.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 44, -1, '2017-11-05 13:00:00'),
(31, 65, 'Anty Boss', '2017-10-27 19:19:32', 9, 'Нефтехимическое состовляющее', '<p>Мазут, нефтепродукты, масла</p>\r\n\r\n<p>Для получения лополнительной информации просим отправить сообщение.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, -1, '2017-12-29 23:00:00'),
(32, 55, 'Transport Tender', '2017-10-30 08:27:01', 7, 'Transport Tender -------- short description', '<p>Transport Tender -------- Full description</p>\r\n', 44, -1, '2017-11-04 11:25:00'),
(33, 55, 'Transport Tender 2', '2017-10-30 08:30:23', 7, 'Test foot and Beverage -------- short description', '<p>Transport Tender -------- full description</p>\r\n', 44, -1, '2017-11-04 11:29:00'),
(34, 2, 'IT ', '2017-10-30 14:22:01', 12, 'Computers and ups', '<p>Upon request</p>\r\n', 41, -1, '2017-11-05 17:21:00'),
(35, 55, 'Кабельные коммуникации', '2017-10-30 16:03:08', 12, 'Кабельные коммуникации', '<p>Кабели 3х4, 2х3</p>\r\n\r\n<p>количество: 100</p>\r\n\r\n<p>срок поставки: 5-10 дней</p>\r\n\r\n<p>&nbsp;</p>\r\n', 44, -1, '2017-11-05 19:01:00'),
(36, 55, 'HUB installing', '2017-10-31 06:26:25', 12, 'HUBS and SWITCHS', '<p>Needed services on HUB and SWITCH installing</p>\r\n\r\n<p>Capacity: two buildings</p>\r\n', 44, -1, '2017-11-05 09:28:00'),
(37, 65, 'Storages', '2017-10-31 13:42:11', 12, 'Implementing data storages', '<p>Specs:</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>The data staging area</p>\r\n	</li>\r\n	<li>\r\n	<p>The overall corporate data warehouse</p>\r\n	</li>\r\n	<li>\r\n	<p>Each of the dependent data marts, beginning with the first</p>\r\n	</li>\r\n	<li>\r\n	<p>Any multidimensional databases for OLAP</p>\r\n	</li>\r\n	<li>\r\n	<p>The data staging area</p>\r\n	</li>\r\n	<li>\r\n	<p>Each of the conformed data marts, beginning with the first</p>\r\n	</li>\r\n	<li>\r\n	<p>Any multidimensional databases for OLAP</p>\r\n	</li>\r\n</ul>\r\n', 48, -1, '2017-11-11 16:39:00'),
(38, 65, 'Roof purchasing', '2017-11-01 11:34:52', 5, 'Roofs', '<p>1. Asphalt Shingles</p>\r\n\r\n<p>2.&nbsp;Fiberglass Shingles</p>\r\n\r\n<p>3.&nbsp;Organic Shingles</p>\r\n\r\n<p>4.&nbsp;Tile Shingles</p>\r\n\r\n<p>5.&nbsp;Wood Shingles</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Need information:</p>\r\n\r\n<p><em><strong>Square price of shingles?</strong></em><br />\r\n<em><strong>Cost to install?</strong></em></p>\r\n', 48, -1, '2017-12-10 14:29:00'),
(46, 2, 'Comps', '2017-11-01 19:46:37', 12, 'Computers purchase', '<p>Computers</p>\r\n', 41, -1, '2017-12-05 22:43:00'),
(51, 2, 'Cardreaders', '2017-11-02 08:14:41', 6, 'Cardreaders', '<p>Purchasing of professional equipment of all types of card readers.</p>\r\n\r\n<p>All related nformation upon request.</p>\r\n', 41, -1, '2017-11-10 08:14:00'),
(52, 65, 'Testing systems', '2017-11-02 09:25:11', 12, 'Testing syst', '<p>Purchasing of testing scholar systems</p>\r\n', 48, -1, '2017-12-10 09:23:00'),
(53, 55, 'Печать полиграфической продукции', '2017-11-08 06:41:31', 15, 'Услуги по полиграфии', '<p>Компании INNEXIM требуются следующие услуги по полиграфии:</p>\r\n\r\n<p>1. Печать флайров/брашюры - 1000 шт.</p>\r\n\r\n<p>2. Рол-апы 5 шт.</p>\r\n\r\n<p>3. Печать на ручках - 100</p>\r\n\r\n<p>4. Печать визиток - количество&nbsp;</p>\r\n\r\n<p>Для большей рентабельности в процесе оценок просим присылать свои предложения через электронную платформу.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 44, -1, '2017-12-10 06:18:00'),
(54, 55, 'Программный софт/фильтр данных', '2017-11-08 06:47:51', 12, 'Приобретение и создание программного софта ', '<p>Описание технического задания:</p>\r\n\r\n<p>Программный по софт по фильтрации данных по недвижимости в сети интернет.</p>\r\n\r\n<p>1. Фильтрация веб-сайтов по купле-продаже недвижимости</p>\r\n\r\n<p>2. Фильтрация (импорт) и сбор в единную базу данных на платформу</p>\r\n\r\n<p>3. Граббинг необходимый информации с общедуступных веб-ресурсов.</p>\r\n\r\n<p>Все предложения просим отправлять посредством электронной платформы.</p>\r\n', 44, -1, '2018-01-05 06:43:00'),
(55, 55, 'Smart parking system', '2017-11-08 07:00:01', 29, 'Rotary parking system', '<p>Completely equiped with safety devices.<br />\r\nCommonly known as mini rotary type, this system is designed to park vehicles by vertically circulating cage in left-right direction. Install in left-over space or small area that to be&nbsp;free from breakdowns because of the simple circular rotation type mechanism.&nbsp;</p>\r\n\r\n<p>Needed charachteristics and requirements:</p>\r\n\r\n<p>1. Parking of 7 to 12 vehicles on footprint&nbsp;</p>\r\n\r\n<p>2. Possibility of extension of 1 to 3 footprints</p>\r\n\r\n<p>3. Automated one-touch control</p>\r\n\r\n<p>4. Possible&nbsp;for SUVs and sedans</p>\r\n\r\n<p>5. Conforming to internation standards of quality ISO 9001</p>\r\n\r\n<p>Kindly ask you to send all offers via eplatform.</p>\r\n', 44, -1, '2017-12-31 06:51:00'),
(56, 55, 'Удаленное виделнаблюдение', '2017-11-08 07:10:09', 24, 'Удаленное и беспроводное видеонаблюдение.', '<p>Необходима предоставление услуг в сфере видеонаблюдения.</p>\r\n\r\n<p>Цель и задачи:</p>\r\n\r\n<p>1. Удаленное видеонаблюдение посредством сети интернет с возможностью записи информации в клаудинг.</p>\r\n\r\n<p>2. Просмотр и анализ данных через клаудинг повсеместно где имеется выход в интернет.</p>\r\n\r\n<p>Количество и сроки закупа будут определятся по договоренности в соответсвия с принятыми задачами.</p>\r\n\r\n<p>Предложения происм высылать посредством электронной платформы.</p>\r\n', 44, -1, '2017-12-31 07:04:00'),
(57, 55, 'Purchasing of data storages', '2017-11-16 05:34:14', 12, 'Purchasing of data storages', '<p>Tech Specifications:</p>\r\n\r\n<ul>\r\n	<li>\r\n	<p>The data staging area</p>\r\n	</li>\r\n	<li>\r\n	<p>The overall corporate data warehouse</p>\r\n	</li>\r\n	<li>\r\n	<p>Each of the dependent data marts, beginning with the first</p>\r\n	</li>\r\n	<li>\r\n	<p>Any multidimensional databases for OLAP</p>\r\n	</li>\r\n	<li>\r\n	<p>The data staging area</p>\r\n	</li>\r\n	<li>\r\n	<p>Each of the conformed data marts, beginning with the first</p>\r\n	</li>\r\n	<li>\r\n	<p>Any multidimensional databases for OLAP</p>\r\n	</li>\r\n</ul>\r\n', 44, -1, '2017-12-10 05:33:00'),
(58, 55, 'установка и подключение умных ИП-камер', '2017-11-16 05:47:25', 6, 'Установка и подключение умных ИП-камер', '<p>Спецификации:</p>\r\n\r\n<p>Камеры видеонаблюдения в формате HD и Full HD</p>\r\n\r\n<p>Количество: 10</p>\r\n\r\n<p>Хранение информации: облако</p>\r\n\r\n<p>Инфраред: да</p>\r\n\r\n<p>Разрешение: неопределенные критерии</p>\r\n\r\n<p>Гарантийное обслуживание - минимум 1 год</p>\r\n\r\n<p>&nbsp;</p>\r\n', 44, -1, '2017-12-10 05:42:00'),
(59, 55, 'установка и подключение умных ИП-камер ', '2017-11-16 05:48:26', 24, 'Установка и подключение умных ИП-камер ', '<p>Спецификации:</p>\r\n\r\n<p>Камеры видеонаблюдения в формате HD и Full HD</p>\r\n\r\n<p>Количество: 10</p>\r\n\r\n<p>Хранение информации: облако</p>\r\n\r\n<p>Инфраред: да</p>\r\n\r\n<p>Разрешение: неопределенные критерии</p>\r\n\r\n<p>Гарантийное обслуживание - минимум 1 год</p>\r\n', 44, -1, '2017-12-10 05:48:00'),
(60, 65, 'TV and TV sets', '2017-11-16 13:07:44', 6, 'Purchasing of TV\'s and TV sets for office', '<p>Specifications</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>1. Diagonal - from 81 to 101 sm</p>\r\n\r\n<p>2. Display: LED</p>\r\n\r\n<p>3. Country of origine: N/A</p>\r\n\r\n<p>4. Quantity: 10 pieces</p>\r\n\r\n<p>5. Colors: black</p>\r\n\r\n<p>6. Price range: not exceeds 200 AZN (+- 10%)</p>\r\n\r\n<p>7. Warranty: necessary</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, -1, '2017-12-10 13:03:00'),
(61, 65, 'Furniture for appartment Hotel in Baku', '2017-11-16 13:25:00', 18, 'Purchasing furniture for appart hotel in Baku', '<p>Specifications;</p>\r\n\r\n<p>10 sets for 10 rooms.</p>\r\n\r\n<p>Each set includes: 1 Kingsize bed, 1 wordrobe, 1 chair, 1 desktable.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>Country of Manufacture: Azerbaijan</p>\r\n\r\n<p>Color: dark brown</p>\r\n\r\n<p>Delivery and instalation: neccesary</p>\r\n\r\n<p>Warranty: nessecary&nbsp;</p>\r\n\r\n<p>Size of bed: 2X2 meters</p>\r\n\r\n<p>Wordrobe: 1.2X1.8 meters</p>\r\n\r\n<p>Desk: standard size</p>\r\n\r\n<p>Chair: standard size</p>\r\n\r\n<p>All meters specifications have to be revised and may occure around +-10%.</p>\r\n\r\n<p>All offers kindly ask you to send via webpage or email.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, -1, '2017-12-31 13:15:00'),
(62, 2, 'air conditions', '2017-11-27 10:43:06', 6, 'Purchasing air conditions', '<p>Purchasing air conditions</p>\r\n', 41, -1, '2017-12-10 11:00:00'),
(63, 2, 'Ip telefonia', '2017-12-11 11:34:19', 12, 'Purchasing Ip', '<p>Quotation Cost 10.000 USD</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p>IP-connections</p>\r\n\r\n<p>Ip-telelophonia</p>\r\n\r\n<p>IP-storages</p>\r\n', 41, 1, '2018-02-05 11:30:00'),
(64, 55, 'Полиграфические услуги', '2017-12-22 05:43:41', 15, 'Печать и полиграфия', '<p>Необходимы следующая продукция:</p>\r\n\r\n<p>Ролапы: до 10 шт.</p>\r\n\r\n<p>Флаеры 1000&nbsp;шт.</p>\r\n\r\n<p>Буклеты 1000&nbsp;шт.</p>\r\n\r\n<p>Визитки - возобновляемо</p>\r\n\r\n<p>Предложения будут рассматриваться по критериям цена/качество.</p>\r\n', 44, 1, '2018-01-31 14:00:00'),
(65, 65, 'Мебель', '2017-12-22 05:55:49', 18, 'Приобретение мебели для Аппартотеля', '<p>Мебель для аппартотеля:</p>\r\n\r\n<p>Необходимое количество и разновидности мебели</p>\r\n\r\n<p>Кровать кингсайз: 20 шт. размеры 1.8Х2м.</p>\r\n\r\n<p>Кровать синглсайз: 20 шт. 1Х2м.</p>\r\n\r\n<p>Кресла: 40 шт.</p>\r\n\r\n<p>Стулья: 40 шт.</p>\r\n\r\n<p>Диван: 10 шт. длина 1.2м.</p>\r\n\r\n<p>Шкафы: 20 шт. 1.5Х1.8м</p>\r\n\r\n<p>Шкафы: 20 шт. 1Х1.8м.</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, 1, '2018-01-31 14:00:00'),
(66, 65, 'Телевизоры для отеля', '2017-12-22 05:59:52', 6, 'Приобретение телевизоров', '<p>Необходимые параметры телевизоров</p>\r\n\r\n<p>1)&nbsp;размеры 32 дюйма&nbsp;</p>\r\n\r\n<p>2) количество 30 шт.</p>\r\n\r\n<p>3) цвет - черный</p>\r\n\r\n<p>4) формат - LCD</p>\r\n\r\n<p>5) производство - любое</p>\r\n\r\n<p>6) гарантия - миниму 1 год</p>\r\n\r\n<p>7) требования - соотношение цена/качество</p>\r\n\r\n<p>&nbsp;</p>\r\n', 48, 1, '2018-01-31 05:56:00');

-- --------------------------------------------------------

--
-- Структура таблицы `userGroups`
--

CREATE TABLE `userGroups` (
  `userGroupId` int(11) UNSIGNED NOT NULL,
  `name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `userGroups`
--

INSERT INTO `userGroups` (`userGroupId`, `name`) VALUES
(1, 'Administrators'),
(2, 'Buyers');

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `userId` int(10) UNSIGNED NOT NULL,
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

INSERT INTO `users` (`userId`, `login`, `password`, `createdAt`, `groupId`, `name`, `voen`, `country`, `city`, `address`, `phone`, `email`, `site`, `facebook`, `description`, `status`, `activationCode`, `fullAccessTo`, `stars`) VALUES
(1, 'admin', '$2y$10$WShDEA5s.Em0VNZYVpPaKeVTLtYMc2d7KHdchvWRLFhB5LYRmhUmW', '2017-07-28 08:02:27', 1, 'Admin', 0, NULL, 0, '', '', 'k.kaluzhnikov@gmail.com', '', '', '', 1, 'eeef80f7660b283a3b799938a84416cc', NULL, 0),
(2, 'test-b', '$2y$10$6Ic.8Twc9D0lrd6E88DAQezbUqZHGj59qjn8gGwuCm9MGWhZpvcUu', '2017-08-04 06:41:42', 2, 'Test Buyer', 1234567898, 'AZ', 1, 'ZA', '0555555555', 'zeuz@list.ru', '', '', 'Test', 1, '3f6b8a99b77a42b247003aa4e2563b23', NULL, 5),
(3, 'test-s', '$2y$10$t1O0Er5Sln7xIyfrjLYByuJJzBtueP0rj.bKpz/.3zEBNQ/nW5upi', '2017-08-04 06:43:36', 3, 'Test suplier', 1212121212, 'AZ', 1, 'ZD', '0552222222', 'evilkraft@gmail.com', '', '', 'Test and test', 1, '2ef8e52d8794260dccf2eb3c40a042ef', NULL, 4),
(4, 'test-s2', '$2y$10$vsB9/tuFvDTmwoaQTTVHeuSAk8uygoVER4Q1CniV.nM2IGs0Sxze2', '2017-08-09 11:30:22', 3, 'Test suplier 2', 3434343434, 'AZ', 2, 'test', '0552222222', 'zeuz1@list.ru', '', '', 'test test test', 1, '3f6b8a99b77a42b247003aa4e2563b23', NULL, 0),
(21, 'Guest', '$2y$10$rtZe3fZNTI7E2JKez0tJoO77dHtmaUy8qCMitTE2eGscVvxQOieEa', '2017-08-22 06:11:24', 2, 'Best Solutions', 1700322123, 'AZ', 1, 'S.Badalbeyli', '0502884460', 'r.c.rustam@icloud.com', '', '', '', 1, '5829fa1e492fe8863f558d8e9a25ca0e', '2017-08-24', 4),
(24, 'innovation', '$2y$10$UavGg5wLhL2ZA36fuFREjOQnt8yUF8RAZv5W/BIh8Qhnjup4mXMkC', '2017-08-22 08:22:42', 2, 'k&A', 1235438761, 'AZ', 1, 'hasan aliyev 35', '0124445555', 'k.agasi@gmail.com', '', '', '', 1, '91e343c820489d4ffa63cebcfa2dc44a', '2017-08-24', 0),
(43, 'zaur', '$2y$10$Va0Yz8kpYDS75KNCacrqDemWXLksPYors6Wx589ju.Xj358lKlkGq', '2017-08-28 08:58:50', 2, '3Z MMC', 1700170000, 'AZ', 1, 'A.Aliyev 1', '0502636700', 'zeynalov.zaur@gmail.com', 'http://1415.az', '', '', 1, 'ba20d010dab1a2b1cd477ae670366934', '2017-08-30', 0),
(55, 'innexim', '$2y$10$.VIOGrHTue92Qz1zCg7mju15VJhCaznTFuLiYyE3bRvICQosGc7uG', '2017-10-24 11:44:09', 2, 'INNEXIM', 0, 'CA', 0, '-', '0502186173', 'r.c.rustam@gmail.com', 'http://innexim.com', '', '', 1, 'c9fc98c061b0abd5304c2c3d192416ed', NULL, 5),
(56, 'Farid', '$2y$10$NjWg45B25rZIZ1JxRLV2Y.oANYGUUyvhcGT5jvIhJSAS/ZYZ9hQ/q', '2017-10-25 07:07:50', 2, 'Original Motors', 1701299101, 'AZ', 1, 'Aliyar Aliyev 52A', '0502780210', 'rustamof@hotmail.com', 'http://originalmotors.com', '', '', 1, '83d95a5965ad83b3201cf06d892633fc', NULL, 0),
(57, 'gunay', '$2y$10$TV9w8oFyoaL9yIy0Pfb50ewmHYDti00G8e5ZN0bhddNk968CHwsXK', '2017-10-25 08:01:23', 2, 'Netant', 1239876540, 'AZ', 1, 'gfjgjtdm', '4969696', 'gunayhuseyn@gmail.com', '', '', '', 1, '75cd10ebbdb74046329e61bb64e862db', NULL, 0),
(58, 'rustam-saf', '$2y$10$94wh18bKb23Y.c6r032jf.qjA4/xOB4CE1F2w7uY93wrckRmAsCeS', '2017-10-25 08:56:10', 2, 'Saf pencere', 1111111111, 'AZ', 1, 'Nobel Prospekti', '0124092835', 'office@saf-pencere.az', 'http://www.saf-pencere.az', 'https://www.facebook.com/saf.pencere/', '', 1, 'f25d8851517d80059bed61c91cb2c9c8', NULL, 0),
(64, 'Pooltech', '$2y$10$i2ffpLVOZT4qTQHnuEYQyexnHf.b2UvEZvHwLKozvgej5fK38d1.u', '2017-10-25 16:09:18', 3, 'Pooltech MMC', 1201778181, 'AZ', 1, 'Nərimanov rayonu, Hacı Murad 1', '+994552049422', 'taleh@pooltech.az', 'http://www.pooltech.az', '', '', 1, '4c596a0d8c4fb752b40a6bb688b62778', NULL, 0),
(65, 'Fashion', '$2y$10$XJdTeKm3YtmJKCL5MnA0N.XS3wjD1tnD37f1Ql/A1Oy.EvKVlrHi.', '2017-10-27 18:53:31', 2, 'IDBI', 1111111111, 'AZ', 1, 'Centralnaya', '0071895786996999', 'fashionarea@hotmail.com', '', '', '', 1, '691401df2a0e858b368ee0119dd6d39e', NULL, 5),
(66, 'Chase', '$2y$10$WXl04J7Hd1MlqrrEvGvgLu/KGvYwgydfkUBH66YliLIFMPD1Fmd6u', '2017-10-30 01:57:27', 2, 'site signs', 0, 'CA', 0, '', 'LR', 'chaseoshaughnessy@gmail.com', 'http://www.signsavers.co.uk/', '', 'We are a group of volunteers and opening a brand new scheme in our community.\r\nYour web site provided us with useful information to work on. You\'ve \r\nperformed a formidable job and our entire community will likely be thankful to you.', 0, '5e37afb0d1949d8546743662ec66efb5', NULL, 0),
(67, 'Christopher', '$2y$10$MAkGOR3VT95DKhXy6K5e4.H6.n87sN3ieWrryVDEW1BQvgFrfb.DS', '2017-10-30 01:58:22', 2, 'safety signs', 0, 'CA', 0, '', '0388 2177223', 'christopheraspinall@arcor.de', 'http://www.signsavers.co.uk/', '', 'Just want to say your article is as amazing. The clearness in your publish is simply cool and i could suppose you\'re a professional on this subject.\r\nWell along with your permission allow me to grab your feed to keep updated with coming near near post.\r\n\r\nThanks 1,000,000 and please continue the gratifying work.', 0, '4b9fcd11f8b26c3006e671ba38557e0e', NULL, 0),
(70, 'innexim1', '$2y$10$Ya8F/Gy3Y2YA1ARYGnf3EeNDRRx7sbU4LWCO9YsT5sQNOpmsS7Fr.', '2017-10-30 14:18:16', 3, 'INNEXIM', 0, 'CA', 0, 'SDAF', '09230120100', 'rustam.rustamov@pmdgroup.az', '', '', '', 1, 'fd44db8237425423b7a4e5d6db3a21a1', NULL, 0),
(71, 'bagirzade', '$2y$10$w5Af4Spsk9yL/f6XLE4jseb1DzYAjgJB0L4CtNaoSa3/EH.YDgDtC', '2017-10-31 07:44:43', 3, 'Totoo', 1004662452, NULL, 1, 'Bakı ş., Yasamal rayonu, Yeni Yasamal qəsəbəsi, Məhəmməd Xiyabani küçəsi bina 10c', '+994503220104', 'bagirzade@gmail.com', 'http://www.totoo.az', 'http://www.facebook.com/totoobebe', 'Uşaq geyimləri istehsalı', 1, 'd35058d276c08286cfd5ab3f5dc0c022', NULL, 0),
(72, 'ASBC', '$2y$10$1quMzyz4dm.SD5q1V/5x9OvDMeAfriAB8oQVgpZYwelEsoiCis29e', '2017-10-31 08:25:05', 3, 'ASBC', 1403779711, NULL, 1, 'Bakı ş, Nəsimi rayonu, R.Behbudov ev. 18 m. 9', '+994124932888', 'e.k@asbc.az', 'http://www.almastore.az', '', '', 1, '9d527e0da89baf4a3a17d6f39f936c21', NULL, 0),
(74, 'printi', '$2y$10$u2WtkTniGos0KWH9lHaQduhk6YN9Qq8HxwKqO51VENB2SgAywjnJS', '2017-10-31 09:00:00', 2, 'Printi Studio MMC', 2003409561, 'AZ', 1, 'Babək pr. 72/58', '0553393234', 'elina@printi.az', '', '', '', 1, '1fbde010f1c3c0b014a1a7b76561dada', NULL, 0),
(76, 'Khasayev', '$2y$10$5L6Y9tVH6VwScHdQIQtVbeGbs53PHVuZbIO.tTvrszqh5.9CF6.x2', '2017-10-31 09:10:52', 2, 'Frazex', 1403064411, 'AZ', 1, 'Inshaatchilar ave. 20A', '+994502557044', 'info@frazex.com', 'http://frazex.com', '', '', 1, '2acdce6bbea59d55d27e5cbc46974ef5', NULL, 0),
(77, 'kvazar.office@bk.ru', '$2y$10$sWkdZcN3rq9l3RJO4HAJpOYW8HVvNcgxLFsHWmKVbbxmaVXEyH9qW', '2017-10-31 09:34:43', 3, 'kvazar', 1700342951, 'AZ', 1, 'maksud-ali-zade18m40', '+994502204032', 'kvazar.office@bk.ru', '', '', 'калибровка резервуаров', 1, '8ca540fe1eb290051ee281e215964e5a', NULL, 0),
(78, 'bmlawaz', '$2y$10$4.MySv5HHtRv5t/io.qIIeijuwJmKXW/K4dSNPaDouAkxGCtfTZTW', '2017-10-31 10:02:19', 2, 'BM Morrison Partners LLC', 1300010161, 'AZ', 1, '43 Mammad Araz st., English Yard b.c., Villa 9', '012 4971914/15', 'info@bmlawaz.com', 'http://www.bmlawaz.com/', '', 'BM Morrison Partners (BM) is the first private law firm established in the independent Azerbaijan. Today, we combine best examples of legal knowledge, expertise, and professional experience', 1, '006c774dbea5671f00204690fde1096b', NULL, 0),
(79, 'izotar', '$2y$10$6uCh5k8dV/2bzSqC6hDTg.fsTcd6vsUS9B9W0B9gVJVlRzByJdjdO', '2017-10-31 10:17:44', 3, '\"AZTOL-ALAT\" MMC', 2003359301, 'AZ', 1, 'AZ1025, A.Cəlilov küç., 20/86', '+994124890146; +994502125378', 'f.alishanov@gmail.com', 'https://www.izotar.az', 'https://www.facebook.com/Izotar/', 'Müasir hidroizolyasiya materialları (rulon tipli dam ortüklər- ruberoidlər və bitum mastikası)\r\nГидроизоляционные материалы- рубероиды и битумная мастика', 1, '41c8ec0a9bf29cfef984404e811785e9', NULL, 0),
(80, 'organic', '$2y$10$BUH6n0O0tx7IhLxn.YCr0Oz1Lj6G9xr.4K4M6MjDcpniRGoRnID6m', '2017-10-31 10:23:16', 2, 'Organic Communications MMC', 1701422611, 'AZ', 1, '8, Gurbanov Xalilov st., ', '+994 12 4971781; 4971782; 4971783', 'office@organic.az', '', '', 'Reklam ve marketing xidmetleri', 0, 'dbe18ad993cdd087ced5d41e5dd94e08', NULL, 0),
(83, 'Fibromet', '$2y$10$7okQZgq.kULs70yolo43Z.6ignivYqp0kIang8Rul2lkkPNBXt/uq', '2017-10-31 10:59:29', 2, 'Fibromet MMC', 1701089361, 'AZ', 1, 'Biladjari , 16', '+994502145736', 'elcin@fibromet.az', 'https://www.fibromet.az', 'https://www.facebook.com/Fibromet-156172524473002/', 'Yük avtomobillərinə kuzov və soyuducu quraşdırılması', 1, '3deaac4b98ce2b1b34bc2b9e1f0af164', NULL, 0),
(84, 'tatiw', '$2y$10$tSBs7d6HRnq2j.2vukOp/eawz6b/rte4y7B87nkdTPdOwxCfe07ca', '2017-10-31 11:33:51', 2, 'TaZak', 1702136252, 'AZ', 5, 'Baş-Şabalıd kəndi', '+994505033005', 'tarlanzakaryayev@gmail.com', '', '', '', 1, '6f5de001126a585db39614a9d05eb728', NULL, 0),
(85, 'Office_Nawinia', '$2y$10$HKojmSDLkGKXeI45vsXRx.98YnhbIJLJ.HZtVBYo13fZ1Qbukcdqq', '2017-10-31 11:59:03', 3, 'NAWINIA BAKU MMC', 1401607211, 'AZ', 1, 'AZ 1025  Baki, 55 Khojali, AGA centre', '+994124644046', 'oletov@nawinia.com', 'http://www.nawinia.com', '', 'Логистическая семья NAWINIA в Баку оказывает все виды логистических услуг, включающих: импортное/экспортное/временное/транзитное таможенное оформление авто/авиа/жд/мультимодальных грузов; оказывает экспедиторские услуги по любым направлениям, видам транспорта и габаритам груза; оказывает услуги по Внешней Экономической Деятельности с территорий Европы, России, Турции и Китая. \r\nNAWINIA Baku входит в группу компаний Nawinia с офисами по всему миру и штаб-квартирой в Москве.', 1, '436d8c2be663d2cd3f44a69ed017a327', NULL, 0),
(86, 'JetBaku', '$2y$10$wusDwCcwJFr/opmoRmfmLOdeKsvK0za/Rz1J2ZDgo.OmSSeRFuFs.', '2017-10-31 12:06:37', 3, '«Jet İnformasiya Sistemləri» ММC', 1401388061, 'AZ', 1, 'АZ 1014 Bakı ş., S.Vurgun küç., 34, office 7', '+994125964362', 'ryabchenko@jet.msk.su', 'http://www.jetinfosys.az', '', '«Jet İnformasiya Sistemləri» şirkəti informasiya texnologiyaları (İT) bazarında 2008-ci ildən Azərbaycanda  fəaliyyət göstərir. Bizim fəaliyyətimiz, kommersiya təşkilatlarının və dövlət qurumlarının inkişafının güvənli əsasını təmin etmək, onların fəaliyyətinin effektivliyinin artırılmasına yönəldilmişdir.', 1, '19312e1c54ce53d290385deca9261630', NULL, 0),
(91, 'vusal@smartit.az', '$2y$10$t0Sf85zUzCxlQ6YsVRg/wOcRj0XwJbVJ.jfOt1mALbFURqyG6jEqW', '2017-10-31 19:21:47', 3, 'Smart IT MMC', 2003634151, 'AZ', 1, 'Nəsib bəy Yusifbəyli küçəsi 88', '+994123103335, 204', 'vusal@smartit.az', '', '', '', 1, 'efac3b4c80ec835417af01464b60b2fc', NULL, 0),
(92, 'nano2017', '$2y$10$nNjONQzrVwoj4kZBqyjtUeXXkTYoBEpEESuEF7W3A8bc/.GN8V/2S', '2017-11-01 09:13:16', 2, 'Nano2017', 1701201581, 'AZ', 1, 'Huseyn Cavid pr. 14', '012-495-57-21', 'nano2017@gmail.com', '', '', '', 0, 'f237ce69e0cf4333bebbe2f2a7bec5b2', NULL, 0),
(95, 'Jamila', '$2y$10$NRM9vdeSMcOZ68XiwQVOT.58YyXLuyAswmooNC4oxGRaoYqRuBI4a', '2017-11-01 19:33:42', 3, 'SINAM', 1786543457, 'AZ', 1, '9, B.Vakhabzade', '+994125101100', 'jamila.aliyeva@yahoo.com', 'https://sinam.net', '', '', 1, '70da8192fd6766d84039ed365ebc6b9e', NULL, 0),
(97, 'valid', '$2y$10$7Vnpn/.JX9aqR4.CAE4eCuOpchVHTGwtdRyXh21mHUDDlZCj8hEhe', '2017-11-02 07:56:52', 3, ' Sumqayıt Texnologiyalar Parkı', 2002283071, 'AZ', 3, 'H.Zeynalabdin Tağıyev qəsəbəsi', '+994502465699', 'vmammadli@stp.az', 'https:www.stp.az', 'https://www.facebook.com/www.stp.az/', 'Sumqayıt Texnologiyalar Parkı Qafqzın ən böyük sənaye müəssisə olmaqla yanaşı, müasir texnologiya avadanlıqların köməyi ilə ən müxtəlif məhsul və xidmətlərin təchizatını təmin edir. Müəssisəmiz polimer və kabel məhsulları, ən müxtəlif elektrik avadanlıqları, havalandırma sistemləri, sendviç panellər, profinastil, alüminium profillər, PVC qapı pəncərələr, ağırmaşınqayırma, metal-konstruksiyalar, sinkləmə və s məhsul və xidmətlər təklif edir. Bütün məhsullarımız yüksək standartlara cavab verir və müvafaiq sertifikatlarla təmin edilir. Əlavə suallar və təkliflər üçün, 050 246 56 99 nömrəsi ilə əlaqə saxlamağınız xahiş olunur. ', 1, '86a6451e4d5abde5e9d5b35b2a53b444', NULL, 0),
(104, 'Meridian', '$2y$10$m0PUTU0fhkuQI0kKtpNeeusl8stl3cbL/xl1Gead6i.0oLrG2Ry9u', '2017-11-03 06:41:09', 3, 'Meridian HIFI', 2002225771, 'AZ', 1, 'Abdulrahman bey Haqverdiev st. Residential quarter 574, building 5 AZ1138 Baku Azerbaijan Republic', '+994502042446', 'farid@meridianhifi.az', '', '', 'Мы предоставляем услуги по проектированию и  поставкам всех видов наружного и внутреннего освещения от европейских производителей по приемлемым ценам. Также нашими инженерами предоставляется решение по таким дисциплинам, как HVAC, Electrical Installation, Low Voltage& High Voltage Solutions.', 1, 'fe881cab92a93ab381291e861978d0bb', NULL, 0),
(112, 'sharipov', '$2y$10$jR3YwgZaY7xt5a2YPNm25OIPiIeK.cIlMtBpR6/VGviB9hU5aKUU.', '2017-11-03 13:05:32', 2, 'mytender.az1', 555555551, 'AZ', 1, 'Nobel Prospekti eede', '0124092838', 'sharipov.rustam@gmail.com', '', '', '', 1, '30c13711ee532afab0cf7eec209f88ad', NULL, 0),
(115, 'azersis', '$2y$10$J6/RNxG5u9oRjJQjixI41.a2MT5dEymFam8zhcg7qoWW2yuae3cr6', '2017-11-04 11:26:58', 3, 'AZERSIS', 1902437271, 'AZ', 1, '28 Мая 71', '+99505824930', 'azersis@mail.ru', '', '', '', 1, 'c50ca4d7835e45845d77f874f134d692', NULL, 0),
(116, 'azeridizayn', '$2y$10$KQERlMDLb6NnfXwes1LcxeRzWQM4aflfxS4UODjzHGCRrAoPlOGta', '2017-11-05 06:06:37', 3, 'Azeri-Dizayn firmasi', 1000058971, 'AZ', 1, 'Nizami küç.196', '+994125110587, +994124928722, +994552200981', 'info@azeri-design.az', '', '', '', 1, 'ca0bfe7e52afddc89b41d613ce5a83e6', NULL, 0),
(117, 'foresight', '$2y$10$Q/eEUi/aSbYt5s6nevwkpeADH0w0FJKuwzs4/vBFtzckF66dCEciS', '2017-11-05 07:20:32', 3, 'FORESIGHT', 2900515731, 'AZ', 3, '1-ci mkr, 45A/19, 48', '(+99450) 3343689', 'foresight.adil@gmail.com', '', '', 'Logistika və konsaltinq xidmətləri', 1, '95aace9655bb88d32f432bd9103805b9', NULL, 0),
(118, 'office@sadoil.com', '$2y$10$VcqosXR0oysqRaIBZIJC/euCZf/Qi8jZLCE3niOtlMogFTHboL6n.', '2017-11-06 05:40:58', 3, 'SADOIL MMC', 1201064361, 'AZ', 1, 'Dalga Plaza, 24 Neftchilar avenue.', '+994124375300', 'office@sadoil.com', 'https://www.sadoil.com', '', 'Sadoil LLC is privately held company in Azerbaijan. As a consultancy, supply and services providing enterprise we work with energy partners, investors, contractors, proactively assessing their needs, portfolios, investment strategies and develop business synergies where our resources and skills enable them both meet demands and maximize value.\r\n\r\nWith years of experience in connecting international Oil & Gas Industry Suppliers with Local Demand we offer complete project consultancy, procurement, construction, and maintenance services all over Caspian, particularly in Turkmenistan and Azerbaijan.\r\n\r\nAs a part of our expansion we have established offices in Ashgabat, Beijing and Abu Dhabi to support our continued growth and sourcing requirement. Other than our aforementioned offices, we have formed strategic business partnerships with   manufacturers and supply houses in EU, China and UAE to broaden our geographical reach. Sadoil’s broad supply range of renowned manudacturers lets it offer the highest quality  equipement for Oil and Gas Upstream Industry.\r\n\r\nDirectors of Sadoil LLC are well-experienced professionals with leading edge expertise in Energy and associate sectors over 15 years. We strive to forge lasting relationships with our customers based on consistent performance. This we achieve by assuring utmost attention with best services, quality products, competitive pricing and prompt delivery.', 1, 'b04c7f71d44d470bd2419920624ea44e', NULL, 0),
(120, 'Vostok ', '$2y$10$trrodfRIwTTB8tQOpOc0humhNsrRk3WZeR2lBhD3jzaBnGR5E4Sre', '2017-11-06 08:18:18', 3, 'Vostok Service', 1401000981, 'AZ', 1, 'Ahmed Rajabli 1/53', '012 465 81 85', 'info@az.vostok.ru', 'https://az.vostok.ru/', 'https://www.facebook.com/vostokbaku/', 'ГРУППА КОМПАНИЙ «ВОСТОК-СЕРВИС» — КРУПНЕЙШИЙ В РОССИИ И ЕВРОПЕ РАЗРАБОТЧИК, ПРОИЗВОДИТЕЛЬ И ПОСТАВЩИК СПЕЦОДЕЖДЫ, СПЕЦОБУВИ И СРЕДСТВ ИНДИВИДУАЛЬНОЙ ЗАЩИТЫ (СИЗ). ОСНОВАНА В 1992 ГОДУ. ПО МНЕНИЮ ЭКСПЕРТОВ, ЗАНИМАЕМАЯ КОМПАНИЕЙ ДОЛЯ РОССИЙСКОГО РЫНКА СПЕЦОДЕЖДЫ И СИЗ — 28%.\r\nГК «Восток-Сервис» — международная компания, имеющая зарубежные активы в Чехии (компания Cerva Export Import a.s.), Словакии (Cerva Slovakia), Польше (Cerva Poland), Венгрии (компания Vektor Kft.), Италии (обувная компания Panda Sport srl.), Турция, Бельгии, Голландии, Дании, ЮАР, Финляндии. В 56 регионах России, Украине, Беларуси, Казахстане, Азербайджане работают более 120 филиалов компании. Розничная сеть «Восток-Сервис» в России и странах СНГ представлена 280 фирменными магазинами, расположенными в 170 городах с численностью населения 100 тыс. человек.\r\nМиссия компании\r\nПоставляя на предприятия современную качественную спецодежду, спецобувь и сиз, мы создаем в высшей степени безопасные и комфортные условия труда для работников любого предприятия, защищаем здоровье и жизнь человека от агрессивного воздействия неблагоприятных факторов производства и окружающей среды, сохраняем трудовой потенциал и здоровье нации.\r\nПроизводственная база и ассортиментный портфель\r\nСобственная производственная база ГК «Восток-Сервис» — 12 швейных и 4 обувные фабрики, расположенные в Липецкой, Рязанской, Брянской, Белгородской. Тверской, Тульской, Кемеровской областях России; Гомельской, Гродненской и Минской областях Беларуси, в г. Бари (Италия). Все фабрики оснащены современным оборудованием, позволяющим выпускать продукцию высокого качества. Ежегодные капиталовложения в модернизацию производственных мощностей составляют 150 млн. руб.\r\nГК «Восток-Сервис» поставляет как традиционные, так и специализированные средства охраны труда для предприятий различных отраслей промышленности: энергетической, нефтяной, газовой, угольной, химической и нефтехимической, черной и цветной металлургии, машиностроения и металлообработки, и др. Ассортимент поставляемых ГК «Восток-Сервис» товаров — 12000 наименований спецодежды, специальной обуви, СИЗ, инструмента, сопутствующих товаров.\r\nРазработкой новых моделей спецодежды, обуви и СИЗ занимается собственный Центр разработки и развития ассортимента новой продукции компании. Ежегодное обновление ассортимента (10 — 15%) происходит за счет производства новых, разработанных с применением инновационных материалов и технологий продуктов, а также рестайлинга известных на рынке и пользующихся популярностью моделей. Система менеджмента качества компании соответствует стандарту ГОСТ ISO 9001-2011.', 1, '4f086b127cbecdd3a9ca1d86aeb34511', NULL, 0),
(127, 'Infoplusservis', '$2y$10$FARn87dAawEuSdIwYyelseaeZeYubmTrc.SRof1NvSLsB49p.ho8a', '2017-11-08 07:19:34', 3, 'Infoplusservis MMC', 1403285831, 'AZ', 1, 'Nasimi r., Dilara Aliyeva str. 239/8, M19', '+994123102616', 'infoplyusservis@gmail.com', '', '', '', 1, '27393c143ea90d6a4a40819386a42643', NULL, 0),
(129, 'ss.qrup', '$2y$10$l4ZOo6P2bo0bMk10dUjhjenJheZyS3wd5CtlEzWSCWFbG99p0UMcu', '2017-11-10 07:26:57', 3, 'SS group', 1501801601, 'AZ', 1, 'Həsən Əliyev, 125', '0125647149', 'ss.qrup.125@gmail.com', '', '', 'Продажа, покупка и управление недвижимостью и другими активами. ', 1, 'a757efc4f385d188d54135fa67257df0', NULL, 0),
(130, 'info@factory-tents.az', '$2y$10$JbTKY4HVFvMvyQQmdwsWoefCs9mjO/4I6qdISyEKkhHGg7mMpAVx6', '2017-11-10 08:37:23', 2, 'Megapolis Group-Factory Tents', 1403810201, 'AZ', 1, 'Azərbaycan, Bakı, Nərimanov, 10Q Ələsgər Qayıbov, AZ1029, SDN Biznes Mərkəzi', '+994124044398', 'info@factory-tents.az', 'http://www.factory-tents.az', '', 'Karkas-tent qurğuları (tentlər, çadırlar) - sənaye və kənd təsərrüfatı müəssisələri, idman təşkilatları, mədəni və sosial təyinatlı müəssisələrin tələblərinə tam həcmdə cavab verən, tez təmir olunan, qənaətli qurğulardır. Tent çadırların quruluşu sərfəli olması, yığılışın sadəliyi, etibarlılığı və praktik olması ilə fərqlənir. İstehsalçıdan tent çadırı əldə etmək fikirinə gəlmisinizsə, sizi şirkətimizdə görməyə şadıq!\r\nŞirkətin ixtisası - bütün növ karkas-tent qurğularının layihələşdirilməsi, istehsalı, satışı, icarəsi və onlara aşağı qiymətlərlə keyfiyyətli qulluğun göstərilməsidir (Bakıda və Azərbaycanın digər regionlarında).', 1, 'bbf115e53ef27b29d39aab79a1eab6c5', NULL, 0),
(131, 'RaifaJalilova', '$2y$10$VVzfJw/LXWNx04oCAuhHGOPiEo.BLMpFPlcJuXAgdSV1wWqbRDC9.', '2017-11-13 10:20:37', 2, 'Baku Consulting Group', 1305116941, 'AZ', 1, 'Z.Khalilov 523, house 11A, flat 12', '+994 55 600 26 66', 'marinarenaldi@yandex.ru', '', '', '', 1, '8547c8c6117af58bff4f5604595b9a6c', NULL, 0),
(133, 'Dmitrakovich87', '$2y$10$W.ZkV3foQsSJ0TkHix9Psur.MR6cuLsf/DjVOgITcWGS.s/0TJrBu', '2017-11-15 11:10:12', 3, 'IPhone Dmitrakovich', 0, 'BY', 0, 'g.Vitebsk,st.Gagarina,d.224/57', '+375298561515', 'evgenijdmitrakovich@mail.ru', '', '', '', 0, '190723ee383cf9c9327697bf193c40b8', NULL, 0),
(134, 'www.evgenijdmitrakovich@mail.ru', '$2y$10$azpX5MoYIMz1icnlIg1ZW.Y2oLAseRUfJf2oYWJoCL5NkmX1CmPQW', '2017-11-15 13:46:59', 2, 'Ip Dmitrakovich', 0, 'BY', 0, 'g.Vitebsk,st.Gagarin,d224/57', '+375298561515', 'www.evgenijdmitrakovich@mail.ru', '', '', '', 0, '190723ee383cf9c9327697bf193c40b8', NULL, 0),
(137, 'VugarHydroserv', '$2y$10$sD9dNAi30BErSdNK95t4w.aJdcesIodCrUUCybB8np4AAq2OUvWey', '2017-11-23 05:18:07', 3, 'Hydroserv Caspian LTD', 1700095541, 'AZ', 1, '15th KM, Salyan Highway ', '+994 50 246 89 92', 'vugar.mirzayev@hydroserv.az', '', '', 'HYDROSERV GROUP – это широко известный и признанный лидер рынка в проектировании, разработке применений и решений для гидравлических систем для нефтегазовой промышленности , Hydroserv Group имеет хорошо структурированную, опытную инфраструктуру продаж и сервиса с новейшими оборудованиями и технологиями, с более 80 сотрудниками. Специализированные инженеры и технические специалисты обладают углубленными знаниями о продуктах и услугах компании, предоставляемыми нашим клиентам.\r\n \r\nРемонт и Испытание\r\n \r\nРемонт и тестирование насосов, моторов, цилиндров, аккумуляторов, клапанов и крупных запчастей нефтегазовых, морских и промышленных гидравлических систем.\r\n    \r\nПри проведении осмотра, функционального тестирования, тестирования эффективности и обеспечения отчетами тестирования на каждый отремонтированный гидравлический компонент, мы работаем напрямую с крупнейшими поставщиками по всему миру. \r\n \r\n \r\nУ нас имеется широкий ассортимент гидравлических и промышленных рукавов с размерами, начинающимися от ¼ до  6 дюймов в местных складах с изготовлением с учетом пожелания клиентов. Также на нашем складе имеются различные виды рукавных соединений, подходящие для наших рукавов.\r\n \r\n \r\nВосстановление гидравлического оборудования\r\nВ Hydroserv все восстановительные работы осуществляются по самым высоким стандартам в полностью оборудованных мастерских и испытательных станках высокого давления. Начиная от замены уплотнителя и до капитального ремонта, по завершению работ предоставляются  сертификаты по функциональному тесту и опрессовке. Мы поставляем насосы и клапана всех производителей. \r\n \r\n    \r\n \r\nБолее детальную информацию можете найти в вложении \r\nMore detail information available on attachments \r\n\r\n\r\nDear Customer\r\n\r\nI’d like get chance to present our company ability and looking forward for further partnership with you. \r\n\r\nWith ISO9001:2015certification from TUV we specialize in design, manufacturing, flushing & refurbishment of hydraulic power systems and associated motion control, handling systems and components in conformance with international quality and safety standards. \r\n\r\nAlso like to inform that Hydroserv Group expanded service & Supply capability on wide range construction machinery\r\nWe are dealers of the world leading manufacturers of machinery, such as JCB, HYSTER, JLG, Magni, Combilift  in Azerbaijan. We also operate big fleet of rental equipment, consisting of the following machinery: \r\n\r\n1.            Traditional forklift trucks: 1.5-25Te capacity; \r\n2.            Telehandlers: 7-30MTR boom;\r\n3.            MEWP – 8-50 MTR boom; \r\n4.            Generators / Lighting Towers;\r\n5.            Other small plant equipment; \r\n \r\nI’m attaching our brochure for more information about our capabilities. \r\nLooking forward to get chance for further meeting and more detail presentation\r\n\r\nBest Regards\r\n \r\n \r\nVugar Mirzayev\r\nSales engineer \r\nHydroserv Caspian LTD\r\n15th KM, Salyan Highway | Baku|AZ1063 | Azerbaijan\r\nMob: +994 50 246 89 92\r\nTel: +994 12 448 2872 / 74\r\nFax: +994 12 448 2871\r\nWebsite: www.hydroservgroup.com  \r\n', 1, '41e5bcce49bc3fe097475cb494b2011e', NULL, 0),
(138, 'tural', '$2y$10$33/wWcbN1y6hoCLrlbfbxONQdrayPup8yvWJxcmyv4Tip4w8H.tka', '2017-11-27 12:22:20', 2, 'Gobay', 4294967295, 'AZ', 1, 'Mireli seidov 19 A', '+994503515149', 'tural@gobay.az', '', '', '', 1, 'a2c62c8b90f12f04d89928a30b383f96', NULL, 0),
(139, 'ces1999', '$2y$10$fHnYJBuqwtss0yJN55KEeOeTEa7E3Eja3lqqMTCJsOd/GSYtQdb5K', '2017-11-28 10:43:10', 2, 'Qafqazenergoservis', 3100019251, 'AZ', 1, 'Nesimi rayonu, S.Vurğun 34 küçəsi, AF Mall binası 4-cü mərtəbə', '+994 12 498 67 71', 'baku@ces-az.com', 'http://ces-az.com', '', '         «Qafqazenergoservis» - öz fəaliyyətini sənaye istesalatı sahəsində həyata keçirilən Azərbaycan Respublikasında mövcud olan özəl şirkətdir. Şirkətin istehsalat fəaliyyət sahəsini müxtəlif tipli elektrik avadanlıqlarının təmiri, sazlanması təşkil edir. \r\n         Respublika daxilində və onun hüdudlarından kənarda qarşıya qoyulmuş tapşırıqların yerinə yetirilməsi üçün «Qafqazenergoservis» şirkətinin yüksək ixtisaslı mütəxəssislərindən ibarət mobil briqadaları vardır.\r\n         Bir çox mürəkkəb hallarda elektrik avadanlıqlarının təmiri «Qafqazenergoservis»  şirkətinə məxsus olan və Bakı şəhərində, Dağıstan, Gürcüstan Respublikasında yerləşən bazalar əsasında həyata keçirilir.\r\n         «Qafqazenergoservis» şirkəti beynalxalq layihələrin işlənməsi cəlb edilmişdir. «Qafqazenergoservis»  şirkətinin aktivinə «WIER PUMPS LTD», «FIELD SYSTEMS DESIGN LTD» (Böyük Britaniya) «TECHFINA SA», «STUCKY CE» (İsveçrə), «MKT» (Türkiyə) şirkətləri ilə birgə işlər də aiddir.\r\n          Şirkətin yeni istiqamətini həmçinin onun tərəfindən metallurgiya sahəsinin uğurla mənimsənilməsi təşkil edir. Hal-hazırda bir DSP elektrik sobasında hazırlanan kvadrat pəstahlardan «Yayma dəzgah 400» -də müxtəlif növlü metal-yayma məhsullarının istehsal edirik. Metal ərintilərindən həmçinin müxtəlif çeşidli metal tökmə məhsullarını istehsal edirik. \r\n', 1, 'e95da7af0b06c503956370dbfd459e52', NULL, 0),
(140, 'sinam ', '$2y$10$O.01U884Hlo2fF2q7DDRcO4UQ3rpwvNZMyjD/.J5Tb.BEPnkDIHje', '2017-11-30 06:07:21', 2, 'SINAM  ', 1010010001, 'AZ', 1, '9, B.Vakhabzadeh ', '+994125101100 ', 'elchin.aliyev@sinam.net', 'https://sinam.net ', '', 'IT System Integration', 0, 'e2e22dc2ba03dbad2d1567e854840a76', NULL, 0),
(141, 'smartagro', '$2y$10$RY5UB8QvGXMUhZlggvw7zuZmgiV9vrNOEpVCmEKblA3Bo6NmT1k.G', '2017-12-14 07:23:37', 3, 'Smart Agro MMC', 1503755281, 'AZ', 1, 'Əhməd Rəcəbli küç., 222, Royal Plaza, 5-ci mərtəbə', '+994125648683', 'kamal.abdulrahimov@smartagro.az', 'http://smartagro.az', '', '•	Suvarma sistemləri:\r\n        -  Genişəhatəli çiləmə maşınları \r\n        -  Damla suvarma sistemləri\r\n        -  Sprinkler suvarma sistemləri\r\n•	Sənaye istixana kompleksləri\r\n•	Nasos və süzgəcləmə stansiyaları\r\n•	Suvarma sistemləri üçün su anbarları \r\n•	Suvarma sistemləri və istixana kompleksləri üçün avtomatlaşdırma sistemləri\r\n•	Yarımavtomat və avtonom enerji sistemləri \r\n•	Təhlükəsizlik və rabitə sistemləri\r\n•	Boyük suvarma sahələri və istixana təsərrüfatları üçün monitorinq sistemləri\r\n', 1, '77158cbfa0b6805c0ae62d4b7140e9b4', NULL, 0),
(142, 'shekitour', '$2y$10$XoHqlwYSagscLFaUpB8cV.U6IOm/Bt4VSc25bUrxT7xh/GI2i7uuC', '2017-12-18 18:40:10', 3, 'sheki tour', 1234567890, 'AZ', 5, 'sheki ', '+994554060688', 'hamidlimurad@gmail.com', '', '', '', 1, '7b24c12a75db870a9d8d6ac02189292b', NULL, 0),
(143, 'Stampel', '$2y$10$NeUUwXp0g9KNxiORh/hB0uHuzd2yNx79Lq82pdJ01vLD2V17MGzXG', '2017-12-23 15:32:51', 3, 'STAMPEL', 1603047291, 'AZ', 1, 'Nizami Rayonu Cəmşid Naxçıvanski 18 mənzil 14', '+994502015253', 'info@stampel.az', 'https://www.stampel.az/', 'https://m.facebook.com/stampel.az/?ref=bookmarks', 'Bütün növ möhür ştampların istehsalı və satışı.', 0, '17fb97950b8e253a7922f4c1249015b8', NULL, 0),
(144, 'Vitam', '$2y$10$Vvh2PN6X./6ouVJLangcDOoJZsR8QYWZM/vrpISQbn2CywnSu1mni', '2017-12-23 19:01:07', 3, 'Vitam Reklam', 1000096931, 'AZ', 1, 'F.Əliyev 2', '0124378060', 'tehran@vitam.az', 'http://vitam.az/', 'https://m.facebook.com/vitam.az', '- çöl və iç məkan adasqıların istehsalı\r\n- genişformatlı UV çap\r\n- vitrin istehsalı\r\n- reklam stendləri istehsalı\r\n- sərgi stendi istehsalı\r\n- yönləndirmə sistemləri\r\n- dizayn və layihələndirmə\r\n- texniki konsultasiya', 1, '61b549c48d7d2786874de6e4ddb3dff4', NULL, 0),
(145, 'intertechnics', '$2y$10$T441Hh5LbN2TOObv2B7l1uoJv7GrVbELCLbHFbdeqL16X57afAHeW', '2017-12-25 06:40:59', 3, 'Inter-Technics', 1800185631, 'AZ', 1, 'BAKU-QUBA Highway 12 A. KHIRDALAN ', '+99412 347 95 55', 'office@inter-technics.az', 'https://inter-technics.com ', '', '', 1, 'fdba2ea99e557925283c9c2d8f8c4190', NULL, 0),
(146, 'complectpromm', '$2y$10$TETZfpSZspnm8uV81/u7JOk7DroaGdBz0KnwoHAEZrm1aH3.cvDmK', '2017-12-26 13:30:02', 3, 'ООО \"КПМ\"', 0, 'RU', 0, '195279, г. Санкт-Петербург, шоссе Революции, д. 69, лит. А, пом. 22Н, оф. 310', '+79112693365', 'manager15@complectprom.ru', 'http://www.complectprom.ru/', '', ' ООО \"КПМ\" — один из ведущих российских производителей электротехнического оборудования. По наращиванию производства и темпам модернизации предприятие — одно из наиболее динамично развивающихся в отрасли. Сотрудничество ООО \"КПМ\" с ключевыми российскими предприятиями позволяет эффективно реализовывать правительственную программу импортозамещения.\r\nК числу важнейших направлений модернизации предприятия относится внедрение энергосберегающих технологий. Разработки специалистов ООО \"КПМ\" позволяют уже сейчас производить оборудование, способствующее снижению энергозатрат предприятий до 50%.\r\n\r\nООО \"КПМ\" располагает производственными площадками в г. Санкт-Петербург и выпускает следующую продукцию:\r\n\r\n- Cухие трансформаторы с полимерной воздушно-барьерной изоляцией мощностью до 6300кВА, напряжением до 35кВ;\r\n- Токоограничивающие реакторы на токи до 10000А, на классы напряжения до 330кВ, индуктивным сопротивлением до 3,3Ом;\r\n- Устройства энергосбережения и компенсации реактивной мощности;\r\n- Преобразовательные сухие трансформаторы для различных отраслей промышленности мощностью до 6300кВА, на классы напряжения до 35кВ;\r\n- Комплектные распределительные устройства КРУ на класс напряжения 6 (10)кВ;\r\n- Комплектные трансформаторные подстанции КТП промышленные на класс напряжения 6(10)кВ ;\r\n- Комплектные трансформаторные подстанции наружной установки КТПН в блочно-модульном здании БМЗ на класс напряжения 6(10), 35, 110, 220кВ;\r\n- Комплектные трансформаторные подстанции блочные КТПБ на класс напряжения 35, 110, 220кВ;', 1, '89e905c853248fd08e59cd69149f9945', NULL, 0),
(147, 'hellshan', '$2y$10$wHjYtUJQ9R5eKdC5cWD2E.HU0HzCyjtVb1Lg9/9VyGLFiRfVEb6Uu', '2018-01-05 06:22:25', 2, 'Test1', 1234567890, 'AZ', 1, 'Bakı şəhəri', '0505555555', 'elsan.hasanov@gmail.com', '', '', '', 1, 'd707862fed9a734112c9f960f629bf3a', NULL, 0);

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
(3, 55, 5),
(21, 45, 5),
(45, 21, 5),
(95, 65, 5);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `blog`
--
ALTER TABLE `blog`
  ADD PRIMARY KEY (`blogId`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `blogId` (`blogId`);

--
-- Индексы таблицы `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`cityId`);

--
-- Индексы таблицы `help`
--
ALTER TABLE `help`
  ADD PRIMARY KEY (`helpId`);

--
-- Индексы таблицы `help_lang`
--
ALTER TABLE `help_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `pageId` (`pageId`);

--
-- Индексы таблицы `industries`
--
ALTER TABLE `industries`
  ADD PRIMARY KEY (`industryId`);

--
-- Индексы таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `industryId` (`industryId`),
  ADD KEY `lang` (`lang`);

--
-- Индексы таблицы `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`pageId`),
  ADD UNIQUE KEY `alias` (`alias`);

--
-- Индексы таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `pageId` (`pageId`);

--
-- Индексы таблицы `postFiles`
--
ALTER TABLE `postFiles`
  ADD PRIMARY KEY (`fileId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `tenderId` (`tenderId`);

--
-- Индексы таблицы `postIndustries`
--
ALTER TABLE `postIndustries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_indust_idx` (`postId`,`industryId`);

--
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`postId`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `posts_lang`
--
ALTER TABLE `posts_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `blogId` (`postId`);

--
-- Индексы таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  ADD PRIMARY KEY (`fileId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `tenderId` (`tenderId`);

--
-- Индексы таблицы `tenders`
--
ALTER TABLE `tenders`
  ADD PRIMARY KEY (`tenderId`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `userGroups`
--
ALTER TABLE `userGroups`
  ADD PRIMARY KEY (`userGroupId`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userId`),
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
-- AUTO_INCREMENT для таблицы `blog`
--
ALTER TABLE `blog`
  MODIFY `blogId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `cities`
--
ALTER TABLE `cities`
  MODIFY `cityId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;
--
-- AUTO_INCREMENT для таблицы `help`
--
ALTER TABLE `help`
  MODIFY `helpId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT для таблицы `help_lang`
--
ALTER TABLE `help_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
--
-- AUTO_INCREMENT для таблицы `industries`
--
ALTER TABLE `industries`
  MODIFY `industryId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT для таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;
--
-- AUTO_INCREMENT для таблицы `pages`
--
ALTER TABLE `pages`
  MODIFY `pageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT для таблицы `postFiles`
--
ALTER TABLE `postFiles`
  MODIFY `fileId` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `postIndustries`
--
ALTER TABLE `postIndustries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `postId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `posts_lang`
--
ALTER TABLE `posts_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT для таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  MODIFY `fileId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT для таблицы `tenders`
--
ALTER TABLE `tenders`
  MODIFY `tenderId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=67;
--
-- AUTO_INCREMENT для таблицы `userGroups`
--
ALTER TABLE `userGroups`
  MODIFY `userGroupId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `blog`
--
ALTER TABLE `blog`
  ADD CONSTRAINT `blog_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `blog_lang`
--
ALTER TABLE `blog_lang`
  ADD CONSTRAINT `blog_lang_ibfk_1` FOREIGN KEY (`blogId`) REFERENCES `blog` (`blogId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `help_lang`
--
ALTER TABLE `help_lang`
  ADD CONSTRAINT `help_lang_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `help` (`helpId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `industries_lang`
--
ALTER TABLE `industries_lang`
  ADD CONSTRAINT `industries_lang_ibfk_1` FOREIGN KEY (`industryId`) REFERENCES `industries` (`industryId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  ADD CONSTRAINT `pages_lang_ibfk_1` FOREIGN KEY (`pageId`) REFERENCES `pages` (`pageId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenderFiles`
--
ALTER TABLE `tenderFiles`
  ADD CONSTRAINT `tenderfiles_ibfk_1` FOREIGN KEY (`tenderId`) REFERENCES `tenders` (`tenderId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tenderfiles_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tenders`
--
ALTER TABLE `tenders`
  ADD CONSTRAINT `tenders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`userId`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
