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
import org.json.JSONObject


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
            var arguments = call.arguments as? String
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
            var arguments = call.arguments as? Map<String, Any>
            if (arguments == null) {
                result.error("flutter_kochava_plugin", "Error", "incorrect arguments, should be Map")
                return
            }
            var type = arguments["type"] as? String
            if (type == null || type.length == 0) {
                result.error("flutter_kochava_plugin", "Error", "incorrect type")
                return
            }
            if (type == "customEvent") {
                var nameString = arguments["nameString"] as? String
                if (nameString == null || nameString.length == 0) {
                    result.error("flutter_kochava_plugin", "Error", "incorrect nameString")
                    return
                }
                var event = Tracker.Event(nameString)
                var infoDictionary = arguments["infoDictionary"] as? Map<String, Any>
                if (infoDictionary != null) {
                    // when adding a dict, you doesn(t need to pass the custom name as a first parameter
//                    event.addCustom("val", 10)
                    event.addCustom(JSONObject(infoDictionary))
                }
                var userIdString = arguments["userIdString"] as? String
                if (userIdString != null) {
                    event.addCustom("userIdString", userIdString)
                }
                Tracker.sendEvent(event);
                result.success("success")
            } else {
                result.error("flutter_kochava_plugin", "Error", "unhandled type")

            }
        } else {
            result.notImplemented()
        }
    }
}
