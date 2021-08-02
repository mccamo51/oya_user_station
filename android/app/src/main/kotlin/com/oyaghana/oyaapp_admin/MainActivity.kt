package com.oyaghana.oyaapp_admin

import com.google.zxing.BarcodeFormat
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
        var content = "1234567890"
        fun isThreadFinished(): Boolean
        {
            return mbThreadFinished
        }

        override fun run() {
            try {
                posApiHelper.PrintBarcode(content, 240, 240, BarcodeFormat.QR_CODE)
                posApiHelper.PrintSetFont(16.toByte(), 16.toByte(), 0x33.toByte())
                posApiHelper.PrintStr("Ticket # : $content\n\n")
                posApiHelper.PrintStr("------------------------\n")
                posApiHelper.PrintSetFont(24.toByte(), 24.toByte(), 0x00.toByte())
                posApiHelper.PrintStr(" OYA Test Print \n")
                posApiHelper.PrintStr(" OYA Ticket \n")
                posApiHelper.PrintStr(" Powered by OYA\n")
                posApiHelper.PrintStr("\n")
                posApiHelper.PrintStr("\n")
                posApiHelper.PrintStr("\n")
                posApiHelper.PrintStr("\n")
                posApiHelper.PrintStr("\n")
                posApiHelper.PrintStr("\n")
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
