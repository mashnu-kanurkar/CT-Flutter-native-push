package com.example.ct_flutter_native_push;

import android.util.Log;

import com.clevertap.android.sdk.ActivityLifecycleCallback;
import com.clevertap.android.sdk.CleverTapAPI;
import com.clevertap.android.sdk.pushnotification.CTPushNotificationListener;

import java.util.HashMap;

import io.flutter.app.FlutterApplication;

public class MyApplication extends FlutterApplication implements CTPushNotificationListener{

    @Override
    public void onCreate() {
        ActivityLifecycleCallback.register(this);
        CleverTapAPI.setDebugLevel(CleverTapAPI.LogLevel.DEBUG);
        CleverTapAPI cleverTapAPI = CleverTapAPI.getDefaultInstance(getApplicationContext());
        assert cleverTapAPI != null;
        cleverTapAPI.setCTPushNotificationListener(this);
        super.onCreate();
    }

    @Override
    public void onNotificationClickedPayloadReceived(HashMap<String, Object> payload) {
        Log.d("Payload before: ", payload.toString());
        if(payload != null){
            Log.d("Payload clicked: ", payload.toString());
        }
    }
}
