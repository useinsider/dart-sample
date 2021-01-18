# 2.1.1+nh

`nh` stands for non-huawei.

Same as 2.1.0 without any Huawei dependencies and services.

# 2.1.1

Android native SDK version has been set to 11.6.1.

# 2.1.0+nh

`nh` stands for non-huawei.

Same as 2.1.0 without any Huawei dependencies and services.

**In your `pubspec.yaml` file, please remove `^` for flutter_insider.**

```rb
flutter_insider: 2.1.0+nh
```

# 2.1.0

Google policy update adaptation.

**In your `pubspec.yaml` file, please remove `^` for flutter_insider.**

```rb
flutter_insider: 2.1.0
```

## Removed

- Amplification has been removed.

```dart
    Future<void> getAutoStartPermission(List<int> vendors) async
```

- Rule has been removed from proguard.

```rb
    -keep class com.useinsider.insider.Vendor { *; }
```

- `Vendors.dart` has been removed.

## Changed

- Minimum SDK version for Android SDK has been changed from 19

```rb
    minSdkVersion 17
```

- Compile SDK version for Android has been changed from 29 to

```rb
    compileSdkVersion 30
```

- Native Android SDK version has been changed from 11.3.0 to

```rb
    implementation ('com.useinsider:insider:11.6.0')
```

- Native iOS SDK version has been changed from 10.6.0 to

```rb
    s.dependency 'InsiderMobile', '10.7.0'
```

- Huawei dependency versions has been updated in build.gradle.

```rb
    implementation 'com.huawei.hms:push:5.0.4.302'
    implementation 'com.huawei.hms:ads-identifier:3.4.34.301'
    implementation 'com.huawei.hms:location:4.0.4.300'
```

- `insiderIDResult` has been added to `login` method as an option.

```dart
     Future login(FlutterInsiderIdentifiers identifiers, {Function insiderIDResult}) async
```

- `String language` parameter has been renamed to `String locale`.

```dart
    Future<Map> getSmartRecommendation(int recommendationID, String locale, String currency) async
```

```dart
    Future<Map> getSmartRecommendationWithProduct(FlutterInsiderProduct product, int recommendationID, String locale) async
```

# 2.0.0

### Removed

- Following methods has been removed form `FlutterInsiderUser`.

```dart
    Future<FlutterInsiderUser> setEmail(String email) async
```

```dart
    Future<FlutterInsiderUser> setPhoneNumber(String phoneNumber) async
```

### Added

- HMS dependencies has been addded to `build.gradle`.

```rb
    implementation 'com.huawei.hms:push:4.0.2.300'
    implementation 'com.huawei.hms:ads-identifier:3.4.28.305'
    implementation 'com.huawei.hms:location:4.0.1.300'
```

You need to have following integrations in your project level build.gradle file.

- `maven { url "http://developer.huawei.com/repo/"}` under the buildscript.
- `classpath 'com.huawei.agconnect:agcp:1.4.2.300'` under the dependencies.
- `maven {url "http://developer.huawei.com/repo/"}` under the all projects.

A full example can be found here:

```rb
buildscript {
    repositories {
        google()
        jcenter()
        maven { url "https://developer.huawei.com/repo/"}
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:3.6.1'
        classpath 'com.google.gms:google-services:4.3.4'
        classpath 'com.huawei.agconnect:agcp:1.4.2.300'

    }
}

allprojects {
    repositories {
        google()
        jcenter()
        maven {url "https://mobilesdk.useinsider.com/android"}
        maven {url "https://developer.huawei.com/repo/"}
    }

}

rootProject.buildDir = '../build'
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}
subprojects {
    project.evaluationDependsOn(':app')
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

You need to have `agconnect-services.json` under your app folder.

You need to have following integrations in your module level build.gradle.

- `apply plugin: 'com.huawei.agconnect'` in the main level.
- `minSdkVersion` must be 19 or higher.

---

- IDFA collection has been disabled by default. Optional method has been added to `FlutterInsider`.

```dart
    Future<void> enableIDFACollection(bool enableIDFACollection) async
```

- Smart Recommendation logging has been added to `FlutterInsider`.

```dart
    Future<void> clickSmartRecommendationProduct(int recommendationID, FlutterInsiderProduct product) async
```

- Custom identifier setting with key value pair has been added to `FlutterInsiderIdentifiers`.

```dart
    Future<FlutterInsiderIdentifiers> addCustomIdentifier(String key, String value) async
```

- Locale attribute has been added to `FlutterInsiderUser`.

```dart
    Future<FlutterInsiderUser> setLocale(String locale) async
```

### Changed

- SDK url has been changed from `https://mobile.useinsider.com` to `https://mobilesdk.useinsider.com/android`.

You need to update your build.gradle

```rb
    maven { url "https://mobilesdk.useinsider.com/android" }
```

- Minimum SDK version for Android SDK has been changed from 16

```rb
    minSdkVersion 19
```

- Compile SDK version for Android has been changed from 28 to

```rb
    compileSdkVersion 29
```

- Native Android SDK version has been changed from 10.3.0 to

```rb
    implementation ('com.useinsider:insider:11.3.0')
```

- Native iOS SDK version has been changed from 10.4.0 to

```rb
    s.dependency 'InsiderMobile', '10.6.0'
```
