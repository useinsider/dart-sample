package com.example.InsiderDemo;

import com.useinsider.insider.flutter_insider.FlutterInsiderPlugin;
import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

public class MainActivity extends FlutterActivity {

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        flutterEngine.getPlugins().add(new FlutterInsiderPlugin());
    }
}