package com.defifundr.app

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.defifundr.app/app_icon"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "setIcon" -> {
                        val iconName = call.argument<String>("icon")
                        val allIcons = call.argument<List<String>>("listAvailableIcon")
                        if (iconName != null && allIcons != null) {
                            try {
                                setAppIcon(iconName, allIcons)
                                result.success(null)
                            } catch (e: Exception) {
                                result.error("ICON_ERROR", e.message, null)
                            }
                        } else {
                            result.error("INVALID_ARGS", "icon and listAvailableIcon are required", null)
                        }
                    }
                    "supportsAlternateIcons" -> result.success(true)
                    else -> result.notImplemented()
                }
            }
    }

    private fun setAppIcon(iconName: String, allIcons: List<String>) {
        val pm = packageManager
        val pkg = packageName

        // Enable/disable each alias
        for (icon in allIcons) {
            if (icon == "MainActivity") continue
            val component = ComponentName(pkg, "$pkg.$icon")
            val state = if (icon == iconName)
                PackageManager.COMPONENT_ENABLED_STATE_ENABLED
            else
                PackageManager.COMPONENT_ENABLED_STATE_DISABLED
            pm.setComponentEnabledSetting(component, state, PackageManager.DONT_KILL_APP)
        }

        // Enable/disable the default MainActivity launcher entry
        val mainComponent = ComponentName(pkg, "$pkg.MainActivity")
        val mainState = if (iconName == "MainActivity")
            PackageManager.COMPONENT_ENABLED_STATE_DEFAULT
        else
            PackageManager.COMPONENT_ENABLED_STATE_DISABLED
        pm.setComponentEnabledSetting(mainComponent, mainState, PackageManager.DONT_KILL_APP)
    }
}
