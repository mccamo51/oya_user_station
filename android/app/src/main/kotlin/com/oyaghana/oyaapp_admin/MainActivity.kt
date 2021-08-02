package com.oyaghana.oyaapp_admin


import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import vpos.apipackage.PosApiHelper

class MainActivity: FlutterActivity() {

    private var tag = "MainActivity"
    private val mbThreadFinished = true

    //  API  FOR  CALLING THE DATA
    var posApiHelper: PosApiHelper = PosApiHelper.getInstance()

    private var printThread: PrintThread? = null
    inner class PrintThread : Thread()
    {
        fun isThreadFinished(): Boolean
        {
            return mbThreadFinished
        }

        override fun run() {
            try {
                posApiHelper.PrintInit(2, 24, 24, 0x33)
                posApiHelper.PrintStr("   G.P.R.T.U \n\n")
                posApiHelper.PrintStr("     Ticket \n\n")

                posApiHelper.PrintStart()
            } catch (ex: Exception) {
            }
        }
    }

    private val CHANNEL = "samples.flutter.dev/print"
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            val argument = call.arguments<Map<String,Any>>()
            if (call.method == "printTest") {

                if (printThread != null && !printThread!!.isThreadFinished())
                {
                    Log.e(tag, "Thread is still running...")
                }
                printThread = PrintThread()
                printThread!!.start()

            }else{
                result.notImplemented()
            }
            // TODO
        }
    }

}
