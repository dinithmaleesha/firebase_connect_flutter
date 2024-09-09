# Firebase Connect Flutter

## Introduction

This project demonstrates how to connect a Flutter app with Firebase. Follow the instructions below to set up your environment and integrate Firebase into your Flutter application.

## Prerequisites

1. **Java SDK Configuration**:
   - Open Android Studio.
   - Navigate to `File -> Project Structure`.
   - Under `Project`, set the `SDK` to Java 22.
   - Set the `Language level` to `SDK default`.
   - Under `Modules`, select `Module SDK` and set it to `Project SDK 22`.
   - Click `Apply` and then `OK`.

2. **Register Your App on Firebase**:
   - Go to the [Firebase Console](https://console.firebase.google.com/).
   - Create a new project or use an existing one.
   - Follow the instructions to register your app and download the configuration files (`google-services.json` for Android).

## Project Configuration

### Android Gradle Configuration

1. **Update `app/build.gradle`**:

   ```groovy
   plugins {
     id "com.android.application"
     // START: FlutterFire Configuration
     id 'com.google.gms.google-services'
     // END: FlutterFire Configuration
     id "kotlin-android"
     // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
     id "dev.flutter.flutter-gradle-plugin"
   }

   def localProperties = new Properties()
   def localPropertiesFile = rootProject.file("local.properties")
   if (localPropertiesFile.exists()) {
     localPropertiesFile.withReader("UTF-8") { reader ->
       localProperties.load(reader)
     }
   }

   def flutterVersionCode = localProperties.getProperty("flutter.versionCode")
   if (flutterVersionCode == null) {
     flutterVersionCode = "1"
   }

   def flutterVersionName = localProperties.getProperty("flutter.versionName")
   if (flutterVersionName == null) {
     flutterVersionName = "1.0"
   }

   android {
     namespace = "com.example.firebase_connect_flutter"
     compileSdk = flutter.compileSdkVersion
     ndkVersion = flutter.ndkVersion

     compileOptions {
       sourceCompatibility = JavaVersion.VERSION_1_8
       targetCompatibility = JavaVersion.VERSION_1_8
     }

     defaultConfig {
       // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
       applicationId = "com.example.firebase_connect_flutter"
       // You can update the following values to match your application needs.
       // For more information, see: https://docs.flutter.dev/deployment/android#reviewing-the-gradle-build-configuration.
       minSdk = flutter.minSdkVersion
       targetSdk = flutter.targetSdkVersion
       versionCode = flutterVersionCode.toInteger()
       versionName = flutterVersionName
     }

     buildTypes {
       release {
         // TODO: Add your own signing config for the release build.
         // Signing with the debug keys for now, so `flutter run --release` works.
         signingConfig = signingConfigs.debug
       }
     }
   }

   flutter {
     source = "../.."
   }

   dependencies {
     // Import the Firebase BoM
     implementation platform('com.google.firebase:firebase-bom:33.2.0')

     // TODO: Add the dependencies for Firebase products you want to use
     // When using the BoM, don't specify versions in Firebase dependencies
     implementation 'com.google.firebase:firebase-analytics'

     // Add the dependencies for any other desired Firebase products
     // https://firebase.google.com/docs/android/setup#available-libraries
   }
2. **Update `settings.gradle`**:

   ```groovy
     pluginManagement {
      def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
      }
      settings.ext.flutterSdkPath = flutterSdkPath()
    
      includeBuild("${settings.ext.flutterSdkPath}/packages/flutter_tools/gradle")
    
      repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
      }
    }
    
    plugins {
      id "dev.flutter.flutter-plugin-loader" version "1.0.0"
      id "com.android.application" version "7.3.0" apply false
      id "org.jetbrains.kotlin.android" version "1.9.20" apply false
      id "com.google.gms.google-services" version "4.3.15" apply false
      id "com.google.firebase.firebase-perf" version "1.4.1" apply false
      id "com.google.firebase.crashlytics" version "2.8.1" apply false
    }
    
    include ":app"
  
### Flutter Dependency
**Add the following dependency to your `pubspec.yaml`**:
```yaml
dependencies:
  firebase_core: ^3.4.0
