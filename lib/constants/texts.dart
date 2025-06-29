class Texts {
  static String _languageCode = 'ar';

  static void setLanguage(String languageCode) {
    _languageCode = languageCode;
  }

  static bool get isArabic => _languageCode == 'ar';

  // App Name
  static String get appName =>
      isArabic ? 'شركة صحارى المتحدة للطاقة' : 'Sahara United Energy Company';

  // Onboarding
  static String get onBoardingTitle =>
      isArabic
          ? 'بيع وصناعة الماكينات وبيع المنتجات الحديدية'
          : 'Sale and Manufacturing of Machines and Iron Products';

  static String get onBoardingDescription =>
      isArabic
          ? 'شركة صحارى المتحدة رواد معدات الحفر (CAT) وقطع غيار وزيوت (CAT) الأصلية من الوكيل المعتمد شركة الزاهد للتراكتورات المحدودة ومشاريع الحفر بأعلى مقاييس جودة الأداء وكيل الشواكيش الكورية (KOROCK) موزع معتمد.'
          : 'Sahara United Company pioneers drilling equipment (CAT) and original spare parts and oils (CAT) from the authorized dealer Al-Zahed Tractors Limited and drilling projects with the highest standards of performance quality, Korean hammers agent (KOROCK) authorized distributor.';

  static String get startNow => isArabic ? 'ابدأ الآن' : 'Start Now';
  static String get searchProducts =>
      isArabic ? 'ابحث عن معدات' : 'Search Equipment';

  // Bottom Navigator
  static String get home => isArabic ? 'الرئيسية' : 'Home';
  static String get departments => isArabic ? 'الأقسام' : 'Departments';
  static String get ourProjects => isArabic ? 'مشاريعنا' : 'Our Projects';
  static String get contactUs => isArabic ? 'تواصل معنا' : 'Contact Us';
  static String get requestPrices =>
      isArabic ? 'طلب عرض أسعار' : 'Request Quote';

  // Home
  static String get homeWelcome =>
      isArabic
          ? 'مرحبا بك في شركة صحارى المتحدة للطاقة'
          : 'Welcome to Sahara United Energy Company';
  static String get homeError =>
      isArabic ? 'خطأ في تحميل الصفحة الرئيسية' : 'Error loading home page';

  // Drawer
  static String get questionnaire =>
      isArabic ? 'استبيان رضا العملاء' : 'Customer Satisfaction Survey';
  static String get aboutApp => isArabic ? 'عن التطبيق' : 'About App';
  static String get commonQuestions => isArabic ? 'الاسئلة الشائعة' : 'FAQ';
  static String get termsAndConditions =>
      isArabic ? 'الشروط و الاحكام' : 'Terms & Conditions';
  static String get clients => isArabic ? 'العملاء' : 'Clients';
  static String get partners => isArabic ? 'الشركاء' : 'Partners';
  static String get whoWeAre => isArabic ? 'من نحن' : 'Who We Are';
  static String get language => isArabic ? 'اللغة' : 'Language';

  // Who we are
  static String get vision => isArabic ? 'الرؤية' : 'Vision';
  static String get visionContent =>
      isArabic
          ? 'أن نصبح الخيار الأول في المملكة العربية السعودية ودول المنطقة في مجال المعدات الثقيلة والطاقة، من خلال تقديم منتجات وخدمات تُعزز من كفاءة الأعمال وتدعم التنمية المستدامة'
          : 'To become the first choice in Saudi Arabia and the region in the field of heavy equipment and energy, by providing products and services that enhance business efficiency and support sustainable development';

  static String get goals => isArabic ? 'الأهداف' : 'Goals';
  static String get goalsContent =>
      isArabic
          ? 'توفير أحدث المعدات ذات الجودة العالية. \nبناء علاقات طويلة الأمد مع عملائنا.\nتحقيق التميز في جميع خدماتنا لضمان رضا العملاء.'
          : 'Provide the latest high-quality equipment. \nBuild long-term relationships with our customers.\nAchieve excellence in all our services to ensure customer satisfaction.';

  static String get message => isArabic ? 'الرسالة' : 'Message';
  static String get messageContent =>
      isArabic
          ? 'نطمح إلى تقديم حلول مبتكرة وشاملة في قطاع الطاقة والمعدات الثقيلة، مع التركيز على الجودة العالية، والالتزام بتلبية احتياجات عملائنا بأفضل المعايير'
          : 'We aspire to provide innovative and comprehensive solutions in the energy and heavy equipment sector, focusing on high quality and commitment to meeting our customers\' needs with the best standards';

  static String get values => isArabic ? 'القيم' : 'Values';
  static String get valuesContent =>
      isArabic
          ? 'النزاهة: الالتزام بالشفافية والمصداقية في جميع تعاملاتنا.\nالجودة: تقديم منتجات وخدمات بمعايير عالمية.\nالابتكار: السعي لتقديم حلول متطورة تلبي احتياجات السوق.'
          : 'Integrity: Commitment to transparency and credibility in all our dealings.\nQuality: Providing products and services with international standards.\nInnovation: Striving to provide advanced solutions that meet market needs.';

  static String get competitivePrices =>
      isArabic ? 'أسعار تنافسية' : 'Competitive Prices';
  static String get competitivePricesContent =>
      isArabic
          ? 'نحرص على تقديم أسعار تنافسية ومناسبة لجميع العملاء، مع ضمان جودة المنتجات والخدمات لتحقيق أفضل قيمة ممكنة'
          : 'We strive to offer competitive and suitable prices for all customers, while ensuring the quality of products and services to achieve the best possible value';

  static String get quality =>
      isArabic ? 'الجودة والتغطية' : 'Quality & Coverage';
  static String get qualityContent =>
      isArabic
          ? 'نلتزم بتوفير منتجات وخدمات بأعلى معايير الجودة، مع تغطية شاملة تلبي احتياجات السوق المحلي والإقليمي'
          : 'We are committed to providing products and services with the highest quality standards, with comprehensive coverage that meets the needs of the local and regional market';

  static String get downloadCommercialPapers =>
      isArabic ? 'تحميل السجل التجاري' : 'Download Commercial Register';

  // Contact us
  static String get websiteTitle => isArabic ? 'الموقع الألكتروني' : 'Website';
  static String get websiteContent => 'sahary.com.sa';
  static String get phoneTitle => isArabic ? 'الهاتف' : 'Phone';
  static String get phoneContent => '00966114868415 \n00966564188059';
  static String get emailTitle => isArabic ? 'البريد الإلكتروني' : 'Email';
  static String get emailContent => 'info@sahary.com.sa';
  static String get addressTitle => isArabic ? 'العنوان' : 'Address';
  static String get addressContent =>
      isArabic
          ? '7235 العليا، 2392، حي العليا، الرياض 12244، المملكة العربية السعودية'
          : '7235 Al Olaya, 2392, Al Olaya District, Riyadh 12244, Saudi Arabia';

  static String get sendUsMessage =>
      isArabic ? 'ارسل لنا رسالة' : 'Send Us a Message';
  static String get name => isArabic ? 'الاسم' : 'Name';
  static String get pleaseEnterName =>
      isArabic ? 'من فضلك ادخل الاسم' : 'Please enter name';
  static String get phoneNumber => isArabic ? 'رقم الجوال' : 'Phone Number';
  static String get pleaseEnterPhoneNumber =>
      isArabic ? 'من فضلك ادخل رقم الجوال' : 'Please enter phone number';
  static String get emailAddress =>
      isArabic ? 'البريد الألكتروني' : 'Email Address';
  static String get pleaseEnterEmailAddress =>
      isArabic
          ? 'من فضلك ادخل البريد الالكتروني'
          : 'Please enter email address';
  static String get pleaseEnterMessage =>
      isArabic ? 'من فضلك ادخل الرسالة' : 'Please enter message';
  static String get messageSentSuccessfully =>
      isArabic ? 'تم ارسال الرسالة بنجاج' : 'Message sent successfully';
  static String get sendMessage => isArabic ? 'ارسل الرسالة' : 'Send Message';

  // Our projects
  static String get projectType => isArabic ? 'نوع المشروع' : 'Project Type';
  static String get geographicLocation =>
      isArabic ? 'الموقع الجغرافي' : 'Geographic Location';
  static String get projectState =>
      isArabic ? 'حالة المشروع' : 'Project Status';
  static String get clearAll => isArabic ? 'مسح الكل' : 'Clear All';
  static String get showResults => isArabic ? 'اظهر النتائج' : 'Show Results';
  static String get ourProjectsError =>
      isArabic ? 'خطأ في تحميل المشاريع' : 'Error loading projects';
  static String get noProjects =>
      isArabic ? 'لا توجد مشاريع متاحة' : 'No projects available';

  // Departments
  static String get brandsAndModels =>
      isArabic ? 'الماركات والموديلات' : 'Brands & Models';
  static String get divisionsError =>
      isArabic ? 'خطأ في تحميل الأقسام' : 'Error loading departments';

  // Request prices
  static String get pleaseEnterCompanyName =>
      isArabic ? 'يرجى إدخال اسم الشركة' : 'Please enter company name';
  static String get pleaseSelectCity =>
      isArabic ? 'يرجى اختيار المدينة' : 'Please select city';
  static String get pleaseEnterAddress =>
      isArabic ? 'يرجى إدخال العنوان' : 'Please enter address';
  static String get pleaseSelectSection =>
      isArabic ? 'يرجى اختيار القسم' : 'Please select section';
  static String get pleaseEnterInquiries =>
      isArabic ? 'يرجى إدخال الاستفسارات' : 'Please enter inquiries';
  static String get requestSentSuccessfully =>
      isArabic
          ? 'تم إرسال طلب الأسعار بنجاح'
          : 'Quote request sent successfully';
  static String get fileSelectedSuccessfully =>
      isArabic ? 'تم اختيار الملف بنجاح' : 'File selected successfully';
  static String get companyName => isArabic ? 'اسم الشركة' : 'Company Name';
  static String get city => isArabic ? 'المدينة' : 'City';
  static String get address => isArabic ? 'العنوان' : 'Address';
  static String get section => isArabic ? 'القسم' : 'Section';
  static String get uploadFile => isArabic ? 'رفع ملف' : 'Upload File';
  static String get inquiries => isArabic ? 'الاستفسارات' : 'Inquiries';
  static String get sendPriceRequest =>
      isArabic ? 'إرسال طلب الأسعار' : 'Send Quote Request';
  static String get requestPricesError =>
      isArabic ? 'خطأ في تحميل طلب الأسعار' : 'Error loading quote request';
  static String get sending => isArabic ? 'إرسال...' : 'Sending...';
  static String get inquireAbout =>
      isArabic ? 'أرغب في الاستفسار عن:' : 'I would like to inquire about:';
  static String get permissionDenied =>
      isArabic ? 'لقد تم رفض الأذن' : 'Permission denied';
  static String get phoneHints =>
      isArabic
          ? 'رقم الهاتف يجب أن يحتوي على أرقام فقط'
          : 'Phone number should contain only numbers';
  static String get emailHints =>
      isArabic ? 'صيغة البريد الإلكتروني غير صحيحة' : 'Invalid email format';

  // Product details
  static String get requestProduct =>
      isArabic ? 'طلب المنتج' : 'Request Product';
  static String get specs => isArabic ? 'المواصفات' : 'Specifications';
  static String get guide => isArabic ? 'دليل الاستخدام' : 'User Guide';
  static String get videos => isArabic ? 'فيديوهات' : 'Videos';
  static String get noProducts =>
      isArabic
          ? 'لا يوجد منتجات في هذا القسم بعد.'
          : 'No products in this section yet.';
  static String get noProductsMatchSearch =>
      isArabic
          ? 'لا يوجد منتجات مطابقة للبحث.'
          : 'No products match the search.';
  static String get productsError =>
      isArabic ? 'خطأ في تحميل المنتجات' : 'Error loading products';
  static String get noSpecs =>
      isArabic ? 'لا يوجد مواصفات متاحة' : 'No specifications available';

  // Home
  static String get notableProducts =>
      isArabic ? 'أهم منتجاتنا' : 'Our Notable Products';

  // Toasts
  static String get connectionTimeout =>
      isArabic
          ? "انتهت الفترة الزمنية للاتصال، حاول مرة أخرى"
          : "Connection timeout, try again";
  static String get somethingWentWrongTryAgain =>
      isArabic
          ? "حدث خطأ في النظام، حاول مرة اخرى."
          : "Something went wrong, try again.";
  static String get failedInternetConnectionTryAgain =>
      isArabic
          ? "حدث خطأ في الاتصال، حاول مرة اخرى."
          : "Internet connection failed, try again.";
  static String get dataSavedSuccessfully =>
      isArabic ? "تم حفظ البيانات بنجاح." : "Data saved successfully.";
  static String get retry => isArabic ? 'إعادة المحاولة' : 'Retry';

  // Input
  static String get pleaseEnter => isArabic ? 'من فضلك ادخل' : 'Please enter';
  static String get pleaseEnterRequirement =>
      isArabic ? 'من فضلك ادخل المطلوب' : 'Please enter requirement';
  static String get enterCorrectNumber =>
      isArabic ? 'ادخل رقم صحيح' : 'Enter correct number';
  static String get insertFile => isArabic ? 'ارفاق ملف' : 'Attach file';
  static String get inputError =>
      isArabic ? 'خطأ في المعلومات المدخلة' : 'Input error';

  static String get partnersError =>
      isArabic ? 'خطأ في تحميل الشركاء' : 'Error loading partners';
  static String get clientsError =>
      isArabic ? 'خطأ في تحميل العملاء' : 'Error loading clients';
}
