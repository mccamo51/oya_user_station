package com.oyaghana.oyaapp_admin


import android.util.Log
import androidx.annotation.NonNull
import com.google.zxing.BarcodeFormat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject
import vpos.apipackage.PosApiHelper

class MainActivity: FlutterActivity() {

    private var tag = "MainActivity"
    private val mbThreadFinished = true
    var trip = " "
    var amount = " "
    var vehicleNumber = " "
    var ticketNumber = " "
    var stationCode = " "
    var stationName = " "
    var conductor = " "
    var tripDate = " "
    var seatNumber = " "
    var stationContact = " "
    var driver = " "
    var passenger = " "
    var emergencyContact = " "
    var passengerPhoneNumber = " ";

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
                posApiHelper.PrintStr("   $stationName \n\n")
                posApiHelper.PrintStr("     Ticket \n\n")
                posApiHelper.PrintSetFont(16.toByte(), 16.toByte(), 0x33.toByte())
                posApiHelper.PrintStr("$trip \n\n")
                posApiHelper.PrintStr("GHS $amount \n\n")
                posApiHelper.PrintStr("------------------------\n")
                posApiHelper.PrintStr("Trip Details \n\n")
                posApiHelper.PrintSetFont(24.toByte(), 24.toByte(), 0x00.toByte())
                posApiHelper.PrintStr("Vehicle Number: $vehicleNumber\n\n")
                posApiHelper.PrintStr("Ticket Number: $ticketNumber\n\n")
                posApiHelper.PrintStr("Station Code: $stationCode\n\n")
                posApiHelper.PrintStr("Conductor: $conductor\n\n")
                posApiHelper.PrintStr("Trip Date: $tripDate\n\n")
                posApiHelper.PrintStr("Seat Number: $seatNumber\n\n")
                posApiHelper.PrintStr("Station Contact: $stationContact\n\n")
                posApiHelper.PrintStr("Driver: $driver\n\n")
                posApiHelper.PrintSetFont(16.toByte(), 16.toByte(), 0x33.toByte())
                posApiHelper.PrintStr("------------------------\n")
                posApiHelper.PrintStr("Passenger Details \n\n")
                posApiHelper.PrintSetFont(24.toByte(), 24.toByte(), 0x00.toByte())
                posApiHelper.PrintStr("Name: $passenger\n\n")
                posApiHelper.PrintStr("Phone Number: $passengerPhoneNumber\n\n")
                posApiHelper.PrintStr("Emergency Contact: $emergencyContact\n\n")


                posApiHelper.PrintStr("------------------------------\n")
                posApiHelper.PrintStr("        Powered by OYA\n")
                posApiHelper.PrintBarcode(ticketNumber, 240, 240, BarcodeFormat.QR_CODE)
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
            if (call.method == "printTest") {
                 ticketNumber = call.argument<String>("ticketNo").toString()
                 trip = call.argument<String>("from")+ " - "+call.argument<String>("to")
                 vehicleNumber = call.argument<String>("vehicleNo").toString()
                 passenger = call.argument<String>("user").toString()
                 passengerPhoneNumber = call.argument<String>("phoneNumber").toString()
                 emergencyContact = call.argument<String>("iceNo").toString()
                 tripDate = call.argument<String>("depDate").toString()
                 stationCode = call.argument<String>("stationCode").toString()
                 stationName  = call.argument<String>("stationName").toString()
                 stationContact = call.argument<String>("phone").toString()
                 amount = call.argument<String>("price").toString()
                 driver = call.argument<String>("driver").toString()
                 conductor = call.argument<String>("conductor").toString()


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
