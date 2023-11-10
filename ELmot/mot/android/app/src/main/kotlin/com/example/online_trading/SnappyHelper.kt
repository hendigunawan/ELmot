package com.example.online_trading

import org.iq80.snappy.Snappy
import java.io.IOException

object SnappyHelper {

    fun compress(data: ByteArray): ByteArray {
        return Snappy.compress(data)
    }

    fun decompress(data: ByteArray): ByteArray? {
        try {
            return Snappy.uncompress(data, 0, data.size)
        } catch (e: IOException) {
            e.printStackTrace()
        }
        return null
    }
}
