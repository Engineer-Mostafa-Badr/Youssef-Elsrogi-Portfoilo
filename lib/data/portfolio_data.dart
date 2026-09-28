import 'package:flutter/material.dart';

import '../core/app_state.dart';

// ─────────────────────────── Profile ───────────────────────────

class Profile {
  static const name = T('Youssef Elsrogi', 'يوسف السروجي');
  static const role = T('Mid-Level Backend Laravel Developer', 'مطوّر Backend Laravel متوسط الخبرة');
  static const tagline = T(
    'I design and ship secure, multi-tenant Laravel backends — clean APIs, event-driven integrations, and systems that keep working when real traffic hits.',
    'ببني وبشحن Backend بـ Laravel آمن و multi-tenant — APIs نضيفة، integrations مبنية على events، وسيستمات بتفضل شغّالة لما الترافيك الحقيقي ييجي.',
  );
  static const typedRoles = [
    T('Laravel Backend Developer', 'مطوّر Laravel Backend'),
    T('Multi-tenant SaaS Engineer', 'مهندس SaaS متعدد الـ tenants'),
    T('API & Integrations Builder', 'باني APIs و Integrations'),
    T('Webhooks & Queues Wrangler', 'خبير Webhooks و Queues'),
  ];
  static const location = T('Gharbia, Egypt', 'الغربية، مصر');
}

class Stat {
  const Stat(this.value, this.label);
  final String value;
  final T label;
}

const heroStats = [
  Stat('2+', T('Years building backends', 'سنين في بناء الـ Backend')),
  Stat('9+', T('Production systems', 'سيستم في الإنتاج')),
  Stat('9', T('3rd-party integrations', 'Integration خارجي')),
];

const marqueeItems = [
  'Laravel',
  'PHP',
  'MySQL',
  'Redis',
  'Horizon',
  'Passport · OAuth2',
  'Stancl Tenancy',
  'Webhooks',
  'Zid',
  'Zoho CRM',
  'Tap Payments',
  'Stripe',
  'Firebase',
  'OneSignal',
  'AWS S3',
  'PHPUnit',
  'Swagger',
];

class Fact {
  const Fact(this.label, this.value);
  final T label;
  final T value;
}

const aboutFacts = [
  Fact(T('Level', 'المستوى'), T('Mid-Level Backend Developer', 'مطوّر Backend متوسط الخبرة')),
  Fact(T('Experience', 'الخبرة'), T('2+ years · 2 companies + internship', 'أكتر من سنتين · شركتين + تدريب')),
  Fact(T('Currently', 'حالياً'), T('Backend Developer @ Apps Bunches', 'مطوّر Backend في Apps Bunches')),
  Fact(T('Based in', 'المكان'), T('Gharbia, Egypt · Remote-friendly', 'الغربية، مصر · متاح Remote')),
  Fact(T('Education', 'التعليم'), T('B.Sc. Computer Science, Zagazig Univ.', 'بكالوريوس علوم حاسب، جامعة الزقازيق')),
  Fact(T('Languages', 'اللغات'), T('Arabic (Native) · English (Basic)', 'العربية (الأم) · الإنجليزية (أساسي)')),
];

// ─────────────────────────── About ───────────────────────────

class AboutCard {
  const AboutCard(this.icon, this.title, this.body);
  final IconData icon;
  final T title;
  final T body;
}

const aboutCards = [
  AboutCard(
    Icons.dns_rounded,
    T('Background', 'الخلفية'),
    T(
      'Backend developer with 2+ years of hands-on experience across three companies (internship & full-time) — building, optimizing, and maintaining Laravel systems that power web dashboards and white-label iOS/Android apps.',
      'مطوّر Backend بخبرة عملية أكتر من سنتين في 3 شركات (تدريب و full-time) — ببني وبحسّن وبصون سيستمات Laravel بتشغّل web dashboards وتطبيقات iOS/Android بـ white-label.',
    ),
  ),
  AboutCard(
    Icons.hub_rounded,
    T('Focus', 'التخصص'),
    T(
      'Multi-tenant SaaS, RESTful API design, OAuth2 auth, webhook-driven integrations (Zid, Zoho, Tap, Stripe), queues, and state-machine workflows — all on Clean Architecture with the Service–Repository pattern and SOLID.',
      'SaaS متعدد الـ tenants، تصميم RESTful APIs، مصادقة OAuth2، integrations مبنية على webhooks (Zid و Zoho و Tap و Stripe)، queues، و workflows بـ state machines — كله على Clean Architecture و Service–Repository و SOLID.',
    ),
  ),
  AboutCard(
    Icons.school_rounded,
    T('Education', 'التعليم'),
    T(
      'B.Sc. Computer Science — Zagazig University (2025 – 2029). Backend Diploma — Nasr City, Cairo (Jul 2024).',
      'بكالوريوس علوم حاسب — جامعة الزقازيق (2025 – 2029). دبلومة Backend — مدينة نصر، القاهرة (يوليو 2024).',
    ),
  ),
  AboutCard(Icons.translate_rounded, T('Languages', 'اللغات'), T('Arabic (Native) · English (Basic)', 'العربية (اللغة الأم) · الإنجليزية (أساسي)')),
];

const personalSkills = [
  T('Problem-Solving & Critical Thinking', 'حل المشكلات والتفكير النقدي'),
  T('Strong Communication', 'تواصل قوي'),
  T('Team Collaboration', 'شغل الفريق'),
  T('Time Management', 'إدارة الوقت'),
  T('Continuous Learning', 'تعلّم مستمر'),
];

// ─────────────────────────── Skills ───────────────────────────

class SkillGroup {
  const SkillGroup(this.icon, this.title, this.items);
  final IconData icon;
  final T title;
  final List<String> items;
}

const skillGroups = [
  SkillGroup(Icons.code_rounded, T('Core Backend', 'الـ Backend الأساسي'), [
    'PHP',
    'Laravel 10',
    'MySQL',
    'Redis',
    'RESTful APIs',
    'Eloquent ORM',
    'OOP',
  ]),
  SkillGroup(Icons.account_tree_rounded, T('Architecture', 'المعمارية'), [
    'Multi-Tenancy',
    'Clean Architecture',
    'Service–Repository Pattern',
    'SOLID Principles',
    'Event-Driven Architecture',
    'State Machines',
    'Action Classes',
    'ERD Design',
  ]),
  SkillGroup(Icons.layers_rounded, T('Laravel Ecosystem', 'منظومة Laravel'), [
    'Passport (OAuth2)',
    'Horizon (Queues)',
    'Telescope',
    'Livewire',
    'Stancl Tenancy',
    'Spatie Permission',
    'Spatie Activity Log',
    'Spatie Settings',
    'Yajra DataTables',
    'Blade',
  ]),
  SkillGroup(Icons.power_rounded, T('Integrations', 'الـ Integrations'), [
    'Zid',
    'Zoho CRM',
    'Zoho Desk',
    'Firebase Remote Config',
    'OneSignal',
    'Tap Payments',
    'Stripe',
    'SendGrid',
    'AWS S3',
    'Webhooks',
  ]),
  SkillGroup(Icons.shield_rounded, T('Security & Auth', 'الأمان والمصادقة'), [
    'OAuth2',
    'Token Lifecycle & Refresh',
    'Role-Based Access Control',
    'Per-tenant Data Isolation',
    'Credential Isolation',
    'Audit Trails',
  ]),
  SkillGroup(Icons.fact_check_rounded, T('Testing, Docs & Ops', 'الاختبار والتوثيق والتشغيل'), [
    'PHPUnit',
    'Postman',
    'Swagger',
    'API Contracts',
    'Production Debugging',
    'Git & GitHub',
    'DomPDF',
    'Maatwebsite Excel',
  ]),
];

class Tool {
  const Tool(this.name, this.role, this.icon);
  final String name;
  final T role;
  final IconData icon;
}

const tools = [
  Tool('Laravel', T('Framework', 'Framework'), Icons.bolt_rounded),
  Tool('MySQL', T('Primary DB', 'قاعدة البيانات'), Icons.storage_rounded),
  Tool('Redis', T('Cache · Queues', 'Cache · Queues'), Icons.memory_rounded),
  Tool('Horizon', T('Queue Monitor', 'مراقبة الـ Queues'), Icons.monitor_heart_rounded),
  Tool('Telescope', T('Debugging', 'Debugging'), Icons.troubleshoot_rounded),
  Tool('Postman', T('API Testing', 'اختبار الـ APIs'), Icons.send_rounded),
  Tool('Swagger', T('API Docs', 'توثيق الـ APIs'), Icons.menu_book_rounded),
  Tool('PHPUnit', T('Automated Tests', 'اختبارات آلية'), Icons.verified_rounded),
  Tool('AWS S3', T('File Storage', 'تخزين الملفات'), Icons.cloud_rounded),
  Tool('Git + GitHub', T('Version Control', 'Version Control'), Icons.merge_type_rounded),
];

// ─────────────────────────── Experience ───────────────────────────

class Job {
  const Job({
    required this.role,
    required this.company,
    required this.location,
    required this.start,
    this.end,
    required this.summary,
    required this.bullets,
    required this.tech,
  });
  final T role;
  final String company;
  final T location;
  final DateTime start;
  final DateTime? end;
  final T summary;
  final List<T> bullets;
  final List<String> tech;
}

final jobs = [
  Job(
    role: const T('Backend Developer', 'مطوّر Backend'),
    company: 'Apps Bunches',
    location: const T('Riyadh, Saudi Arabia', 'الرياض، السعودية'),
    start: DateTime(2025, 12),
    summary: const T(
      'Backend for multi-tenant SaaS platforms and white-label mobile apps — owning APIs, integrations, and the contracts mobile/frontend teams build on.',
      'Backend لمنصات SaaS متعددة الـ tenants وتطبيقات موبايل white-label — مسؤول عن الـ APIs والـ integrations والـ contracts اللي فرق الموبايل والفرونت بتبني عليها.',
    ),
    bullets: const [
      T(
        'Built and maintained multi-tenant SaaS backends integrating Zid and Zoho (incl. Zoho CRM) — centralizing e-commerce operations, customers, and order workflows across interconnected systems.',
        'بنيت وبصون Backend لمنصات SaaS متعددة الـ tenants متكاملة مع Zid و Zoho (ومنها Zoho CRM) — بتجمّع عمليات التجارة الإلكترونية والعملاء و workflows الطلبات عبر سيستمات مترابطة.',
      ),
      T(
        'Developed RESTful APIs powering web dashboards and white-label iOS/Android apps — Builder (Zid-based app generator), CRM systems, Wezaan (DGA-aligned compliance platform) and XO (multi-vendor booking SaaS).',
        'طوّرت RESTful APIs بتشغّل web dashboards وتطبيقات iOS/Android بـ white-label — Builder (مولّد تطبيقات مبني على Zid)، سيستمات CRM، Wezaan (منصة امتثال متوافقة مع هيئة الحكومة الرقمية) و XO (SaaS حجوزات متعدد البائعين).',
      ),
      T(
        'Designed API contracts with mobile & frontend teams and wired Firebase Remote Config for real-time feature updates and dynamic configuration.',
        'صمّمت API contracts مع فرق الموبايل والفرونت، وربطت Firebase Remote Config عشان تحديثات الـ features والإعدادات تبقى لحظية.',
      ),
      T(
        'Embedded Zoho Desk via Widget Injection in the merchant dashboard, tracked ticket status in real time through Zoho Desk webhooks, alongside Stripe-based payments.',
        'دمجت Zoho Desk بـ Widget Injection جوه داشبورد التاجر، وتابعت حالة التذاكر لحظياً عن طريق webhooks بتاعة Zoho Desk، جنب الدفع عن طريق Stripe.',
      ),
    ],
    tech: const ['Laravel 10', 'Passport', 'Horizon', 'Redis', 'Zid', 'Zoho CRM', 'Zoho Desk', 'Stripe', 'Tap', 'Firebase', 'AWS S3'],
  ),
  Job(
    role: const T('Backend Developer', 'مطوّر Backend'),
    company: 'Industrial General Services (IGS)',
    location: const T('Cairo, Egypt', 'القاهرة، مصر'),
    start: DateTime(2024, 10),
    end: DateTime(2025, 12),
    summary: const T(
      'API-based enterprise systems on a multi-tenant architecture — from greenfield builds to documenting and extending legacy code.',
      'سيستمات enterprise مبنية على APIs بمعمارية multi-tenant — من بناء سيستمات من الصفر لحد توثيق وتطوير كود legacy.',
    ),
    bullets: const [
      T(
        'Built and maintained API-based systems on a Multi-Tenancy architecture for scalability and strict data isolation.',
        'بنيت وصنت سيستمات مبنية على APIs بمعمارية Multi-Tenancy عشان الـ scalability وعزل البيانات بشكل صارم.',
      ),
      T('Developed a complete Bugs Tracker system from scratch.', 'طوّرت سيستم Bugs Tracker كامل من الصفر.'),
      T(
        'Applied the Service–Repository pattern and SOLID principles across projects.',
        'طبّقت Service–Repository pattern ومبادئ SOLID في كل المشاريع.',
      ),
      T(
        'Designed ERDs for undocumented legacy systems so the team could reason about them again.',
        'صمّمت ERDs لسيستمات legacy مالهاش توثيق عشان الفريق يقدر يفهمها ويشتغل عليها تاني.',
      ),
      T(
        'Adopted automated testing with PHPUnit after specialized training, and integrated APIs with frontend teams.',
        'بدأت أكتب اختبارات آلية بـ PHPUnit بعد تدريب متخصص، وربطت الـ APIs مع فرق الفرونت.',
      ),
    ],
    tech: const ['Laravel', 'MySQL', 'Multi-Tenancy', 'Service–Repository', 'PHPUnit', 'ERD'],
  ),
];

String duration(DateTime start, DateTime? end, bool ar) {
  final e = end ?? DateTime.now();
  final months = (e.year - start.year) * 12 + e.month - start.month + 1;
  final y = months ~/ 12, m = months % 12;
  if (ar) {
    final parts = <String>[];
    if (y > 0) parts.add(y == 1 ? 'سنة' : (y == 2 ? 'سنتين' : '$y سنين'));
    if (m > 0) parts.add(m == 1 ? 'شهر' : (m == 2 ? 'شهرين' : '$m شهور'));
    return parts.join(' و ');
  }
  final parts = <String>[];
  if (y > 0) parts.add('$y yr${y > 1 ? 's' : ''}');
  if (m > 0) parts.add('$m mo${m > 1 ? 's' : ''}');
  return parts.join(' ');
}

String monthYear(DateTime d, bool ar) {
  const en = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  const a = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
  return '${(ar ? a : en)[d.month - 1]} ${d.year}';
}

// ─────────────────────────── Process ───────────────────────────

class ProcessStep {
  const ProcessStep(this.icon, this.title, this.body);
  final IconData icon;
  final T title;
  final T body;
}

const processSteps = [
  ProcessStep(
    Icons.schema_rounded,
    T('Model', 'نمذجة'),
    T(
      'Start from the data: an ERD, tenant boundaries, and the API contract agreed with mobile & frontend before a single controller exists.',
      'ببدأ من الداتا: ERD، حدود الـ tenants، و API contract متفق عليه مع الموبايل والفرونت قبل ما أكتب أي controller.',
    ),
  ),
  ProcessStep(
    Icons.construction_rounded,
    T('Build', 'بناء'),
    T(
      'Thin controllers, Service–Repository layers, and single-purpose Action classes. Events and queued jobs for anything slow or external.',
      'Controllers خفيفة، طبقات Service–Repository، و Action classes كل واحدة ليها وظيفة واحدة. Events و queued jobs لأي حاجة بطيئة أو خارجية.',
    ),
  ),
  ProcessStep(
    Icons.rule_rounded,
    T('Verify', 'تحقق'),
    T(
      'PHPUnit feature tests around the risky paths, Postman collections and Swagger docs so every consumer knows exactly what to expect.',
      'Feature tests بـ PHPUnit حوالين الأجزاء الحساسة، و Postman collections و Swagger docs عشان أي حد بيستهلك الـ API يعرف بالظبط يتوقع إيه.',
    ),
  ),
  ProcessStep(
    Icons.insights_rounded,
    T('Observe', 'مراقبة'),
    T(
      'Horizon for queues, Telescope for requests, activity logs and audit trails — so production issues are traced, not guessed.',
      'Horizon للـ queues، و Telescope للـ requests، و activity logs و audit trails — عشان مشاكل الـ production تتتبّع مش تتخمّن.',
    ),
  ),
];

// ─────────────────────────── Projects ───────────────────────────

enum ProjectCat { saas, integration, enterprise, openSource }

const projectCatLabels = {
  ProjectCat.saas: T('SaaS', 'SaaS'),
  ProjectCat.integration: T('Integrations', 'Integrations'),
  ProjectCat.enterprise: T('Enterprise', 'Enterprise'),
  ProjectCat.openSource: T('Open Source', 'Open Source'),
};

class Project {
  const Project({
    required this.title,
    required this.short,
    required this.company,
    required this.cat,
    required this.status,
    required this.icon,
    required this.concept,
    required this.flow,
    required this.highlights,
    required this.tech,
    this.stateMachine,
    this.aggregation,
    this.subProjects,
    this.repo,
    this.featured = false,
  });

  final T title;
  final T short;
  final String company;
  final ProjectCat cat;
  final T status;
  final IconData icon;
  final T concept;
  final List<String> flow;
  final List<T> highlights;
  final List<String> tech;
  final List<String>? stateMachine;
  final List<String>? aggregation;
  final List<String>? subProjects;
  final String? repo;
  final bool featured;
}

const projects = [
  Project(
    featured: true,
    title: T('Builder — Branded App Generator SaaS', 'Builder — منصة SaaS لتوليد تطبيقات بهوية التاجر'),
    short: T(
      'Merchants synced from Zid generate & publish their own branded iOS/Android apps.',
      'تجار Zid بيولّدوا وينشروا تطبيقات iOS/Android بهويتهم الخاصة.',
    ),
    company: 'Apps Bunches',
    cat: ProjectCat.saas,
    status: T('Production', 'في الإنتاج'),
    icon: Icons.phone_iphone_rounded,
    concept: T(
      'Multi-tenant Laravel backend that lets e-commerce merchants (synced from the Zid platform) generate, customize, and publish their own branded iOS/Android apps — managing splash screens, icons, popups, ads, and push campaigns from a central admin panel.',
      'Backend بـ Laravel متعدد الـ tenants بيخلّي تجار التجارة الإلكترونية (المتزامنين من منصة Zid) يولّدوا ويخصّصوا وينشروا تطبيقات iOS/Android بهويتهم — ويتحكموا في الـ splash والأيقونات والـ popups والإعلانات وحملات الـ push من admin panel مركزي.',
    ),
    flow: ['Zid Store', 'Webhooks', 'Tenant Scope', 'Horizon Queues', 'Remote Config · Push', 'Branded App'],
    highlights: [
      T(
        'Store-scoped multi-tenancy with bidirectional Zid webhook sync — orders, customers, products, and abandoned carts.',
        'Multi-tenancy على مستوى المتجر مع sync ثنائي الاتجاه بـ webhooks بتاعة Zid — الطلبات والعملاء والمنتجات والسلّات المتروكة.',
      ),
      T(
        'Tiered subscription & feature-flag billing engine with Tap Payments integration.',
        'محرّك اشتراكات بمستويات و feature flags مع تكامل Tap Payments.',
      ),
      T(
        'Firebase Remote Config for live app theming, splash, and ad delivery — no app-store release needed.',
        'Firebase Remote Config لتغيير ثيم التطبيق والـ splash والإعلانات لايف — من غير إصدار جديد على الستور.',
      ),
      T(
        'OneSignal push notifications incl. automated abandoned-cart and back-in-stock campaigns; SendGrid email.',
        'إشعارات push بـ OneSignal ومنها حملات آلية للسلّات المتروكة ورجوع المنتج للمخزون؛ وإيميلات بـ SendGrid.',
      ),
      T(
        'App build/review workflow for App Store & Play Store submissions.',
        'Workflow لبناء ومراجعة التطبيقات قبل رفعها على App Store و Play Store.',
      ),
      T(
        'Zoho Desk embedded via Widget Injection in the merchant dashboard, with webhooks tracking ticket status in real time; Stripe payments.',
        'Zoho Desk متدمج بـ Widget Injection في داشبورد التاجر، و webhooks بتتابع حالة التذاكر لحظياً؛ ودفع بـ Stripe.',
      ),
      T(
        'Role-based access control, activity logging, and a full audit trail via Spatie packages.',
        'صلاحيات بالأدوار، activity logging، و audit trail كامل باستخدام باكدجات Spatie.',
      ),
    ],
    tech: [
      'Laravel 10',
      'Passport (OAuth2)',
      'Livewire',
      'Horizon',
      'Telescope',
      'MySQL',
      'Redis (Predis)',
      'AWS S3',
      'Tap Payments',
      'Stripe',
      'Firebase Remote Config',
      'OneSignal',
      'SendGrid',
      'Zoho Desk',
      'Spatie',
    ],
  ),
  Project(
    featured: true,
    title: T('Zid ⇄ Zoho CRM Integration', 'تكامل Zid ⇄ Zoho CRM'),
    short: T(
      'Near-real-time sync of customers, orders & products between Zid stores and Zoho CRM.',
      'Sync شبه لحظي للعملاء والطلبات والمنتجات بين متاجر Zid و Zoho CRM.',
    ),
    company: 'Apps Bunches',
    cat: ProjectCat.integration,
    status: T('Production', 'في الإنتاج'),
    icon: Icons.sync_alt_rounded,
    concept: T(
      'Laravel backend that connects Zid storefronts with Zoho CRM, syncing customers, orders, and products across multi-tenant stores in near real time via webhooks and scheduled jobs.',
      'Backend بـ Laravel بيربط متاجر Zid بـ Zoho CRM، وبيعمل sync للعملاء والطلبات والمنتجات عبر متاجر متعددة الـ tenants بشكل شبه لحظي عن طريق webhooks و scheduled jobs.',
    ),
    flow: ['Zid Event', 'Abstract Service', 'Action Class', 'CRM Functions', 'Zoho CRM'],
    highlights: [
      T(
        'Webhook architecture with an abstract service layer that maps events at runtime to dedicated Action classes (e.g. order.create → Order/Create).',
        'معمارية webhooks بطبقة service مجرّدة بتربط كل event وقت التشغيل بـ Action class مخصص (مثلاً order.create ← Order/Create).',
      ),
      T(
        'Webhook-driven + scheduled sync keeps local store data aligned with Zoho CRM via CRM Functions (checkcontact, checkorder).',
        'Sync بالـ webhooks + scheduled jobs بيخلّي داتا المتجر متطابقة مع Zoho CRM عن طريق CRM Functions (checkcontact و checkorder).',
      ),
      T(
        'Full OAuth2 token lifecycle for both Zid and Zoho with automatic refresh.',
        'دورة حياة OAuth2 tokens كاملة لـ Zid و Zoho مع refresh تلقائي.',
      ),
      T(
        'Per-store credential isolation (ZohoAccount, StoreZohoConfiguration) — one tenant can never touch another’s CRM.',
        'عزل الـ credentials لكل متجر (ZohoAccount و StoreZohoConfiguration) — مستحيل tenant يلمس CRM بتاع tenant تاني.',
      ),
      T(
        'Admin dashboard with Blade + Yajra DataTables; transactional email through SendGrid.',
        'Admin dashboard بـ Blade + Yajra DataTables؛ وإيميلات transactional بـ SendGrid.',
      ),
    ],
    tech: ['Laravel 10', 'Blade', 'Yajra DataTables', 'Passport', 'Spatie Permission', 'Telescope', 'MySQL', 'SendGrid', 'AWS S3', 'Zoho CRM', 'Zid'],
  ),
  Project(
    featured: true,
    title: T('Wezaan — Performance & Excellence Measurement', 'Wezaan — منصة قياس الأداء والتميّز المؤسسي'),
    short: T(
      'GovTech compliance platform aligned with Saudi DGA standards — scoring, reviews, and reports.',
      'منصة امتثال حكومية متوافقة مع معايير هيئة الحكومة الرقمية — تقييم ومراجعات وتقارير.',
    ),
    company: 'Apps Bunches',
    cat: ProjectCat.saas,
    status: T('Production', 'في الإنتاج'),
    icon: Icons.account_balance_rounded,
    concept: T(
      'Multi-tenant backend API for managing institutional performance-measurement cycles — departments are scored against perspectives, axes, and criteria, with evidence submission, multi-stage review workflows, and automated report generation. Aligned with Saudi Digital Government Authority (DGA) standards.',
      'Backend API متعدد الـ tenants لإدارة دورات قياس الأداء المؤسسي — الإدارات بتتقيّم على منظورات ومحاور ومعايير، مع رفع الأدلة، و workflows مراجعة متعددة المراحل، وتوليد تقارير آلي. متوافق مع معايير هيئة الحكومة الرقمية السعودية (DGA).',
    ),
    flow: ['Tenant', 'Cycle', 'Criteria', 'Evidence', 'Review', 'Reports → S3'],
    stateMachine: ['New', 'Assigned', 'Manager Review', 'Auditor Review', 'Closed'],
    aggregation: ['Criterion', 'Axis', 'Perspective', 'Department', 'Cycle'],
    highlights: [
      T(
        'State-machine-driven workflow engine governing each criterion’s lifecycle across measurement cycles.',
        'محرّك workflow مبني على state machine بيتحكم في دورة حياة كل معيار خلال دورات القياس.',
      ),
      T(
        'Automated result aggregation rolling up criterion → axis → perspective → department → cycle.',
        'تجميع آلي للنتايج من المعيار ← المحور ← المنظور ← الإدارة ← الدورة.',
      ),
      T(
        'Exportable PDF/Excel reports (DomPDF, Maatwebsite Excel) stored on AWS S3.',
        'تقارير PDF/Excel قابلة للتصدير (DomPDF و Maatwebsite Excel) متخزّنة على AWS S3.',
      ),
      T(
        'In-app + email notifications (SendGrid), inquiry/FAQ subsystem, and comprehensive audit logging.',
        'إشعارات داخل التطبيق + إيميل (SendGrid)، subsystem للاستفسارات والأسئلة الشائعة، و audit logging شامل.',
      ),
      T(
        'Tenant isolation with Stancl Tenancy and bilingual Arabic/English API responses.',
        'عزل الـ tenants بـ Stancl Tenancy وردود API ثنائية اللغة عربي/إنجليزي.',
      ),
    ],
    tech: [
      'Laravel 10',
      'MySQL',
      'Redis',
      'Horizon',
      'Passport (OAuth2)',
      'Stancl Tenancy',
      'AWS S3',
      'SendGrid',
      'DomPDF',
      'Maatwebsite Excel',
      'Spatie Permission',
      'Spatie Settings',
      'Spatie Activity Log',
      'Telescope',
    ],
  ),
  Project(
    title: T('XO — Multi-vendor Booking SaaS', 'XO — منصة SaaS حجوزات متعددة البائعين'),
    short: T(
      'Service booking, payments, and vendor management for many vendors on one platform.',
      'حجز خدمات ومدفوعات وإدارة بائعين لبائعين كتير على منصة واحدة.',
    ),
    company: 'Apps Bunches',
    cat: ProjectCat.saas,
    status: T('Production', 'في الإنتاج'),
    icon: Icons.storefront_rounded,
    concept: T(
      'Multi-vendor SaaS platform for service booking, payments, and vendor management — with RESTful APIs powering both the web dashboards and the white-label iOS/Android apps.',
      'منصة SaaS متعددة البائعين لحجز الخدمات والمدفوعات وإدارة البائعين — بـ RESTful APIs بتشغّل الـ web dashboards وتطبيقات iOS/Android بـ white-label.',
    ),
    flow: ['Customer App', 'REST API', 'Booking', 'Payments', 'Vendor Dashboard'],
    highlights: [
      T(
        'RESTful APIs serving web dashboards and white-label mobile apps from one backend.',
        'RESTful APIs بتخدّم الـ web dashboards وتطبيقات الموبايل الـ white-label من Backend واحد.',
      ),
      T('Service booking, payments, and vendor management flows.', 'Flows لحجز الخدمات والمدفوعات وإدارة البائعين.'),
      T('API contracts designed hand-in-hand with the mobile and frontend teams.', 'API contracts متصمّمة إيد بإيد مع فرق الموبايل والفرونت.'),
    ],
    tech: ['Laravel', 'MySQL', 'RESTful APIs', 'Passport', 'Firebase'],
  ),
  Project(
    title: T('Bugs Tracker', 'Bugs Tracker'),
    short: T('A complete issue-tracking system, built from scratch.', 'سيستم كامل لتتبّع الأخطاء، مبني من الصفر.'),
    company: 'IGS',
    cat: ProjectCat.enterprise,
    status: T('Delivered', 'تم التسليم'),
    icon: Icons.bug_report_rounded,
    concept: T(
      'A complete Bugs Tracker system developed from scratch at IGS — API-based, on a multi-tenant architecture, built with the Service–Repository pattern and SOLID principles.',
      'سيستم Bugs Tracker كامل اتطوّر من الصفر في IGS — مبني على APIs بمعمارية multi-tenant، وبـ Service–Repository pattern ومبادئ SOLID.',
    ),
    flow: ['Report', 'Triage', 'Assign', 'Fix', 'Verify'],
    highlights: [
      T('Designed and built end-to-end from scratch.', 'متصمّم ومتبني من الأول للآخر من الصفر.'),
      T('Multi-tenant, API-first architecture for data isolation.', 'معمارية API-first متعددة الـ tenants لعزل البيانات.'),
      T('Service–Repository layers and SOLID throughout.', 'طبقات Service–Repository و SOLID في كل حتة.'),
    ],
    tech: ['Laravel', 'MySQL', 'Multi-Tenancy', 'Service–Repository', 'PHPUnit'],
  ),
  Project(
    title: T('IGS Enterprise Suite', 'حزمة IGS للمؤسسات'),
    short: T(
      'Safety Hub, Safe Print, ERP System, and Fire Management — industrial-services backends.',
      'Safety Hub و Safe Print و ERP System و Fire Management — Backend لخدمات صناعية.',
    ),
    company: 'IGS',
    cat: ProjectCat.enterprise,
    status: T('Delivered', 'تم التسليم'),
    icon: Icons.factory_rounded,
    concept: T(
      'A family of API-based systems for Industrial General Services, built and maintained on a multi-tenant architecture — including ERDs designed for previously undocumented legacy systems.',
      'مجموعة سيستمات مبنية على APIs لشركة Industrial General Services، اتبنت واتصانت على معمارية multi-tenant — ومنها ERDs اتعملت لسيستمات legacy ماكانش ليها توثيق.',
    ),
    flow: ['Legacy System', 'ERD', 'Refactor', 'API', 'Frontend'],
    subProjects: ['Safety Hub', 'Safe Print', 'ERP System', 'Fire Management'],
    highlights: [
      T('Multi-tenant, API-based systems for scalability and data isolation.', 'سيستمات API متعددة الـ tenants عشان الـ scalability وعزل البيانات.'),
      T('Reverse-engineered ERDs for undocumented legacy systems.', 'عملت ERDs لسيستمات legacy مالهاش توثيق.'),
      T('APIs integrated with frontend teams for dynamic user experiences.', 'APIs متربطة مع فرق الفرونت لتجربة مستخدم ديناميكية.'),
      T('PHPUnit automated tests after specialized training.', 'اختبارات آلية بـ PHPUnit بعد تدريب متخصص.'),
    ],
    tech: ['Laravel', 'MySQL', 'Multi-Tenancy', 'ERD', 'PHPUnit', 'REST APIs'],
  ),
  Project(
    title: T('TaskHub', 'TaskHub'),
    short: T('Multi-tenant project & task management platform.', 'منصة multi-tenant لإدارة المشاريع والمهام.'),
    company: 'GitHub',
    cat: ProjectCat.openSource,
    status: T('Open Source', 'Open Source'),
    icon: Icons.task_alt_rounded,
    concept: T(
      'TaskHub is a multi-tenant project and task management platform built with Laravel.',
      'TaskHub منصة multi-tenant لإدارة المشاريع والمهام مبنية بـ Laravel.',
    ),
    flow: ['Tenant', 'Projects', 'Tasks', 'Members'],
    highlights: [T('Multi-tenant Laravel application with Blade UI.', 'تطبيق Laravel متعدد الـ tenants بواجهة Blade.')],
    tech: ['Laravel', 'Blade', 'Multi-Tenancy', 'MySQL'],
    repo: 'https://github.com/YoussefEhabElsrogi/TaskHub',
  ),
  Project(
    title: T('OrderPaymentAPI', 'OrderPaymentAPI'),
    short: T('Laravel API for managing orders and payments.', 'API بـ Laravel لإدارة الطلبات والمدفوعات.'),
    company: 'GitHub',
    cat: ProjectCat.openSource,
    status: T('Open Source', 'Open Source'),
    icon: Icons.receipt_long_rounded,
    concept: T('Laravel API project for managing orders and payments.', 'مشروع API بـ Laravel لإدارة الطلبات والمدفوعات.'),
    flow: ['Client', 'Orders API', 'Payments', 'DB'],
    highlights: [T('RESTful order & payment endpoints.', 'Endpoints بـ REST للطلبات والمدفوعات.')],
    tech: ['Laravel', 'PHP', 'REST API', 'MySQL'],
    repo: 'https://github.com/YoussefEhabElsrogi/OrderPaymentAPI',
  ),
  Project(
    title: T('Laravel Modular E-commerce', 'Laravel Modular E-commerce'),
    short: T('Modular e-commerce platform for scalable online stores.', 'منصة تجارة إلكترونية modular لمتاجر قابلة للتوسع.'),
    company: 'GitHub',
    cat: ProjectCat.openSource,
    status: T('Open Source', 'Open Source'),
    icon: Icons.widgets_rounded,
    concept: T(
      'Modular e-commerce platform built with Laravel for scalable and maintainable online stores.',
      'منصة تجارة إلكترونية modular مبنية بـ Laravel لمتاجر قابلة للتوسع وسهلة الصيانة.',
    ),
    flow: ['Catalog', 'Cart', 'Checkout', 'Orders'],
    highlights: [T('Module-per-domain structure for maintainability.', 'تقسيم modules حسب الـ domain عشان سهولة الصيانة.')],
    tech: ['Laravel', 'PHP', 'Modular Architecture', 'MySQL'],
    repo: 'https://github.com/YoussefEhabElsrogi/Laravel-Modular-Ecommerce',
  ),
  Project(
    title: T('AI Chat Module', 'AI Chat Module'),
    short: T('Laravel + Blade chat module integrated with the OpenAI API.', 'Chat module بـ Laravel + Blade متكامل مع OpenAI API.'),
    company: 'GitHub',
    cat: ProjectCat.openSource,
    status: T('Open Source', 'Open Source'),
    icon: Icons.smart_toy_rounded,
    concept: T(
      'A simple chat module built with Laravel and Blade, integrated with the OpenAI API.',
      'Chat module بسيط مبني بـ Laravel و Blade ومتكامل مع OpenAI API.',
    ),
    flow: ['User', 'Laravel', 'OpenAI API', 'Reply'],
    highlights: [T('Laravel ↔ OpenAI API integration.', 'تكامل Laravel ↔ OpenAI API.')],
    tech: ['Laravel', 'Blade', 'JavaScript', 'OpenAI API'],
    repo: 'https://github.com/YoussefEhabElsrogi/chat-module',
  ),
];

// ─────────────────────────── Education ───────────────────────────

class EduItem {
  const EduItem(this.icon, this.title, this.place, this.date, this.badge);
  final IconData icon;
  final T title;
  final T place;
  final T date;
  final T badge;
}

const education = [
  EduItem(
    Icons.school_rounded,
    T("Bachelor's Degree in Computer Science", 'بكالوريوس علوم الحاسب'),
    T('Zagazig University — Zagazig, Egypt', 'جامعة الزقازيق — الزقازيق، مصر'),
    T('Oct 2025 – Aug 2029 · In progress', 'أكتوبر 2025 – أغسطس 2029 · جاري'),
    T('DEGREE', 'شهادة'),
  ),
  EduItem(
    Icons.workspace_premium_rounded,
    T('Backend Diploma', 'دبلومة Backend'),
    T('Nasr City, Cairo', 'مدينة نصر، القاهرة'),
    T('Jul 2024', 'يوليو 2024'),
    T('CERT', 'شهادة'),
  ),
];
