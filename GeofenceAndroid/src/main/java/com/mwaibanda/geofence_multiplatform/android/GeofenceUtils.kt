
package com.mwaibanda.geofence_multiplatform.android

import android.content.Context
import com.google.android.gms.location.GeofenceStatusCodes
import com.google.android.gms.maps.model.LatLng
import java.util.concurrent.TimeUnit

/**
 * Returns the error string for a geofencing error code.
 */
fun errorMessage(context: Context, errorCode: Int): String {
    val resources = context.resources
    return when (errorCode) {
        GeofenceStatusCodes.GEOFENCE_NOT_AVAILABLE -> resources.getString(
            R.string.geofence_not_available
        )
        GeofenceStatusCodes.GEOFENCE_TOO_MANY_GEOFENCES -> resources.getString(
            R.string.geofence_too_many_geofences
        )
        GeofenceStatusCodes.GEOFENCE_TOO_MANY_PENDING_INTENTS -> resources.getString(
            R.string.geofence_too_many_pending_intents
        )
        else -> resources.getString(R.string.unknown_geofence_error)
    }
}

/**
 * Stores latitude and longitude information along with a hint to help user find the location.
 */
data class Location(val id: String, val name: Int, val latLong: LatLng)

internal object GeofencingConstants {

    val GEOFENCE_EXPIRATION_IN_MILLISECONDS: Long = TimeUnit.HOURS.toMillis(1)

    val GEOFENCED_LOCATIONS = arrayOf(
        Location(
            "midway_apt",
            R.string.midway_location,
            LatLng(41.78499686, -87.751496994)),

        Location(
            "ohare_apt",
            R.string.ohare_location,
            LatLng(41.978611, -87.904724)),

        Location(
            "shedd_aq",
            R.string.shedd_location,
            LatLng(41.8670292454, -87.6134396189)),

        Location(
           "nandos_rst",
            R.string.nandos_location,
            LatLng(41.90855, -87.64636))
    )

    val NUM_GEOFENCED = GEOFENCED_LOCATIONS.size
    const val GEOFENCE_RADIUS_IN_METERS = 100f
    const val EXTRA_GEOFENCE_INDEX = "GEOFENCE_INDEX"
}
