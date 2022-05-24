package com.mwaibanda.geofence_multiplatform.android

import android.app.PendingIntent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.google.android.gms.common.api.GoogleApiClient
import com.google.android.gms.location.GeofencingRequest
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.Marker
import com.google.android.gms.maps.model.MarkerOptions
import com.google.firebase.analytics.FirebaseAnalytics


class MainActivity : AppCompatActivity() {


    private var mFirebaseAnalytics: FirebaseAnalytics? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        mFirebaseAnalytics = FirebaseAnalytics.getInstance(this)
        val tv: TextView = findViewById(R.id.text_view)
        tv.text = "Hello World"
    }
}
