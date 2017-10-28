import os
import csv

data1 = os.path.join("employee_data1.csv")
data2 = os.path.join("employee_data2.csv")

#Lists storing data

Emp_ID = []
first_name = []
last_name = []
DOB = []
SSN = []
state = []

with open(data1, newline="") as csvfile:
    csvreader= csv.reader(csvfile, delimiter=",")
    for row in csvreader:

        cleaned_csv = zip(Emp_ID, first_name, last_name, DOB, SSN,state)
        print(cleaned_csv)

output_file = os.path.join("web_final.csv")

with open(output_file, "w", newline="") as datafile:
    writer = csv.writer(datafile)

    writer.writerow(["Emp ID", "First Name", "Last Name", "DOB",
                     "SSN", "State"])

    

    writer.writerows(cleaned_csv)