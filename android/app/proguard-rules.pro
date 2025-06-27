# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Supabase rules
-keep class io.supabase.** { *; }
-keep class com.supabase.** { *; }

# Camera plugin rules
-keep class io.flutter.plugins.camera.** { *; }

# Image picker rules
-keep class io.flutter.plugins.imagepicker.** { *; }

# Path provider rules
-keep class io.flutter.plugins.pathprovider.** { *; }

# Shared preferences rules
-keep class io.flutter.plugins.sharedpreferences.** { *; }

# URL launcher rules
-keep class io.flutter.plugins.urllauncher.** { *; }

# Flutter map rules
-keep class com.apptreesoftware.mapview.** { *; }

# Lottie rules
-keep class com.airbnb.lottie.** { *; }

# Google Play Core rules
-keep class com.google.android.play.** { *; }
-dontwarn com.google.android.play.** 