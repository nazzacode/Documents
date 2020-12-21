
#code to predict wether a passenger on the titanic survived
import numpy
import pandas
import statsmodels.api as sm

def simple_heuristic(file_path):

    predictions = {}
    df = pandas.read_csv(file_path)

    for passenger_index, passenger in df.iterrows():
        passenger_id = passenger['PassengerId']

       # Your code here:
        if (passenger['Sex'] == 'female') \
        | ((passenger['Pclass'] == 1) & (passenger['Age'] < 18)):
            predictions[passenger_id] = 1
        else:
            predictions[passenger_id] = 0


    return predictions

print(simple_heuristic("C:\\Users\\Nathan Sharp\OneDrive - University of Edinburgh\\Year 1\\Computing\\Udacity - Intro to Data Science\\titanic-data (1).csv"))
