plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")

}

android {
    ndkVersion = "29.0.13113456"
    namespace = "com.example.untitled1"
    compileSdk = 35
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        minSdk = 23
        targetSdk = 33
        applicationId = "com.example.untitled1"
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
dependencies{
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
    implementation("com.google.firebase:firebase-analytics")
        // Import the BoM for the Firebase platform
        implementation(platform("com.google.firebase:firebase-bom:33.12.0"))

        // Add the dependency for the Firebase Authentication library
        // When using the BoM, you don't specify versions in Firebase library dependencies
        implementation("com.google.firebase:firebase-auth")
    }
