package dev.pausa.ambrogiolimb.publisher

import android.util.Log
import com.google.firebase.auth.ktx.auth
import com.google.firebase.database.ktx.database
import com.google.firebase.ktx.Firebase
import dev.pausa.ambrogiolimb.model.Notification

fun publishNotification(notification: Notification){
    Log.i("NOTIFICATION", "Publishing: $notification")

    Firebase.auth.currentUser?.uid
        ?.let {
            Firebase.database.reference.child(it)
                .child("notifications")
                .child("last-notification")
                .setValue(notification)
        }

}