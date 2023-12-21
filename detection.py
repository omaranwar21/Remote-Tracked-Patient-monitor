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

# firebase.

# storage = firebase.storage()
# storage = firebase.storage()
db = firebase.database()
db.child("Arythmia").set("Normal")
# ref = database.reference('Arythmia')
# ref.set(True)


# write on database detection variable 
# def updateDetectionVar(id, value):
    # print("Updating Detection Variable")


    # detections = ref.get().val() or {}
    # if id not in detections:
    #     detections[id] = {'value': False}
    #     detections[id]['value'] = value
    #     else:
            



# path_on_cloud = "ecg_file.csv"
# path_local = "./"
# storage.child(path_on_cloud).download(path_local, "ecg.csv")