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
      channel.setMethodCallHandler(FlutterKochavaPlugin())

    }
  }


  override fun onMethodCall(call: MethodCall, result: Result) {
     if (call.method == "configure") {
      var argument = call.argument<String>("data")!!
      print(argument)
//
//
//      configure(Configuration(context)
//              .setAppGuid("_YOUR_APP_GUID_")
//              .setLogLevel(Tracker.LOG_LEVEL_NONE)
//      )
//
//
//      configure(Configuration(getApplicationContext())
//              .setAppGuid(argument)
//              .setLogLevel(Tracker.LOG_LEVEL_NONE)
//      );
      result.success("success configure")
    } else if (call.method == "sendEvent") {





      result.success("success sendEvent")
    } else {
      result.notImplemented()
    }
  }
}
