package dev.pausa.ambrogiolimb.model

import java.util.*

data class Notification(val title: String,
                        val text: String,
                        val uid : String = UUID.randomUUID().toString())