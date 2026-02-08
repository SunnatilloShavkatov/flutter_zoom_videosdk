import org.gradle.api.tasks.Delete

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = file("../build")
subprojects {
    project.buildDir = file("${rootProject.buildDir}/${project.name}")
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.buildDir)
}

tasks.register("resolveVerificationExtras") {
    doLast {
        configurations
            .detachedConfiguration(
                dependencies.create("org.jetbrains.kotlin:kotlin-stdlib:1.8.20"),
                dependencies.create("org.jetbrains.kotlin:kotlin-reflect:1.8.20"),
                dependencies.create("org.jetbrains.kotlin:kotlin-stdlib-common:1.8.20"),
                dependencies.create("com.android.tools.build:aapt2:8.2.2-10154469")
            )
            .resolve()
    }
}
