# ProGuard / R8 rules for SpendWise

# Flutter
-keep class io.flutter.** { *; }
-dontwarn com.google.android.play.core.**

# Suppress missing optional language scripts in google_mlkit_text_recognition
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
-dontwarn com.google.mlkit.vision.text.**

# Keep ML Kit components & internal dependency injection
-keep class com.google.mlkit.** { *; }
-keep interface com.google.mlkit.** { *; }
-dontwarn com.google.mlkit.**

# Keep Google Play Services & Firebase components used by ML Kit
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Keep Google ML Kit Text Recognition Plugin
-keep class com.google_mlkit_text_recognition.** { *; }

# Keep UCrop / Image Cropper
-keep class com.yalantis.ucrop.** { *; }
-dontwarn com.yalantis.ucrop.**

# Keep SQLite
-keep class com.tekartik.sqflite.** { *; }

