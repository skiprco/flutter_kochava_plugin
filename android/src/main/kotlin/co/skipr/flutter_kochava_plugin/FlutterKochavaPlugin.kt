package co.skipr.flutter_kochava_plugin
import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import com.kochava.base.Tracker;
import com.kochava.base.Tracker.Configuration;
import com.kochava.base.Tracker.configure


class FlutterKochavaPlugin: MethodCallHandler {

    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "flutter_kochava_plugin")
            channel.setMethodCallHandler(FlutterKochavaPlugin(registrar.context()))

        }
    }

    var context: Context
    constructor(context: Context) {
        this.context = context
    }


    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "configure") {
            var arguments = call.arguments as String
            if (arguments == null) {
                result.error("flutter_kochava_plugin", "Error", "incorrect arguments, should be String")
                return
            }
            configure(Configuration(context)
                    .setAppGuid(arguments)
                    .setLogLevel(Tracker.LOG_LEVEL_NONE)
            )
            result.success("success")
        } else if (call.method == "sendEvent") {





            result.success("success")
        } else {
            result.notImplemented()
        }
    }
}
