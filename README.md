# مسبحتي — Flutter Android

تطبيق تسبيح عربي بواجهة زمردية، مع نمط نهاري وليلي قابل للاختيار والحفظ محليًا.

## المتطلبات
- Flutter 3.47.9 (حسب إعداد GitHub Actions)
- Java 17
- Android SDK 36
- Gradle 8.14.3

## البناء محليًا
```bash
flutter pub get
flutter build apk --release
```

ملف APK الناتج:
`build/app/outputs/flutter-apk/app-release.apk`

## البناء عبر GitHub Actions
ارفع محتويات هذا المجلد إلى جذر المستودع، مع الإبقاء على `.github/workflows/build-apk.yml` و`android/`. يبدأ البناء عند push إلى `main` أو `master`، ويمكن تشغيله يدويًا من تبويب Actions.

لا يشغّل Workflow أوامر `flutter analyze` أو `flutter test`؛ ينفّذ استرجاع الاعتماديات ثم بناء APK Release فقط.

## ملاحظات
- مجلد `android/` مضمّن مسبقًا ولا يتم إنشاؤه أثناء CI.
- مجلد `assets/images/` مسجل في `pubspec.yaml`.
- لم يتم التحقق من البناء الفعلي داخل بيئة الإنشاء الحالية لعدم توفر Flutter SDK فيها. عند فشل GitHub Actions، أرسل سجل خطوة `Build release APK` كاملًا لتحديد أخطاء Dart الفعلية بدقة.
