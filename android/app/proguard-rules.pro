# ============================================================================
# amTips — ProGuard / R8 Rules
# ============================================================================

# ── Flutter / Dart ────────────────────────────────────────────────────────────
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.**

# ── Firebase ──────────────────────────────────────────────────────────────────
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Auth — keep token models
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.firebase.auth.** { *; }

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# ── Supabase / OkHttp / Ktor ──────────────────────────────────────────────────
-keep class io.github.jan.supabase.** { *; }
-dontwarn io.github.jan.supabase.**
-keep class io.ktor.** { *; }
-dontwarn io.ktor.**
-keep class okhttp3.** { *; }
-dontwarn okhttp3.**
-keep class okio.** { *; }
-dontwarn okio.**

# ── Dio ───────────────────────────────────────────────────────────────────────
-keep class com.squareup.okhttp3.** { *; }
-dontwarn com.squareup.okhttp3.**

# ── Gson / JSON serialization ─────────────────────────────────────────────────
-keepattributes Signature
-keepattributes EnclosingMethod
-keep class sun.misc.Unsafe { *; }
-keep class com.google.gson.** { *; }
-dontwarn com.google.gson.**

# ── Freezed / json_serializable generated code ────────────────────────────────
# Dart code is compiled to native — no JVM reflection. These rules are
# for Android-side Java/Kotlin plugins that Freezed may depend on.
-keep class * implements java.io.Serializable { *; }

# ── flutter_secure_storage ────────────────────────────────────────────────────
-keep class com.it_nomads.fluttersecurestorage.** { *; }
-dontwarn com.it_nomads.fluttersecurestorage.**

# ── mobile_scanner ────────────────────────────────────────────────────────────
-keep class dev.steenbakker.mobile_scanner.** { *; }
-dontwarn dev.steenbakker.mobile_scanner.**

# ── flutter_local_notifications ───────────────────────────────────────────────
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**

# ── Kotlin metadata (required for Kotlin reflection) ─────────────────────────
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**
-keep class kotlinx.** { *; }
-dontwarn kotlinx.**

# ── General Android ───────────────────────────────────────────────────────────
-keepattributes SourceFile,LineNumberTable
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
