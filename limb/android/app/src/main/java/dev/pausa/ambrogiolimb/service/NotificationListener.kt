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
            ?.run { extras }
            ?.run {
                val text = getCharSequence(EXTRA_TEXT)
                val title = getCharSequence(EXTRA_TITLE)
                Log.i("NOTIFICATION", "Raw notification: $title: $text")
                if (text != null && title != null) {
                    Notification(title.toString(), text.toString())
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
        return notification.actions
            ?.any { it.remoteInputs?.isNotEmpty() ?: false }
            ?: false
    }
}