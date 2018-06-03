-- phpMyAdmin SQL Dump
-- version 4.8.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Июн 03 2018 г., 22:49
-- Версия сервера: 5.7.20
-- Версия PHP: 7.2.0

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
  `helpId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `help_lang`
--

INSERT INTO `help_lang` (`langId`, `helpId`, `lang`, `title`, `text`) VALUES
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
(1, 'contacts'),
(6, 'rules');

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
(16, 6, 'en', 'Terms of Use and Privacy Policy', '', '', '<p><strong>1. Basic provisions</strong>. Mytender.az (hereinafter - the platform) undertakes to keep your privacy on the Internet. This Privacy Policy is about the collection, procession and storage of your personal data. This platform attaches high priority to protecting the personal information of users. By using the platform, the user agrees to the application of the rules for the collection and use of the data set forth in this document.</p>\r\n\r\n<p><strong>2. Information</strong><strong>.</strong></p>\r\n\r\n<p><strong>2.1 Information collected. </strong>The platform collects the following data about the users of the site:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Full name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● E-mail address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Phone number</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company name</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Company address</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● Taxpayer ID</p>\r\n\r\n<p><strong>2.2&nbsp;Use of information</strong><strong>. </strong>Here are some ways to use the user&#39;s personal information:<strong> </strong></p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to provide information and services that the user requests;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● to respond to user requests.</p>\r\n\r\n<p><strong>2.3 Storage of information. </strong>The platform stores your personal information for the duration of the activity of your user account or for the time necessary to provide you with services. We can store personal information even after deactivating your user account and / or stopping the use of any specific services,&nbsp;to the extent necessary for the performance of our legal duties, for resolving disputes with users of the&nbsp;platform, preventing fraud and abuse, execution of our agreements and protection of our legitimate interests.</p>\r\n\r\n<p><strong>2.4 Information disclosure</strong><strong>. </strong>The platform does not transfer the user&#39;s personal data to third parties without the user&#39;s consent. The platform reserves the right to delete invalid accounts or accounts with forged names and registration data.</p>\r\n\r\n<p><strong>3. Advertising messages. </strong>By providing your email address or any other contact information (for example, your phone number or username on the social network), you agree to receive promotional messages, messages or calls from the platform staff. Accordingly, the platform employees have the right to call or send you mailings or messages via e-mail, SMS, personal text messages, make marketing calls or use similar&nbsp;forms communication. If you do not want to receive such advertisements or calls, you can notify the platform at any time, or follow the instructions on unsubscribing contained in the advertisements you received.</p>\r\n\r\n<p><strong>4. Security. </strong>The platform has adopted security measures designed to protect the personal information that you share with us, including physical, electronic and procedural measures. Among other things, the platform offers secure access to most of our services using the HTTPS protocol; transfer of confidential payment information (for example, a credit card number) through our specially designed forms that are protected by an encrypted connection of the industry standard SSL / TLS. The platform also regularly monitors the system for possible vulnerabilities and attacks, and is constantly looking for new solutions to improve the security of our services.</p>\r\n\r\n<p><strong>5. Terms of use</strong>.</p>\r\n\r\n<p><strong>5.1</strong> The platform asks users to avoid conflict situations and other violations, which can lead to undesirable consequences. In case this happens, the platform, having analyzed the situation, undertakes to act appropriately to prevent such actions henceforth.</p>\r\n\r\n<p><strong>5.2</strong> This Privacy policy, its interpretation, and any claims and disputes related to this instrument are regulated, interpreted and executed only and exclusively in accordance with the basic internal laws of the Republic of Azerbaijan. Hereby, you agree that any claims and disputes shall be resolved only by a competent court&nbsp;located in the Republic of Azerbaijan.</p>\r\n\r\n<p><strong>6. Deleting</strong><strong> </strong><strong>an</strong><strong> </strong><strong>account</strong><strong>. </strong>You can request the removal of your Personal Information from our blogs, communities or forums by contacting us&nbsp;at&nbsp;<a href=\"mailto:office@mytender.az?subject=email&amp;body=email\">office@mytender.az</a></p>\r\n'),
(17, 6, 'ru', 'Правила пользования и политика конфиденциальности.', '', '', '<p><strong>1. Основные положения. </strong>Mytender.az (далее &ndash; платформа) обязуется хранить Вашу конфиденциальность в сети Интернет.&nbsp;Настоящая Политика Конфиденциальности, рассказывает о том, как собираются, обрабатываются и хранятся Ваши личные данные. Данная платформа уделяет большое внимание защите личной информации пользователей.&nbsp;Пользуясь платформой, пользователь дает согласие на применение правил сбора и использования данных, изложенных в настоящем документе.&nbsp;</p>\r\n\r\n<p><strong>2. Информация.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;Собираемая информация. </strong>Платформа собирает следующую информацию о пользователях сайта:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Фамилия, Имя</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Адрес электронной почты</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Номер телефона</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Название компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Адрес компании</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Идентификационный номер налогоплательщика</p>\r\n\r\n<p><strong>2.2&nbsp;Использование информации. </strong>Ниже описаны некоторые способы использования личной информации пользователя:</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для предоставления информации и услуг, которые&nbsp;&nbsp;запрашивает пользователь;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● для ответа на запросы пользователя.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Хранение информации. </strong>Платформа хранит вашу персональную информацию в течение всего времени активности вашей пользовательской учётной записи либо в течение времени, необходимого для оказания вам услуг. Хранение персональной информации может осуществляться нами даже после деактивации вашей пользовательской учётной записи и/или прекращения использования каких-либо конкретных услуг, в той мере, какой это необходимо для исполнения наших юридических обязанностей, для урегулирования споров в отношении пользователей платформы, предотвращения мошенничества и злоупотреблений, исполнения наших соглашений и защиты наших законных интересов.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong><strong>Раскрытие информации</strong><strong>. </strong>Платформа не продает личные данные пользователя и не передает их третьим лицам без согласия на то пользователя. Платформа оставляет за собой право удалять недействительные учетные записи или учетные записи с поддельными названиями и регистрационными данными.</p>\r\n\r\n<p><strong>3.&nbsp;Рекламные сообщения. </strong>Предоставляя адрес вашей электронной почты или любую другую контактную информацию (например, ваш номер телефона или имя пользователя в социальной сети), вы соглашаетесь на получение рекламных рассылок, сообщений или звонков от сотрудников платформы. Соответственно, сотрудники платформы, вправе звонить или направлять вам рекламные рассылки или сообщения по электронной почте, SMS, личные текстовые сообщения, делать маркетинговые звонки или использовать аналогичные формы общения. Если вы не хотите получать такие рекламные сообщения или звонки, вы можете уведомить платформу в любое время, или выполнить инструкции по отказу от подписки, содержащиеся в рекламных сообщениях, которые вы получили.</p>\r\n\r\n<p><strong>4.&nbsp;Безопасность. </strong>Платформа приняла меры безопасности, предназначенные для защиты персональной информации, которой вы делитесь с нами, в том числе физические, электронные и процедурные меры. Среди прочего, платформа предлагает безопасный доступ к большинству ресурсов наших услуг по протоколу HTTPS; передачу конфиденциальной информации по оплате (например, номер кредитной карты) через наши специально разработанные формы, которые защищены шифрованным соединением отраслевого стандарта SSL/TLS. Платформа также регулярно отслеживает систему на предмет возможных уязвимых мест и атак, и постоянно ищем новые решения для повышения безопасности наших услуг.</p>\r\n\r\n<p><strong>5.&nbsp;Правила пользования.</strong></p>\r\n\r\n<p><strong>5.1 &nbsp;</strong>Платформа просит пользователей<strong> </strong>избегать конфликтные ситуации и другие нарушения, которые могут повлечь за собою нежелательные последствия. В случае если такое имеет место быть, платформа, проанализировав ситуацию обязуется предпринять надлежащие меры по недопущению подобных действий впредь.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Настоящая политика конфиденциальности, её толкование, и любые претензии и споры, связанные с настоящим документом, регулируются, трактуются и исполняются только и исключительно в соответствии с основными внутренними законами Азерабайджанской Республики. Настоящим, вы соглашаетесь, что любые претензии и споры подлежат разрешению исключительно компетентным судом, находящимся в Азербайджанской Республике.</p>\r\n\r\n<p><strong>6.&nbsp;Удаление учетной записи. </strong>Вы можете запросить удаление вашей Персональной информации из наших блогов, сообществ или форумов, обратившись к нам по адресу <a href=\"mailto:office@mytender.az\">office@mytender.az</a></p>\r\n'),
(18, 6, 'az', 'İstifadə qaydaları və məxfilik siyasəti.', '', '', '<p><strong>1. Əsas m&uuml;ddəalar.</strong><strong> </strong>Mytender.az (bundan sonra platforma adlandırılacaq) İnternet şəbəkəsində məxfiliyinizi qorumağı &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r. Hazırki Məxfilik Siyasəti Sizin şəxsi məlumatlarınızın toplanması, işlənməsi və saxlanılması barədə məlumatları ehtiva edir. Platformadan istifadə etməklə istifadə&ccedil;i hazırki sənəddə yer alan məlumatların toplanması və istifadəsi qaydalarının tətbiq edilməsinə razılığını bildirir.</p>\r\n\r\n<p><strong>2. Məlumat.</strong></p>\r\n\r\n<p><strong>2.1&nbsp;</strong><strong>Toplanılan məlumat</strong><strong>. </strong>Platforma sayt istifadə&ccedil;iləri haqqında aşağıdakı məlumatları toplayır:</p>\r\n\r\n<p>&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Adı, soyadı</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; ● Elektron po&ccedil;t &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Telefon n&ouml;mrəsini</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin adını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Şirkətin &uuml;nvanını</p>\r\n\r\n<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ● Vergi &ouml;dəyicisinin eyniləşdirmə n&ouml;mrəsini</p>\r\n\r\n<p><strong>2.2&nbsp;</strong><strong>Məlumatların istifadə edilməsi. </strong>Aşağıda istifadə&ccedil;inin şəxsi məlumatlarının bir ne&ccedil;ə istifadə yolları təsvir edilmişdir:<br />\r\n&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;● istifadə&ccedil;inin tələb etdiyi məlumatların və xidmətlərin təqdim edilməsi &uuml;&ccedil;&uuml;n;</p>\r\n\r\n<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ● istifadə&ccedil;inin m&uuml;raciətlərinə cavab vernək &uuml;&ccedil;&uuml;n.</p>\r\n\r\n<p><strong>2.3</strong>&nbsp;<strong>Məlumatların saxlanılması. </strong>Platforma sizin şəxsi məlumatlarınızı istifadə&ccedil;i hesabınızın aktiv olduğu m&uuml;ddətdə və ya xidmətlərin g&ouml;stərilməsi &uuml;&ccedil;&uuml;n zəruri olan vaxt ərzində saxlayır. Şəxsi məlumatların saxlanılması h&uuml;quqi &ouml;hdəliklərimizin yerinə yetirilməsinin, platforma istifadə&ccedil;ilərinin m&uuml;bahisələrinin tənzimlənməsinin, saxtakarlığın və sui-istifadənin qarşısının alınmasının, razılaşmalarımızın icrasının və qanuni mənafelərimizin qorunmasının zəruriliyi baxımından, hətta, sizin istifadə&ccedil;i hesabınızın ləğv edilməsindən və / və ya hər hansı x&uuml;susi xidmətlərin istifadəsinin dayandırılmasından sonra da həyata ke&ccedil;irilə bilər.</p>\r\n\r\n<p><strong>2.4&nbsp;</strong><strong>Məlumatların a&ccedil;ıqlanması. </strong>Platforma istifadə&ccedil;inin şəxsi məlumatlarını həmin istifadə&ccedil;inin razılığı olmadan &uuml;&ccedil;&uuml;nc&uuml; şəxslərə &ouml;t&uuml;rm&uuml;r. Platforma etibarsız hesabların və ya saxta adları və qeydiyyat məlumatlarını ehtiva edən hesabların silinməsi h&uuml;ququna malikdir.</p>\r\n\r\n<p><strong>3.&nbsp;Reklam xarakterli mesajlar. </strong>Elektron po&ccedil;t &uuml;nvanınızı və ya digər istənilən əlaqə məlumatınızı (məsələn, telefon n&ouml;mrəsini və ya sosial şəbəkədə istifadə&ccedil;i adını) təqdim etməklə, Siz platforma əməkdaşlarından reklam xarakterli paylaşmaların, mesajların və ya zənglərin qəbul edilməsinə razılığınızı bildirirsiniz. M&uuml;vafiq olaraq, platforma əməkdaşları elektron po&ccedil;tunuza reklam xarakterli paylaşmaları və ya mesajları, SMS, şəxsi mətn mesajlarını g&ouml;ndərmək, marektinq zəngləri etmək və ya analoji əlaqə formalarından istifadə etmək h&uuml;ququna malikdir. Bu c&uuml;r reklam xarakterli mesajları və ya zəngləri qəbul etmək istəmədiyiniz təqdirdə, istənilən vaxt platformaya bildiriş g&ouml;ndərə və ya aldığınız reklam xarakterli mesajlarda yer alan abunə&ccedil;ilikdən imtina təlimatına riayət edə bilərsiniz.</p>\r\n\r\n<p><strong>4.&nbsp;Təhl&uuml;kəsizlik. </strong>Platforma bizimlə paylaşdığınız şəxsi məlumatların fiziki, elektron və icra tədbirləri də olmaqla təhl&uuml;kəsizlik tədbirlərini həyata ke&ccedil;irəcəkdir. Bundan savayı, platforma HTTPS protokolu &uuml;zrə bir sıra xidmətlər resursuna təhl&uuml;kəsiz girişi, SSL / TLS sahə standartının şifrələnmiş birləşməsi ilə qorunan x&uuml;susi tərtib edilmiş formalar vasitəsilə &ouml;dəniş (məsələn, kredit kartının n&ouml;mrəsi) yolu ilə məxfi məlumatların &ouml;t&uuml;r&uuml;lməsini də təklif edir. Platforma, həm&ccedil;inin, m&uuml;təmadi olaraq m&uuml;mk&uuml;n &ccedil;atışmazlıqların və h&uuml;cumların baş verə biləcəyi &uuml;zrə sistemə nəzarət edir. Xidmətlərimizin təhl&uuml;kəsizliyinin artırılması &uuml;&ccedil;&uuml;n yeni həllər yolunu axtarırıq.</p>\r\n\r\n<p><strong>5.&nbsp;İstifadə qaydaları.</strong></p>\r\n\r\n<p><strong>5.1 </strong>Platforma istifadə&ccedil;ilərdən xoşagəlməz nəticələrə gətirib &ccedil;ıxara biləcək m&uuml;bahisəli halların və digər pozuntuların yaranmamasını tələb edir. Belə hallara yol verildiyi təqdirdə, platforma yaranmış vəziyyəti təhlil edərək gələcəkdə buna bənzər halların yol verilməməsi &uuml;zrə m&uuml;vafiq tədbirləri həyata ke&ccedil;irməyi &ouml;hdəsinə g&ouml;t&uuml;r&uuml;r.</p>\r\n\r\n<p><strong>5.2&nbsp;</strong>Hazırki məxfilik siyasəti, onun təfsiri və hazırki sənədlə əlaqədar istənilən iradlar və m&uuml;bahisələr yalnız və m&uuml;stəsna olaraq Azərbaycan Respublikasının əsas daxili qanunları ilə tənzimlənir, təfsir edilir və icra edilir. Bununla da, siz iradların və m&uuml;bahisələrin m&uuml;stəsna olaraq Azərbaycan Respublikasında yerləşən səlahiyyətli məhkəmələr tərəfindən həll edilməsinə razılığınızı bildirirsiniz.</p>\r\n\r\n<p><strong>6.&nbsp;Hesabın silinməsi. </strong>Siz <a href=\"mailto:office@mytender.az\">office@mytender.az</a>&nbsp;elektron &uuml;nvan&nbsp;&uuml;zrə m&uuml;raciət etməklə bloqlarımızdan, toplumlarımızdan və ya forumlarımızdan şəxsi məlumatlarınızın silinməsini tələb edə bilərsiniz.</p>\r\n\r\n<p>&nbsp;</p>\r\n');

-- --------------------------------------------------------

--
-- Структура таблицы `posts`
--

CREATE TABLE `posts` (
  `postId` int(10) UNSIGNED NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `finishedAt` timestamp NULL DEFAULT NULL,
  `cityId` int(10) UNSIGNED DEFAULT NULL,
  `workers` int(10) UNSIGNED NOT NULL,
  `buildedAt` date NOT NULL,
  `income` decimal(10,0) UNSIGNED NOT NULL,
  `price` decimal(10,0) UNSIGNED NOT NULL,
  `site` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts`
--

INSERT INTO `posts` (`postId`, `userId`, `createdAt`, `status`, `finishedAt`, `cityId`, `workers`, `buildedAt`, `income`, `price`, `site`) VALUES
(1, 1, '2018-05-20 18:43:04', 0, NULL, 3, 0, '2020-05-20', '0', '0', ''),
(4, 1, '2018-05-21 17:38:19', 1, NULL, 1, 0, '2027-05-20', '0', '0', ''),
(5, 2, '2018-05-26 17:13:19', 0, NULL, 1, 12, '2026-05-20', '0', '0', '');

-- --------------------------------------------------------

--
-- Структура таблицы `posts_files`
--

CREATE TABLE `posts_files` (
  `fileId` int(11) NOT NULL,
  `userId` int(10) UNSIGNED NOT NULL,
  `postId` int(10) UNSIGNED DEFAULT NULL,
  `file` varchar(255) NOT NULL,
  `caption` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `size` int(10) UNSIGNED NOT NULL,
  `secret` varchar(30) DEFAULT NULL,
  `uploadedAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts_files`
--

INSERT INTO `posts_files` (`fileId`, `userId`, `postId`, `file`, `caption`, `type`, `size`, `secret`, `uploadedAt`) VALUES
(5, 1, NULL, 'posts_5b01c143439f26.92459059.png', '1.png', 'image/png', 510002, '5b01c129a08692.32969121', '2018-05-20 18:41:07'),
(6, 1, NULL, 'posts_5b01c143839711.46731011.pdf', '12-rules-to-learn-languages-in-record-time.pdf', 'application/pdf', 259009, '5b01c129a08692.32969121', '2018-05-20 18:41:07'),
(7, 2, 5, 'posts_5b0995ab2d6a49.52490025.pdf', '12-rules-to-learn-languages-in-record-time.pdf', 'application/pdf', 259009, '5b09956c944d18.18832813', '2018-05-26 17:13:15'),
(8, 2, 5, 'posts_5b0995ab74b556.73355315.png', '1.png', 'image/png', 510002, '5b09956c944d18.18832813', '2018-05-26 17:13:15'),
(9, 2, 5, 'posts_5b0995aba1a1f3.97462860.png', 'Untitled.png', 'image/png', 787012, '5b09956c944d18.18832813', '2018-05-26 17:13:15');

-- --------------------------------------------------------

--
-- Структура таблицы `posts_industries`
--

CREATE TABLE `posts_industries` (
  `id` int(10) UNSIGNED NOT NULL,
  `postId` int(10) UNSIGNED NOT NULL,
  `industryId` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts_industries`
--

INSERT INTO `posts_industries` (`id`, `postId`, `industryId`) VALUES
(1, 1, 5),
(10, 4, 15),
(11, 5, 5);

-- --------------------------------------------------------

--
-- Структура таблицы `posts_lang`
--

CREATE TABLE `posts_lang` (
  `langId` int(10) UNSIGNED NOT NULL,
  `postId` int(10) UNSIGNED NOT NULL,
  `lang` char(2) NOT NULL,
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `text_search` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `posts_lang`
--

INSERT INTO `posts_lang` (`langId`, `postId`, `lang`, `title`, `text`, `text_search`) VALUES
(1, 1, 'en', 'Array', 'Array', 'Array'),
(2, 1, 'ru', 'Array', 'Array', 'Array'),
(3, 1, 'az', 'Array', 'Array', 'Array'),
(4, 4, 'en', 'zz1', '<p>zzz1</p>\r\n', '<p>zzz1</p>'),
(5, 4, 'ru', 'xx1', '<p>xxx1</p>\r\n', '<p>xxx1</p>'),
(6, 4, 'az', 'cc1', '<p>ccc1</p>\r\n', '<p>ccc1</p>'),
(7, 5, 'en', 'вап вап вап sdfg sdg sdg ывап ', '<p>sdfg выап выап sdfg вап</p>\r\n\r\n<p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>\r\n', '<p>sdfg выап выап sdfg вап</p>  <p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>'),
(8, 5, 'ru', 'вап вап вап sdfg sdg sdg ывап ', '<p>sdfg выап выап sdfg вап</p>\r\n\r\n<p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>\r\n', '<p>sdfg выап выап sdfg вап</p>  <p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>'),
(9, 5, 'az', 'вап вап вап sdfg sdg sdg ывап ', '<p>sdfg выап выап sdfg вап</p>\r\n\r\n<p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>\r\n', '<p>sdfg выап выап sdfg вап</p>  <p>в sfgsd выап выап ывап ывап вып выап вып впа sdg вап</p>');

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
(2, 'User');

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
  `country` char(3) DEFAULT NULL,
  `cityId` int(10) UNSIGNED DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `site` varchar(255) DEFAULT NULL,
  `facebook` varchar(255) DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `activationCode` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`userId`, `login`, `password`, `createdAt`, `groupId`, `name`, `country`, `cityId`, `phone`, `email`, `site`, `facebook`, `status`, `activationCode`) VALUES
(1, 'admin', '$2y$10$WShDEA5s.Em0VNZYVpPaKeVTLtYMc2d7KHdchvWRLFhB5LYRmhUmW', '2017-07-28 08:02:27', 1, 'Admin', NULL, 0, '', 'k.kaluzhnikov@gmail.com', '', '', 1, 'eeef80f7660b283a3b799938a84416cc'),
(2, 'test-b', '$2y$10$6Ic.8Twc9D0lrd6E88DAQezbUqZHGj59qjn8gGwuCm9MGWhZpvcUu', '2017-08-04 06:41:42', 2, 'Test Buyer', 'AZ', 1, '0555555555', 'zeuz@list.ru', '', '', 1, '3f6b8a99b77a42b247003aa4e2563b23');

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
  ADD KEY `helpId` (`helpId`) USING BTREE;

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
-- Индексы таблицы `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`postId`),
  ADD KEY `userId` (`userId`);

--
-- Индексы таблицы `posts_files`
--
ALTER TABLE `posts_files`
  ADD PRIMARY KEY (`fileId`),
  ADD KEY `userId` (`userId`),
  ADD KEY `postId` (`postId`);

--
-- Индексы таблицы `posts_industries`
--
ALTER TABLE `posts_industries`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `post_indust_idx` (`postId`,`industryId`) USING BTREE;

--
-- Индексы таблицы `posts_lang`
--
ALTER TABLE `posts_lang`
  ADD PRIMARY KEY (`langId`),
  ADD KEY `postId` (`postId`) USING BTREE;
ALTER TABLE `posts_lang` ADD FULLTEXT KEY `title` (`title`,`text_search`);

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
  MODIFY `pageId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT для таблицы `pages_lang`
--
ALTER TABLE `pages_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT для таблицы `posts`
--
ALTER TABLE `posts`
  MODIFY `postId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `posts_files`
--
ALTER TABLE `posts_files`
  MODIFY `fileId` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `posts_industries`
--
ALTER TABLE `posts_industries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT для таблицы `posts_lang`
--
ALTER TABLE `posts_lang`
  MODIFY `langId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `userGroups`
--
ALTER TABLE `userGroups`
  MODIFY `userGroupId` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `userId` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `help_lang`
--
ALTER TABLE `help_lang`
  ADD CONSTRAINT `help_lang_ibfk_1` FOREIGN KEY (`helpId`) REFERENCES `help` (`helpId`) ON DELETE CASCADE ON UPDATE CASCADE;

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
