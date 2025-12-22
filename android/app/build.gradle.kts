import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")

}

android {
    namespace = "com.maydon"
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
       jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.maydon"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 1
        versionName = "1.0.0"
    }

    // Load keystore properties
    val keystorePropertiesFile = rootProject.file("key.properties")
    val keystoreProperties = Properties()
    if (keystorePropertiesFile.exists()) {
        FileInputStream(keystorePropertiesFile).use { 
            keystoreProperties.load(it) 
        }
    }

    signingConfigs {
        create("release") {
            val storeFileValue = keystoreProperties["storeFile"] as String?
            if (storeFileValue != null) {
                // Путь к keystore относительно android/ директории
                val keystoreFile = rootProject.file(storeFileValue)
                println("Keystore path: ${keystoreFile.absolutePath}")
                println("Keystore exists: ${keystoreFile.exists()}")
                if (keystoreFile.exists()) {
                    keyAlias = keystoreProperties["keyAlias"] as String?
                    keyPassword = keystoreProperties["keyPassword"] as String?
                    storeFile = keystoreFile
                    storePassword = keystoreProperties["storePassword"] as String?
                    println("Signing config configured successfully")
                } else {
                    println("ERROR: Keystore file not found at ${keystoreFile.absolutePath}")
                }
            } else {
                println("ERROR: storeFile not found in key.properties")
            }
        }
    }

    buildTypes {
        release {
            val releaseSigning = signingConfigs.findByName("release")
            if (releaseSigning?.storeFile != null && releaseSigning.storeFile!!.exists()) {
                signingConfig = releaseSigning
                println("Release build type: Using signing config")
            } else {
                println("WARNING: Release build type: No signing config available")
            }
        }
    }

}
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    implementation(platform("com.google.firebase:firebase-bom:33.1.2"))
    implementation("com.google.firebase:firebase-messaging")
}

flutter {
    source = "../.."
}
