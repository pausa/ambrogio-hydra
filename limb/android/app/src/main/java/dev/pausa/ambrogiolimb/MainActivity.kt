package dev.pausa.ambrogiolimb

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import com.firebase.ui.auth.AuthUI
import com.firebase.ui.auth.IdpResponse
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.ktx.auth
import com.google.firebase.database.ktx.database
import com.google.firebase.ktx.Firebase
import dev.pausa.ambrogiolimb.model.Notification
import dev.pausa.ambrogiolimb.publisher.publishNotification

// TODO replace all formats with templates
class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)


        startLogin()
    }

    fun sendMessage(view: View) {
        publishNotification(Notification("Test Notification", "Everything works fine"))
    }


    private fun startLogin() {
        startActivityForResult(
            AuthUI.getInstance()
                .createSignInIntentBuilder()
                .setIsSmartLockEnabled(false)
                .setAvailableProviders(
                    listOf(
                        AuthUI.IdpConfig.GoogleBuilder().build()
                    )
                ).build(),
            SIGN_IN_ACTIVITY
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        // TODO do better, really
        if (requestCode == SIGN_IN_ACTIVITY) {
            val response = IdpResponse.fromResultIntent(data)

            if (resultCode == Activity.RESULT_OK) {
                // we just logged in, I don't expect for there not to be a user
                val currentUser = FirebaseAuth.getInstance().currentUser!!
                findViewById<TextView>(R.id.mainText).text = "logged in as: %s".format(currentUser.displayName)
            } else {
                // TODO proper flow for login errors?
                findViewById<TextView>(R.id.mainText).text = "can't login"
                Log.e(TAG, "can't login.", response?.error)
            }
        }

    }

    // TODO APPARENTLY this is not a good way to do it, find another, not companion
    companion object {
        const val TAG = "MAIN"
        const val SIGN_IN_ACTIVITY = 666
    }
}