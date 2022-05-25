package com.mwaibanda.geofence_multiplatform.android

import android.Manifest
import android.content.pm.PackageManager


import android.content.pm.PackageManager.PERMISSION_GRANTED
import android.location.Location
import android.os.Build
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.Looper
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.example.android.treasureHunt.GeofencingConstants
import com.google.android.gms.location.*

import com.google.android.gms.maps.CameraUpdateFactory
import com.google.android.gms.maps.GoogleMap
import com.google.android.gms.maps.OnMapReadyCallback
import com.google.android.gms.maps.SupportMapFragment
import com.google.android.gms.maps.model.LatLng
import com.google.android.gms.maps.model.MarkerOptions
import com.google.android.gms.tasks.Task
import com.mwaibanda.geofence_multiplatform.android.databinding.ActivityMapsBinding


class MapsActivity : AppCompatActivity(), OnMapReadyCallback {

    private lateinit var mMap: GoogleMap
    private lateinit var binding: ActivityMapsBinding
    private lateinit var geofencingClient: GeofencingClient

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityMapsBinding.inflate(layoutInflater)
        setContentView(binding.root)

       val mapFragment = supportFragmentManager
            .findFragmentById(R.id.map) as SupportMapFragment
        mapFragment.getMapAsync(this)

    }


    override fun onMapReady(googleMap: GoogleMap) {
        mMap = googleMap

        val chicago = LatLng(41.881832, -87.623177)
        mMap.moveCamera(CameraUpdateFactory.newLatLngZoom(chicago, 11f))

        GeofencingConstants.GEOFENCED_LOCATIONS.forEach {  location ->
            mMap.addMarker(MarkerOptions().position(location.latLong).title(getString(location.name)))
        }
    }
}
