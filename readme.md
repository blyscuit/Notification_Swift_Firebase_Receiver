# ■ Sound & Badge

# ■ Silent Push Noti

# ■ Notification Content

# Extension

# ■ Notification Service

# Extension

[PDF version](Noti.pdf)

# Sound & Badge

{ "aps" : { "alert" : "message", "sound" :
"default", "badge" : 0 } }


# Silent Push Noti

"aps" = { "content-available" : 1,
"sound" : "" }


# Silent Push Noti

Run other code


# Notification Content Extension


# Notification Content Extension


# Notification Service Extension


# Notification Service Extension

1. App receives notification.
2. System creates an instance of your extension class and
    launches it in the background.
3. Your extension performs content edits and/or downloads
    some content.
4. If your extension takes too long to perform its work, it will
    be notified and immediately terminated.
5. Notification is displayed to the user.


# Notification Service Extension

{
“aps” : {
“category” : “SECRET”,
“mutable-content” : 1,
“alert” : {
“title” : “Secret Message!”,
“body” : “(Encrypted)”
},
},
“ENCRYPTED_DATA” : “Salted__·öîQÊ$UDì_¶Ù∞è Ω^¬%gq∞NÿÒQùw”
}


