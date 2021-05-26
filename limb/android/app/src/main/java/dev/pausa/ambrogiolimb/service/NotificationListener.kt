package dev.pausa.ambrogiolimb.service

import android.app.Notification.EXTRA_TEXT
import android.app.Notification.EXTRA_TITLE
import android.service.notification.NotificationListenerService
import android.service.notification.StatusBarNotification
import android.util.Log
import dev.pausa.ambrogiolimb.model.Notification
import dev.pausa.ambrogiolimb.publisher.publishNotification

// TODO add warning if permission is not there
// TODO call notification
// TODO event notification/handler
// TODO NOTIFICATION tag somewhere
class NotificationListener : NotificationListenerService() {
    private var connected = false

    override fun onNotificationPosted(sbn: StatusBarNotification?) {
        sbn?.notification
            ?.takeIf { connected.and(shouldForward(it)) }
            ?.run {
                val text = extras.getCharSequence(EXTRA_TEXT)
                val title = extras.getCharSequence(EXTRA_TITLE)
                val hexColor = String.format("#%06X", 0xFFFFFF and color)
                if (text != null && title != null) {
                    Notification(title.toString(), text.toString(), hexColor, "incoming_notification")
                } else {
                    null
                }
            }
            ?.run {
                publishNotification(this)
            }
    }

    override fun onListenerConnected() {
        Log.i("NOTIFICATION", "Listener connected!")
        connected = true
    }

    /**
     * Only notifications that can be replied should be forwarded, the others can wait
     */
    private fun shouldForward(notification: android.app.Notification): Boolean {
        Log.i("NOTIFICATION", notification.toString())
        return hasRemoteActions(notification)
            .or(isCall(notification))
    }

    private fun hasRemoteActions(notification: android.app.Notification): Boolean {
        return notification.actions
            ?.any { it.remoteInputs?.isNotEmpty() ?: false }
            ?: false
    }

    private fun isCall(notification: android.app.Notification): Boolean {
        return android.app.Notification.CATEGORY_CALL == notification.category
    }
}