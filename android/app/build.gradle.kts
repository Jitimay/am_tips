plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "app.amtips"
    compileSdk = 37
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "app.amtips"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // Release signing — reads keystore from environment variables.
            // Set these before building:
            //   export KEY_STORE_PATH=/path/to/amtips.keystore
            //   export KEY_ALIAS=amtips
            //   export KEY_PASSWORD=yourpassword
            //   export STORE_PASSWORD=yourstorepassword
            val keystorePath = System.getenv("KEY_STORE_PATH")
            if (keystorePath != null) {
                signingConfig = signingConfigs.create("release").apply {
                    storeFile = file(keystorePath)
                    storePassword = System.getenv("STORE_PASSWORD") ?: ""
                    keyAlias = System.getenv("KEY_ALIAS") ?: "amtips"
                    keyPassword = System.getenv("KEY_PASSWORD") ?: ""
                }
            } else {
                // Fallback to debug keys for local testing only
                signingConfig = signingConfigs.getByName("debug")
            }
        }
        debug {
            isDebuggable = true
        }
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
