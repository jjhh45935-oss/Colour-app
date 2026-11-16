#!/bin/bash
set -e

mkdir -p app/src/main/res/drawable
mkdir -p app/src/main/res/values
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/java/com/color/studio

cat << 'EOF' > settings.gradle
pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}
dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}
rootProject.name = "ColorStudioApp"
include ':app'
EOF

cat << 'EOF' > build.gradle
plugins {
    id 'com.android.application' version '8.9.1' apply false
}
EOF

cat << 'EOF' > gradle.properties
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.enableJetifier=false
EOF

cat << 'EOF' > app/build.gradle
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.color.studio'
    compileSdk 35

    defaultConfig {
        applicationId "com.color.studio"
        minSdk 24
        targetSdk 35
        versionCode 1
        versionName "1.0"
    }

    buildTypes {
        release {
            minifyEnabled false
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.7.0'
    implementation 'com.google.android.material:material:1.12.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.2.0'
    implementation 'androidx.recyclerview:recyclerview:1.3.2'
}
EOF

cat << 'EOF' > app/src/main/AndroidManifest.xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">

    <application
        android:allowBackup="true"
        android:icon="@drawable/ic_color_logo"
        android:label="@string/app_name"
        android:roundIcon="@drawable/ic_color_logo"
        android:supportsRtl="true"
        android:theme="@style/Theme.ColorStudio">

        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>

        <activity
            android:name=".ColorDetailActivity"
            android:exported="false" />

    </application>
</manifest>
EOF

cat << 'EOF' > app/src/main/res/drawable/ic_color_logo.xml
<vector xmlns:android="http://schemas.android.com/apk/res/android"
    android:width="108dp"
    android:height="108dp"
    android:viewportWidth="24"
    android:viewportHeight="24">
    <path
        android:fillColor="#1E293B"
        android:pathData="M12,2A10,10 0 1,0 22,12A10,10 0 0,0 12,2Z" />
    <path
        android:fillColor="#38BDF8"
        android:pathData="M12,4A8,8 0 0,1 20,12H12V4Z" />
    <path
        android:fillColor="#F43F5E"
        android:pathData="M12,12H20A8,8 0 0,1 12,20V12Z" />
    <path
        android:fillColor="#10B981"
        android:pathData="M4,12H12V20A8,8 0 0,1 4,12Z" />
    <path
        android:fillColor="#F59E0B"
        android:pathData="M12,4V12H4A8,8 0 0,1 12,4Z" />
</vector>
EOF

cat << 'EOF' > app/src/main/res/values/colors.xml
<?xml version="1.0" encoding="utf-8"?>
<resources>
    <color name="primary">#0F172A</color>
    <color name="primary_dark">#020617</color>
    <color name="accent">#6366F1</color>
    <color name="bg_light">#F1F5F9</color>
    <color name="white">#FFFFFF</color>
    <color name="text_dark">#0F172A</color>
    <color name="text_gray">#64748B</color>
</resources>
EOF

cat << 'EOF' > app/src/main/res/values/strings.xml
<resources>
    <string name="app_name">Pro Color Studio 500</string>
</resources>
EOF

cat << 'EOF' > app/src/main/res/values/themes.xml
<resources>
    <style name="Theme.ColorStudio" parent="Theme.MaterialComponents.DayNight.NoActionBar">
        <item name="colorPrimary">@color/accent</item>
        <item name="colorPrimaryVariant">@color/primary_dark</item>
        <item name="colorOnPrimary">@color/white</item>
        <item name="android:statusBarColor">@color/primary_dark</item>
    </style>
</resources>
EOF

cat << 'EOF' > app/src/main/res/layout/activity_main.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/bg_light"
    android:orientation="vertical">

    <!-- Top Header -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@color/primary"
        android:orientation="vertical"
        android:paddingHorizontal="14dp"
        android:paddingTop="14dp"
        android:paddingBottom="10dp">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:gravity="center_vertical"
            android:orientation="horizontal">

            <TextView
                android:layout_width="0dp"
                android:layout_height="wrap_content"
                android:layout_weight="1"
                android:text="Pro Color Studio"
                android:textColor="@color/white"
                android:textSize="20sp"
                android:textStyle="bold" />

            <TextView
                android:id="@+id/tvCount"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="500 Colors"
                android:textColor="#94A3B8"
                android:textSize="13sp"
                android:textStyle="bold" />
        </LinearLayout>

        <EditText
            android:id="@+id/etSearch"
            android:layout_width="match_parent"
            android:layout_height="42dp"
            android:layout_marginTop="10dp"
            android:background="@drawable/bg_search"
            android:hint="Search color name, hex, 3D, 4D, Soft..."
            android:inputType="text"
            android:paddingHorizontal="14dp"
            android:textColor="@color/text_dark"
            android:textColorHint="@color/text_gray"
            android:textSize="13sp" />

        <HorizontalScrollView
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:layout_marginTop="8dp"
            android:scrollbars="none">

            <LinearLayout
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:orientation="horizontal">

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCatAll"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:layout_marginEnd="6dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="All (500)"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCatAccounting"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:layout_marginEnd="6dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="Accounting"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCatSoft"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:layout_marginEnd="6dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="Soft"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCatPremium"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:layout_marginEnd="6dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="Premium"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCat3D"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:layout_marginEnd="6dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="3D"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />

                <com.google.android.material.button.MaterialButton
                    android:id="@+id/btnCat4D"
                    style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                    android:layout_width="wrap_content"
                    android:layout_height="36dp"
                    android:insetTop="0dp"
                    android:insetBottom="0dp"
                    android:text="4D"
                    android:textAllCaps="false"
                    android:textSize="12sp"
                    app:cornerRadius="18dp" />
            </LinearLayout>
        </HorizontalScrollView>
    </LinearLayout>

    <androidx.recyclerview.widget.RecyclerView
        android:id="@+id/rvColors"
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1"
        android:clipToPadding="false"
        android:padding="6dp" />

</LinearLayout>
EOF

cat << 'EOF' > app/src/main/res/drawable/bg_search.xml
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <solid android:color="#FFFFFF" />
    <corners android:radius="10dp" />
</shape>
EOF

cat << 'EOF' > app/src/main/res/layout/item_color_grid.xml
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_margin="5dp"
    app:cardCornerRadius="12dp"
    app:cardElevation="3dp">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical">

        <FrameLayout
            android:layout_width="match_parent"
            android:layout_height="88dp">

            <View
                android:id="@+id/viewColorBox"
                android:layout_width="match_parent"
                android:layout_height="match_parent" />

            <TextView
                android:id="@+id/tvBadge"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_gravity="top|end"
                android:layout_margin="5dp"
                android:background="#66000000"
                android:paddingHorizontal="5dp"
                android:paddingVertical="2dp"
                android:text="3D"
                android:textColor="@color/white"
                android:textSize="9sp"
                android:textStyle="bold" />
        </FrameLayout>

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:background="@color/white"
            android:orientation="vertical"
            android:paddingHorizontal="7dp"
            android:paddingVertical="6dp">

            <TextView
                android:id="@+id/tvColorName"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:ellipsize="end"
                android:maxLines="1"
                android:text="Trust Navy"
                android:textColor="@color/text_dark"
                android:textSize="11.5sp"
                android:textStyle="bold" />

            <TextView
                android:id="@+id/tvColorHex"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:layout_marginTop="1dp"
                android:text="#1E40AF"
                android:textColor="@color/text_gray"
                android:textSize="10sp" />
        </LinearLayout>
    </LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat << 'EOF' > app/src/main/res/layout/activity_color_detail.xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@color/bg_light"
    android:orientation="vertical">

    <!-- Toolbar -->
    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:background="@color/primary"
        android:gravity="center_vertical"
        android:orientation="horizontal"
        android:padding="12dp">

        <com.google.android.material.button.MaterialButton
            android:id="@+id/btnBack"
            style="@style/Widget.MaterialComponents.Button.TextButton"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="← Back"
            android:textAllCaps="false"
            android:textColor="@color/white" />

        <TextView
            android:id="@+id/tvDetailTitle"
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_weight="1"
            android:ellipsize="end"
            android:maxLines="1"
            android:text="Color Versions"
            android:textColor="@color/white"
            android:textSize="18sp"
            android:textStyle="bold" />
    </LinearLayout>

    <ScrollView
        android:layout_width="match_parent"
        android:layout_height="0dp"
        android:layout_weight="1">

        <LinearLayout
            android:layout_width="match_parent"
            android:layout_height="wrap_content"
            android:orientation="vertical"
            android:padding="14dp">

            <!-- Hero Preview Card -->
            <com.google.android.material.card.MaterialCardView
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                app:cardCornerRadius="16dp"
                app:cardElevation="4dp">

                <LinearLayout
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:orientation="vertical">

                    <View
                        android:id="@+id/viewHeroColor"
                        android:layout_width="match_parent"
                        android:layout_height="120dp" />

                    <LinearLayout
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:orientation="vertical"
                        android:padding="14dp">

                        <TextView
                            android:id="@+id/tvHeroName"
                            android:layout_width="wrap_content"
                            android:layout_height="wrap_content"
                            android:text="Color Name"
                            android:textColor="@color/text_dark"
                            android:textSize="20sp"
                            android:textStyle="bold" />

                        <TextView
                            android:id="@+id/tvHeroCodes"
                            android:layout_width="wrap_content"
                            android:layout_height="wrap_content"
                            android:layout_marginTop="4dp"
                            android:text="HEX: #000000 | RGB: 0, 0, 0"
                            android:textColor="@color/text_gray"
                            android:textSize="13sp" />

                        <LinearLayout
                            android:layout_width="match_parent"
                            android:layout_height="wrap_content"
                            android:layout_marginTop="10dp"
                            android:orientation="horizontal">

                            <com.google.android.material.button.MaterialButton
                                android:id="@+id/btnCopyHex"
                                android:layout_width="0dp"
                                android:layout_height="40dp"
                                android:layout_marginEnd="6dp"
                                android:layout_weight="1"
                                android:text="Copy HEX"
                                android:textAllCaps="false"
                                android:textSize="12sp" />

                            <com.google.android.material.button.MaterialButton
                                android:id="@+id/btnCopyRgb"
                                style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                                android:layout_width="0dp"
                                android:layout_height="40dp"
                                android:layout_marginEnd="6dp"
                                android:layout_weight="1"
                                android:text="Copy RGB"
                                android:textAllCaps="false"
                                android:textSize="12sp" />

                            <com.google.android.material.button.MaterialButton
                                android:id="@+id/btnCopyXml"
                                style="@style/Widget.MaterialComponents.Button.OutlinedButton"
                                android:layout_width="0dp"
                                android:layout_height="40dp"
                                android:layout_weight="1"
                                android:text="Copy XML"
                                android:textAllCaps="false"
                                android:textSize="12sp" />
                        </LinearLayout>
                    </LinearLayout>
                </LinearLayout>
            </com.google.android.material.card.MaterialCardView>

            <!-- Style Versions Section -->
            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="18dp"
                android:layout_marginBottom="8dp"
                android:text="All Style Versions (Tap to Copy)"
                android:textColor="@color/text_dark"
                android:textSize="16sp"
                android:textStyle="bold" />

            <LinearLayout
                android:id="@+id/llVersionsContainer"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="vertical" />

            <!-- Accounting & Software UI Live Preview -->
            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="18dp"
                android:layout_marginBottom="8dp"
                android:text="Accounting / Software UI Preview"
                android:textColor="@color/text_dark"
                android:textSize="16sp"
                android:textStyle="bold" />

            <com.google.android.material.card.MaterialCardView
                android:id="@+id/cardUiPreview"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                app:cardCornerRadius="14dp"
                app:cardElevation="3dp">

                <LinearLayout
                    android:layout_width="match_parent"
                    android:layout_height="wrap_content"
                    android:orientation="vertical"
                    android:padding="14dp">

                    <LinearLayout
                        android:layout_width="match_parent"
                        android:layout_height="wrap_content"
                        android:gravity="center_vertical"
                        android:orientation="horizontal">

                        <TextView
                            android:id="@+id/tvPreviewTitle"
                            android:layout_width="0dp"
                            android:layout_height="wrap_content"
                            android:layout_weight="1"
                            android:text="Invoice #INV-204"
                            android:textSize="16sp"
                            android:textStyle="bold" />

                        <TextView
                            android:id="@+id/tvPreviewBadge"
                            android:layout_width="wrap_content"
                            android:layout_height="wrap_content"
                            android:paddingHorizontal="10dp"
                            android:paddingVertical="4dp"
                            android:text="PAID"
                            android:textSize="11sp"
                            android:textStyle="bold" />
                    </LinearLayout>

                    <TextView
                        android:layout_width="wrap_content"
                        android:layout_height="wrap_content"
                        android:layout_marginTop="6dp"
                        android:text="Total Balance: ₹24,500.00 | GST Ready"
                        android:textColor="@color/text_gray"
                        android:textSize="13sp" />

                    <Button
                        android:id="@+id/btnPreviewAction"
                        android:layout_width="match_parent"
                        android:layout_height="42dp"
                        android:layout_marginTop="10dp"
                        android:text="Save Voucher"
                        android:textAllCaps="false"
                        android:textColor="@color/white" />
                </LinearLayout>
            </com.google.android.material.card.MaterialCardView>

            <!-- 10 Shades Section -->
            <TextView
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="18dp"
                android:layout_marginBottom="8dp"
                android:text="10 Shades &amp; Tints (50 - 900) — Tap to Copy"
                android:textColor="@color/text_dark"
                android:textSize="16sp"
                android:textStyle="bold" />

            <LinearLayout
                android:id="@+id/llShadesContainer"
                android:layout_width="match_parent"
                android:layout_height="wrap_content"
                android:orientation="vertical" />

        </LinearLayout>
    </ScrollView>
</LinearLayout>
EOF

cat << 'EOF' > app/src/main/res/layout/item_version_row.xml
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_marginBottom="8dp"
    app:cardCornerRadius="12dp"
    app:cardElevation="2dp">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:gravity="center_vertical"
        android:orientation="horizontal"
        android:padding="10dp">

        <View
            android:id="@+id/viewVerSwatch"
            android:layout_width="54dp"
            android:layout_height="54dp" />

        <LinearLayout
            android:layout_width="0dp"
            android:layout_height="wrap_content"
            android:layout_marginStart="12dp"
            android:layout_weight="1"
            android:orientation="vertical">

            <TextView
                android:id="@+id/tvVerLabel"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:text="Version Name"
                android:textColor="@color/text_dark"
                android:textSize="14sp"
                android:textStyle="bold" />

            <TextView
                android:id="@+id/tvVerHex"
                android:layout_width="wrap_content"
                android:layout_height="wrap_content"
                android:layout_marginTop="2dp"
                android:text="#1E40AF"
                android:textColor="@color/text_gray"
                android:textSize="12sp" />
        </LinearLayout>

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:paddingHorizontal="10dp"
            android:paddingVertical="6dp"
            android:text="COPY"
            android:textColor="@color/accent"
            android:textSize="12sp"
            android:textStyle="bold" />
    </LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat << 'EOF' > app/src/main/java/com/color/studio/ColorItem.java
package com.color.studio;

public class ColorItem {
    public String name;
    public String category;
    public int color1;
    public int color2;
    public int color3;

    public ColorItem(String name, String category, int color1, int color2, int color3) {
        this.name = name;
        this.category = category;
        this.color1 = color1;
        this.color2 = color2;
        this.color3 = color3;
    }

    public String getHex() {
        return String.format("#%06X", (0xFFFFFF & color1));
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/color/studio/ColorCatalog.java
package com.color.studio;

import android.graphics.Color;
import androidx.core.graphics.ColorUtils;

import java.util.ArrayList;
import java.util.List;

public class ColorCatalog {

    private static final String[] FAMILY_NAMES = {
            "Crimson", "Scarlet", "Coral", "Tangerine", "Amber",
            "Gold", "Lemon", "Lime", "Emerald", "Mint",
            "Teal", "Cyan", "Sky", "Azure", "Cobalt",
            "Indigo", "Violet", "Purple", "Magenta", "Rose"
    };

    private static final float[] FAMILY_HUES = {
            350f, 4f, 16f, 28f, 40f,
            50f, 62f, 88f, 145f, 164f,
            178f, 192f, 204f, 216f, 228f,
            245f, 266f, 286f, 314f, 334f
    };

    private static final String[] ACCT_SUFFIX = {
            "Trust", "Ledger", "Audit", "Vault", "Office"
    };
    private static final String[] SOFT_SUFFIX = {
            "Mist", "Cloud", "Whisper", "Cream", "Breeze"
    };
    private static final String[] PREM_SUFFIX = {
            "Royal", "Velvet", "Imperial", "Crown", "Noir"
    };
    private static final String[] D3_SUFFIX = {
            "Sculpt", "Bevel", "Cube", "Chrome", "Relief"
    };
    private static final String[] D4_SUFFIX = {
            "Prism", "Aurora", "Cyber", "Neon", "Holo"
    };

    public static List<ColorItem> getAll500Colors() {
        List<ColorItem> list = new ArrayList<>(500);

        // Generate 20 families x 5 variants x 5 categories = 500 exact colors
        // Interleaved across categories so home screen has rich variety from top to bottom!
        for (int v = 0; v < 5; v++) {
            for (int f = 0; f < 20; f++) {
                float baseHue = FAMILY_HUES[f];
                String baseName = FAMILY_NAMES[f];

                // 1. Accounting / Software Pro
                float acctH = (baseHue + v * 3f) % 360f;
                float acctS = 0.42f + (v * 0.06f);
                float acctL = 0.28f + (v * 0.06f);
                int cAcct = ColorUtils.HSLToColor(new float[]{acctH, acctS, acctL});
                list.add(new ColorItem(ACCT_SUFFIX[v] + " " + baseName, "Accounting", cAcct, cAcct, cAcct));

                // 2. Soft / Pastel UI
                float softH = (baseHue + v * 4f) % 360f;
                float softS = 0.35f + (v * 0.07f);
                float softL = 0.80f + (v * 0.03f);
                int cSoft = ColorUtils.HSLToColor(new float[]{softH, softS, softL});
                list.add(new ColorItem("Soft " + baseName + " " + SOFT_SUFFIX[v], "Soft", cSoft, cSoft, cSoft));

                // 3. Premium / Luxury
                float premH = (baseHue + v * 2.5f) % 360f;
                float premS = 0.65f + (v * 0.06f);
                float premL = 0.22f + (v * 0.055f);
                int cPrem = ColorUtils.HSLToColor(new float[]{premH, premS, premL});
                int cPrem2 = ColorUtils.HSLToColor(new float[]{premH, Math.min(1f, premS + 0.1f), Math.min(0.9f, premL + 0.14f)});
                list.add(new ColorItem(PREM_SUFFIX[v] + " " + baseName, "Premium", cPrem, cPrem2, cPrem));

                // 4. 3D Sculpted
                float d3H = (baseHue + v * 3.5f) % 360f;
                float d3S = 0.72f + (v * 0.05f);
                float d3L = 0.46f + (v * 0.04f);
                int c3Main = ColorUtils.HSLToColor(new float[]{d3H, d3S, d3L});
                int c3Light = ColorUtils.HSLToColor(new float[]{d3H, d3S, Math.min(0.92f, d3L + 0.22f)});
                int c3Dark = ColorUtils.HSLToColor(new float[]{d3H, d3S, Math.max(0.12f, d3L - 0.22f)});
                list.add(new ColorItem("3D " + baseName + " " + D3_SUFFIX[v], "3D", c3Light, c3Main, c3Dark));

                // 5. 4D Holographic / Vivid
                float d4H1 = (baseHue + v * 5f) % 360f;
                float d4H2 = (d4H1 + 42f) % 360f;
                float d4H3 = (d4H1 + 88f) % 360f;
                int c4a = ColorUtils.HSLToColor(new float[]{d4H1, 0.92f, 0.54f});
                int c4b = ColorUtils.HSLToColor(new float[]{d4H2, 0.95f, 0.52f});
                int c4c = ColorUtils.HSLToColor(new float[]{d4H3, 0.90f, 0.48f});
                list.add(new ColorItem("4D " + baseName + " " + D4_SUFFIX[v], "4D", c4a, c4b, c4c));
            }
        }
        return list;
    }

    public static String toHex(int color) {
        return String.format("#%06X", (0xFFFFFF & color));
    }

    public static String toRgb(int color) {
        return Color.red(color) + ", " + Color.green(color) + ", " + Color.blue(color);
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/color/studio/ColorGridAdapter.java
package com.color.studio;

import android.graphics.drawable.GradientDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import java.util.List;

public class ColorGridAdapter extends RecyclerView.Adapter<ColorGridAdapter.ColorVH> {

    public interface OnColorClick {
        void onClick(ColorItem item);
    }

    private final List<ColorItem> list;
    private final OnColorClick listener;

    public ColorGridAdapter(List<ColorItem> list, OnColorClick listener) {
        this.list = list;
        this.listener = listener;
    }

    @NonNull
    @Override
    public ColorVH onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.item_color_grid, parent, false);
        return new ColorVH(v);
    }

    @Override
    public void onBindViewHolder(@NonNull ColorVH holder, int position) {
        ColorItem item = list.get(position);
        holder.tvName.setText(item.name);
        holder.tvHex.setText(item.getHex());
        holder.tvBadge.setText(item.category);

        GradientDrawable gd = new GradientDrawable();
        if ("4D".equals(item.category)) {
            gd.setOrientation(GradientDrawable.Orientation.TL_BR);
            gd.setColors(new int[]{item.color1, item.color2, item.color3});
        } else if ("3D".equals(item.category) || "Premium".equals(item.category)) {
            gd.setOrientation(GradientDrawable.Orientation.TOP_BOTTOM);
            gd.setColors(new int[]{item.color1, item.color2, item.color3});
        } else {
            gd.setColor(item.color1);
        }
        holder.viewBox.setBackground(gd);

        holder.itemView.setOnClickListener(v -> listener.onClick(item));
    }

    @Override
    public int getItemCount() {
        return list.size();
    }

    static class ColorVH extends RecyclerView.ViewHolder {
        View viewBox;
        TextView tvName, tvHex, tvBadge;

        ColorVH(@NonNull View itemView) {
            super(itemView);
            viewBox = itemView.findViewById(R.id.viewColorBox);
            tvName = itemView.findViewById(R.id.tvColorName);
            tvHex = itemView.findViewById(R.id.tvColorHex);
            tvBadge = itemView.findViewById(R.id.tvBadge);
        }
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/color/studio/MainActivity.java
package com.color.studio;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.EditText;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.google.android.material.button.MaterialButton;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class MainActivity extends AppCompatActivity {

    private final List<ColorItem> allColors = new ArrayList<>();
    private final List<ColorItem> filteredColors = new ArrayList<>();
    private ColorGridAdapter adapter;
    private TextView tvCount;
    private String selectedCategory = "All";
    private String currentQuery = "";

    private MaterialButton btnAll, btnAcct, btnSoft, btnPrem, btn3D, btn4D;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        allColors.addAll(ColorCatalog.getAll500Colors());
        filteredColors.addAll(allColors);

        tvCount = findViewById(R.id.tvCount);
        EditText etSearch = findViewById(R.id.etSearch);
        RecyclerView rvColors = findViewById(R.id.rvColors);

        btnAll = findViewById(R.id.btnCatAll);
        btnAcct = findViewById(R.id.btnCatAccounting);
        btnSoft = findViewById(R.id.btnCatSoft);
        btnPrem = findViewById(R.id.btnCatPremium);
        btn3D = findViewById(R.id.btnCat3D);
        btn4D = findViewById(R.id.btnCat4D);

        rvColors.setLayoutManager(new GridLayoutManager(this, 3));
        adapter = new ColorGridAdapter(filteredColors, item -> {
            Intent intent = new Intent(this, ColorDetailActivity.class);
            intent.putExtra("name", item.name);
            intent.putExtra("category", item.category);
            intent.putExtra("c1", item.color1);
            intent.putExtra("c2", item.color2);
            intent.putExtra("c3", item.color3);
            startActivity(intent);
        });
        rvColors.setAdapter(adapter);

        btnAll.setOnClickListener(v -> selectCategory("All"));
        btnAcct.setOnClickListener(v -> selectCategory("Accounting"));
        btnSoft.setOnClickListener(v -> selectCategory("Soft"));
        btnPrem.setOnClickListener(v -> selectCategory("Premium"));
        btn3D.setOnClickListener(v -> selectCategory("3D"));
        btn4D.setOnClickListener(v -> selectCategory("4D"));

        etSearch.addTextChangedListener(new TextWatcher() {
            @Override public void beforeTextChanged(CharSequence s, int start, int count, int after) {}
            @Override public void onTextChanged(CharSequence s, int start, int before, int count) {}
            @Override
            public void afterTextChanged(Editable s) {
                currentQuery = s.toString().trim().toLowerCase(Locale.getDefault());
                applyFilter();
            }
        });

        selectCategory("All");
    }

    private void selectCategory(String cat) {
        selectedCategory = cat;
        styleChip(btnAll, "All".equals(cat));
        styleChip(btnAcct, "Accounting".equals(cat));
        styleChip(btnSoft, "Soft".equals(cat));
        styleChip(btnPrem, "Premium".equals(cat));
        styleChip(btn3D, "3D".equals(cat));
        styleChip(btn4D, "4D".equals(cat));
        applyFilter();
    }

    private void styleChip(MaterialButton btn, boolean active) {
        if (active) {
            btn.setBackgroundColor(0xFF6366F1);
            btn.setTextColor(0xFFFFFFFF);
        } else {
            btn.setBackgroundColor(0xFF1E293B);
            btn.setTextColor(0xFFCBD5E1);
        }
    }

    private void applyFilter() {
        filteredColors.clear();
        for (ColorItem item : allColors) {
            boolean catMatch = "All".equals(selectedCategory) || item.category.equalsIgnoreCase(selectedCategory);
            boolean queryMatch = currentQuery.isEmpty()
                    || item.name.toLowerCase(Locale.getDefault()).contains(currentQuery)
                    || item.getHex().toLowerCase(Locale.getDefault()).contains(currentQuery)
                    || item.category.toLowerCase(Locale.getDefault()).contains(currentQuery);
            if (catMatch && queryMatch) {
                filteredColors.add(item);
            }
        }
        tvCount.setText(filteredColors.size() + " Colors");
        adapter.notifyDataSetChanged();
    }
}
EOF

cat << 'EOF' > app/src/main/java/com/color/studio/ColorDetailActivity.java
package com.color.studio;

import android.content.ClipData;
import android.content.ClipboardManager;
import android.content.Context;
import android.graphics.drawable.GradientDrawable;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.ColorUtils;

import com.google.android.material.card.MaterialCardView;

public class ColorDetailActivity extends AppCompatActivity {

    private LinearLayout llVersions, llShades;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_color_detail);

        String name = getIntent().getStringExtra("name");
        String category = getIntent().getStringExtra("category");
        int c1 = getIntent().getIntExtra("c1", 0xFF1E40AF);
        int c2 = getIntent().getIntExtra("c2", c1);
        int c3 = getIntent().getIntExtra("c3", c1);

        int mainColor = ("3D".equals(category)) ? c2 : c1;
        String hex = ColorCatalog.toHex(mainColor);
        String rgb = ColorCatalog.toRgb(mainColor);

        TextView tvTitle = findViewById(R.id.tvDetailTitle);
        TextView tvHeroName = findViewById(R.id.tvHeroName);
        TextView tvHeroCodes = findViewById(R.id.tvHeroCodes);
        View viewHero = findViewById(R.id.viewHeroColor);

        llVersions = findViewById(R.id.llVersionsContainer);
        llShades = findViewById(R.id.llShadesContainer);

        tvTitle.setText(name);
        tvHeroName.setText(name + " (" + category + ")");
        tvHeroCodes.setText("HEX: " + hex + "  |  RGB: " + rgb);

        GradientDrawable heroBg = new GradientDrawable();
        if ("4D".equals(category)) {
            heroBg.setOrientation(GradientDrawable.Orientation.TL_BR);
            heroBg.setColors(new int[]{c1, c2, c3});
        } else if ("3D".equals(category) || "Premium".equals(category)) {
            heroBg.setOrientation(GradientDrawable.Orientation.TOP_BOTTOM);
            heroBg.setColors(new int[]{c1, c2, c3});
        } else {
            heroBg.setColor(mainColor);
        }
        viewHero.setBackground(heroBg);

        findViewById(R.id.btnBack).setOnClickListener(v -> finish());
        findViewById(R.id.btnCopyHex).setOnClickListener(v -> copyText("HEX", hex));
        findViewById(R.id.btnCopyRgb).setOnClickListener(v -> copyText("RGB", "rgb(" + rgb + ")"));
        findViewById(R.id.btnCopyXml).setOnClickListener(v -> {
            String safeName = (name != null ? name : "custom_color").toLowerCase().replaceAll("[^a-z0-9]+", "_");
            copyText("XML", "<color name=\"" + safeName + "\">" + hex + "</color>");
        });

        buildStyleVersions(mainColor);
        buildUiPreview(mainColor);
        buildTenShades(mainColor);
    }

    private void buildStyleVersions(int baseColor) {
        float[] hsl = new float[3];
        ColorUtils.colorToHSL(baseColor, hsl);
        float h = hsl[0];
        float s = hsl[1];

        // 1. Soft / Pastel Version
        int softColor = ColorUtils.HSLToColor(new float[]{h, Math.min(s, 0.48f), 0.86f});
        addVersionRow("Soft / Pastel UI Version", ColorCatalog.toHex(softColor), new int[]{softColor}, false, ColorCatalog.toHex(softColor));

        // 2. Accounting / Pro Trust Version
        int acctColor = ColorUtils.HSLToColor(new float[]{h, Math.min(Math.max(s, 0.35f), 0.58f), 0.32f});
        addVersionRow("Accounting / Software Pro Version", ColorCatalog.toHex(acctColor), new int[]{acctColor}, false, ColorCatalog.toHex(acctColor));

        // 3. Premium Luxury Version
        int premColor = ColorUtils.HSLToColor(new float[]{h, Math.max(s, 0.68f), 0.24f});
        int premHigh = ColorUtils.HSLToColor(new float[]{h, Math.max(s, 0.72f), 0.38f});
        addVersionRow("Premium Deep Version", ColorCatalog.toHex(premColor) + " → " + ColorCatalog.toHex(premHigh),
                new int[]{premHigh, premColor}, false, ColorCatalog.toHex(premColor));

        // 4. 3D Sculpted Version
        int d3Top = ColorUtils.HSLToColor(new float[]{h, Math.max(s, 0.65f), 0.68f});
        int d3Mid = ColorUtils.HSLToColor(new float[]{h, Math.max(s, 0.72f), 0.46f});
        int d3Bot = ColorUtils.HSLToColor(new float[]{h, Math.max(s, 0.75f), 0.24f});
        String d3Hex = ColorCatalog.toHex(d3Top) + " | " + ColorCatalog.toHex(d3Mid) + " | " + ColorCatalog.toHex(d3Bot);
        addVersionRow("3D Sculpted Version (Top / Mid / Shadow)", d3Hex, new int[]{d3Top, d3Mid, d3Bot}, false, d3Hex);

        // 5. 4D Holographic / Multi-Color Version
        int d4a = ColorUtils.HSLToColor(new float[]{h, 0.92f, 0.55f});
        int d4b = ColorUtils.HSLToColor(new float[]{(h + 42f) % 360f, 0.95f, 0.52f});
        int d4c = ColorUtils.HSLToColor(new float[]{(h + 88f) % 360f, 0.90f, 0.48f});
        String d4Hex = ColorCatalog.toHex(d4a) + " → " + ColorCatalog.toHex(d4b) + " → " + ColorCatalog.toHex(d4c);
        addVersionRow("4D Vivid Gradient Version", d4Hex, new int[]{d4a, d4b, d4c}, true, d4Hex);
    }

    private void buildUiPreview(int baseColor) {
        float[] hsl = new float[3];
        ColorUtils.colorToHSL(baseColor, hsl);

        int bgSoft = ColorUtils.HSLToColor(new float[]{hsl[0], Math.min(hsl[1], 0.42f), 0.94f});
        int darkAccent = ColorUtils.HSLToColor(new float[]{hsl[0], Math.max(hsl[1], 0.45f), 0.32f});

        MaterialCardView card = findViewById(R.id.cardUiPreview);
        TextView tvTitle = findViewById(R.id.tvPreviewTitle);
        TextView tvBadge = findViewById(R.id.tvPreviewBadge);
        Button btnAction = findViewById(R.id.btnPreviewAction);

        card.setCardBackgroundColor(bgSoft);
        tvTitle.setTextColor(darkAccent);

        GradientDrawable badgeBg = new GradientDrawable();
        badgeBg.setColor(darkAccent);
        badgeBg.setCornerRadius(16f);
        tvBadge.setBackground(badgeBg);
        tvBadge.setTextColor(0xFFFFFFFF);

        btnAction.setBackgroundColor(darkAccent);
    }

    private void buildTenShades(int baseColor) {
        float[] hsl = new float[3];
        ColorUtils.colorToHSL(baseColor, hsl);

        int[] weights = {50, 100, 200, 300, 400, 500, 600, 700, 800, 900};
        float[] lightness = {0.96f, 0.90f, 0.80f, 0.68f, 0.56f, 0.46f, 0.38f, 0.30f, 0.22f, 0.14f};
        String[] tags = {"Ultra Soft", "Soft Tint", "Light", "Medium Light", "Bright", "Base", "Rich", "Deep", "Dark", "Ultra Dark"};

        for (int i = 0; i < weights.length; i++) {
            int shade = ColorUtils.HSLToColor(new float[]{hsl[0], hsl[1], lightness[i]});
            String sHex = ColorCatalog.toHex(shade);
            addShadeRow(weights[i] + " — " + tags[i], sHex, shade);
        }
    }

    private void addVersionRow(String label, String displayHex, int[] colors, boolean diagonal, String copyVal) {
        View row = LayoutInflater.from(this).inflate(R.layout.item_version_row, llVersions, false);
        View swatch = row.findViewById(R.id.viewVerSwatch);
        TextView tvLabel = row.findViewById(R.id.tvVerLabel);
        TextView tvHex = row.findViewById(R.id.tvVerHex);

        GradientDrawable gd = new GradientDrawable();
        gd.setCornerRadius(20f);
        if (colors.length > 1) {
            gd.setOrientation(diagonal ? GradientDrawable.Orientation.TL_BR : GradientDrawable.Orientation.TOP_BOTTOM);
            gd.setColors(colors);
        } else {
            gd.setColor(colors[0]);
        }
        swatch.setBackground(gd);
        tvLabel.setText(label);
        tvHex.setText(displayHex);

        row.setOnClickListener(v -> copyText(label, copyVal));
        llVersions.addView(row);
    }

    private void addShadeRow(String label, String hex, int color) {
        View row = LayoutInflater.from(this).inflate(R.layout.item_version_row, llShades, false);
        View swatch = row.findViewById(R.id.viewVerSwatch);
        TextView tvLabel = row.findViewById(R.id.tvVerLabel);
        TextView tvHex = row.findViewById(R.id.tvVerHex);

        GradientDrawable gd = new GradientDrawable();
        gd.setCornerRadius(18f);
        gd.setColor(color);
        swatch.setBackground(gd);

        tvLabel.setText(label);
        tvHex.setText(hex);
        row.setOnClickListener(v -> copyText("Shade " + label, hex));
        llShades.addView(row);
    }

    private void copyText(String label, String value) {
        ClipboardManager cm = (ClipboardManager) getSystemService(Context.CLIPBOARD_SERVICE);
        if (cm != null) {
            cm.setPrimaryClip(ClipData.newPlainText(label, value));
            Toast.makeText(this, "Copied: " + value, Toast.LENGTH_SHORT).show();
        }
    }
}
EOF

echo "Pro Color Studio 500 files created!"