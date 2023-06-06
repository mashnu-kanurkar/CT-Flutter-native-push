package com.example.ct_flutter_native_push;

import com.clevertap.android.sdk.ActivityLifecycleCallback;
import com.clevertap.android.sdk.CleverTapAPI;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        ActivityLifecycleCallback.register(this);
        CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG);
        super.onCreate();
    }
}
