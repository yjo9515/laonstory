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

-keep interface com.laonstory.linenseoul.linenseoul.interfaces.I** { *; }
-keep class com.laonstory.linenseoul.linenseoul.UHFReader {*; }
-keep class com.laonstory.linenseoul.linenseoul.entity.SelectEntity {*; }
-keep class com.laonstory.linenseoul.linenseoul.entity.UHFReaderResult {*; }
-keep class com.laonstory.linenseoul.linenseoul.entity.UHFTagEntity {*; }
-keep class com.laonstory.linenseoul.linenseoul.entity.UHFVersionInfo {*; }
-keep class com.laonstory.linenseoul.linenseoul.entity.UHFReaderResult$*{
    <fields>;
    <methods>;
 }

# 枚举类不能被混淆
-keep enum com.laonstory.linenseoul.linenseoul.enums.LockMembankEnum{*;}
-keep enum com.laonstory.linenseoul.linenseoul.enums.InventoryModeForPower{*;}
-keep enum com.laonstory.linenseoul.linenseoul.enums.LockActionEnum{*;}
-keep enum com.laonstory.linenseoul.linenseoul.enums.LockMembankEnum{*;}
-keep enum com.laonstory.linenseoul.linenseoul.enums.UHFSession{*;}
-keep interface com.laonstory.linenseoul.linenseoul.interfaces.OnInventoryDataListener{*;}


# 保留所有的本地native方法不被混淆
-keepclasseswithmembernames class * {
    native <methods>;
}
