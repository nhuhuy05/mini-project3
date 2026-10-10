# ProGuard / R8 rules for SpendWise

# Suppress missing optional language scripts in google_mlkit_text_recognition
-dontwarn com.google.mlkit.vision.text.chinese.**
-dontwarn com.google.mlkit.vision.text.devanagari.**
-dontwarn com.google.mlkit.vision.text.japanese.**
-dontwarn com.google.mlkit.vision.text.korean.**
-dontwarn com.google.mlkit.vision.text.**

# Keep ML Kit Text Recognition classes
-keep class com.google.mlkit.vision.text.** { *; }
-keep interface com.google.mlkit.vision.text.** { *; }
-keep class com.google_mlkit_text_recognition.** { *; }
