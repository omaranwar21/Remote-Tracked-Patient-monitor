csv_data = []

with open ("ecg_simulated.csv", "r") as file:
  # print("File Opened")
  for line in file:
    # print(line)
    line = line.rstrip ("\n").rstrip ("\r")
    csv_data.append (float(line))
    # print("*"*50)
    print(len(csv_data))

print(csv_data)
