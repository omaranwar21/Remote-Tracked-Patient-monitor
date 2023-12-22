import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn import metrics
from sklearn import preprocessing
import pickle
import neurokit2 as nk
import pandas as pd
import pyrebase

local_path = "C:\\Users\\Omar Saad\\Desktop\\Final IoT\\ECG_Detection\\ecg_files\\"

def extract_features(path):
    ecg_data = pd.read_csv(path) # replace 'ecg_data.csv' with your file path
    ecg_clean = nk.ecg_clean(ecg_data, sampling_rate=500)
    _, waves_peak =  nk.ecg_delineate(ecg_clean,sampling_rate=500)
    _, rpeaks = nk.ecg_peaks(ecg_data, sampling_rate=500)
    # rpeaks=rpeaks['ECG_R_Peaks']
    # waves_peak
    p_peaks = waves_peak["ECG_P_Peaks"]
    q_peaks = waves_peak["ECG_Q_Peaks"]
    r_peaks = rpeaks['ECG_R_Peaks']
    s_peaks = waves_peak["ECG_S_Peaks"]
    t_peaks = waves_peak["ECG_T_Peaks"]
    # Create a dictionary from the peaks lists
    peaks_dict = {"ECG_P_Peaks": p_peaks,
                "ECG_Q_Peaks": q_peaks,
                "ECG_R_Peaks": r_peaks,
                "ECG_S_Peaks": s_peaks,
                "ECG_T_Peaks": t_peaks}
    # Convert the dictionary into a pandas DataFrame
    peaks_df = pd.DataFrame(peaks_dict)
    # Reset the index to create a column for the peak type
    peaks_df.reset_index(inplace=True)
    # Rename the index column to 'Peak Type'
    peaks_df.rename(columns={"index": "Peak Type"}, inplace=True)
    # Save the peaks_df DataFrame to a csv file
    peaks_df.to_csv(local_path+"peaks_data", index=False)
    test_2 = pd.read_csv(local_path+'peaks_data')
    x_data_test_2 = test_2[['ECG_P_Peaks',	'ECG_S_Peaks','ECG_R_Peaks',	'ECG_T_Peaks',	'ECG_Q_Peaks']]
    # Normalize the data
    min_max_scaler = preprocessing.MinMaxScaler()
    x_data_test_2_scaled = min_max_scaler.fit_transform(x_data_test_2)
    # Create a pandas DataFrame from the scaled peaks data
    peaks_scaled_df = pd.DataFrame(x_data_test_2_scaled, columns=x_data_test_2.columns)
    peaks_scaled_df = peaks_scaled_df.iloc[:-1]
    # Save the peaks_scaled_df DataFrame to a csv file
    peaks_scaled_df.to_csv(local_path+'peaks_scaled_data.csv', index=False)


def predict(ecg_path):
    # load the trained model
    model_path= "C:\\Users\\Omar Saad\\Desktop\\Final IoT\\ECG_Detection\\trained_model.pkl"
    file = open(model_path, 'rb')
    loaded_model = pickle.load(file)
    file.close() 
    # extract ECG Features
    extract_features(ecg_path)
    # Load the CSV file into a DataFrame
    ecg_features = pd.read_csv(local_path+'peaks_scaled_data.csv')
    ecg_features = ecg_features[['ECG_P_Peaks',	'ECG_T_Peaks',	'ECG_R_Peaks',	'ECG_S_Peaks',	'ECG_Q_Peaks']]
    prediction = loaded_model.predict(ecg_features)
    # print(prediction)
    for window in prediction:
        if window == "arrhythmia":
            prediction = "With arrhythmia"
            break
        else:
            prediction = "NO arrhythmia"
    return prediction