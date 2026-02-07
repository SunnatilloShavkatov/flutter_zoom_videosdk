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
        classpath("com.android.tools.build:gradle:8.13.2")
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
    implementation("com.google.code.gson:gson:2.13.2")
    implementation("us.zoom.videosdk:zoomvideosdk-core:2.4.12")
}
