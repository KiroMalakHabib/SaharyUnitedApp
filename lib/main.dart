import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sahary_united_company_for_powers/constants/texts.dart';
import 'package:sahary_united_company_for_powers/providers/text_size.dart';
import 'package:sahary_united_company_for_powers/providers/language_provider.dart';
import 'package:sahary_united_company_for_powers/routes.dart';
import 'package:sahary_united_company_for_powers/services/navigator_service.dart';
import 'package:sahary_united_company_for_powers/services/toast_initializer_service.dart';
import 'package:sahary_united_company_for_powers/theme/app_theme.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await FastCachedImageConfig.init(
    subDir: 'fast_cached',
  );
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final textScaleMultiplier = ref.watch(textSizeProvider);
    final locale = ref.watch(languageProvider);
    
    // Update the Texts class with current language
    Texts.setLanguage(locale.languageCode);
    
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      locale: locale,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      title: Texts.appName,
      navigatorKey: appNavigatorKey,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(textScaleMultiplier)),
          child: Directionality(
            textDirection: locale.languageCode == 'ar' 
              ? TextDirection.rtl 
              : TextDirection.ltr,
            child: Overlay(
              initialEntries: [
                OverlayEntry(
                  builder: (context) {
                    return ToastInitializer(child: child!);
                  },
                ),
              ],
            ),
          ),
        );
      },
      theme: appTheme(),
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.onBoarding,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}