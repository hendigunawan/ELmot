package com.example.online_trading

import android.content.Context
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.nio.ByteBuffer

class MainActivity: FlutterFragmentActivity() {
    private val CHANNEL_SNAPPY = "com.example.snappy/compression"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        fun getNativeLibraryPath(libraryName: String): String {
            val context: Context = applicationContext
            val nativeLibraryDir = context.applicationInfo.nativeLibraryDir
            return "$nativeLibraryDir/$libraryName"
        }


        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_SNAPPY).setMethodCallHandler { call, result ->
            when (call.method) {
                "compress" -> {
                    val arguments= call.arguments as Map<String, Any>
                    val data = arguments["byte"] as ByteArray
                    val compressedData = SnappyHelper.compress(data)
                    result.success(compressedData)
                }
                "decompress" -> {
                    val arguments= call.arguments as Map<String, Any>
                    val data = arguments["byte"] as ByteArray

                    val decompressedData = SnappyHelper.decompress(data)
                    result.success(decompressedData)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
