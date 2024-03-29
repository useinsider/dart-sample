# Insider Dart Sample App <img src="https://github.com/github/explore/raw/main/topics/dart/dart.png" alt="dart" width="35" height="35"/>
For more information about flutter integration please check the [link](https://academy.useinsider.com/docs/flutter-integration)

Check the changelogs 👉 [here](https://academy.useinsider.com/docs/flutter-changelogs)

## Before getting the build:

Common:
1. Change the partner name with yours in the [main.dart](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/lib/main.dart#L33)

Android:

1. Add your partner name to manifestPlaceholders in the module-level [build.gradle](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/android/app/build.gradle#L40) file
2. Change the google-service.json file with yours
3. Change the agconnect-services.json file with yours(if you are using huawei messaging service)
4. Replace the [applicationId](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/android/app/build.gradle#L37) with the one in your google-service.json file 

iOS:

1. Choose your team from the Xcode's Signing & Capabilities tab, under the Signing section
2. Repeat the first step for all targets(InsiderDemo, InsiderNotificationContent, NotificationService)
3. Change bundle identifier with yours and select desired App Group
4. Repeat the previous step for all targets(InsiderDemo, InsiderNotificationContent, NotificationService)
5. Change the App Groups for [NotificationService.m](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/ios/InsiderNotificationService/NotificationService.m#L22) and [NotificationViewController.m](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/ios/InsiderNotificationContent/NotificationViewController.m#L19) files
6. Change the App Group in the [main.dart](https://github.com/useinsider/dart-sample/blob/master/InsiderDemo/lib/main.dart#L33) file
7. Change the partner name for the URL Types, URL Schemes section(InsiderDemo) 
