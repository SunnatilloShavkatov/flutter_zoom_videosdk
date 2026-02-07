plugins {
    id("com.android.library")
    kotlin("android")
}


group = "com.flutterzoom.videosdk"
version = "1.0"

buildscript {
    val kotlinVersion by extra("2.2.20")
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:8.13.0")
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlinVersion")
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

android {
    namespace = "uz.englify.platform_methods"
    compileSdk = 36

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlin {
        compilerOptions {
            jvmTarget.set(org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17)
        }
    }

    sourceSets["main"].java.srcDirs("src/main/kotlin")
    sourceSets["test"].java.srcDirs("src/test/kotlin")

    defaultConfig {
        minSdk = 28
    }

    android {
        testOptions {
            unitTests.all {
                it.useJUnitPlatform()
                it.testLogging.events("passed", "skipped", "failed", "standardOut", "standardError")
                it.testLogging.showStandardStreams = true
                it.outputs.upToDateWhen { false }
            }
        }
    }
}

dependencies {
    implementation("com.google.code.gson:gson:2.10.1")
    implementation("androidx.security:security-crypto:1.1.0-alpha06")
    implementation("com.google.crypto.tink:tink-android:1.8.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("us.zoom.videosdk:zoomvideosdk-core:2.4.0")
    implementation("us.zoom.videosdk:zoomvideosdk-videoeffects:2.4.0")
    implementation("us.zoom.videosdk:zoomvideosdk-annotation:2.4.0")
    implementation("us.zoom.videosdk:zoomvideosdk-whiteboard:2.4.0")
    implementation("us.zoom.videosdk:zoomvideosdk-broadcast-streaming:2.4.0")
}
