import pyrebase

config = {
    "apiKey": "AIzaSyAPCMW9BEND7-JAJRE-25QipGyGpNFevNE",
    "authDomain": "smarticu-c78aa.firebaseapp.com",
    "databaseURL": "https://smarticu-c78aa-default-rtdb.firebaseio.com",
    "projectId": "smarticu-c78aa",
    "storageBucket": "smarticu-c78aa.appspot.com",
    "messagingSenderId": "771972734729",
    "appId": "1:771972734729:web:a5b49783504a872d747dd8",
    "measurementId": "G-8RXVDS0ZHR"
}

firebase = pyrebase.initialize_app(config)
storage = firebase.storage()

path_on_cloud = "ecg_signal.csv"
path_local = "./"
storage.child(path_on_cloud).download(path_local, "ecg.csv")