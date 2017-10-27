import os
import csv

filepath = os.path.join("text.rtf")

fname = input("Enter file name: ")
 
num_words = 0
 
with open(fname, 'r') as f:
    for line in f:
        words = line.split()
        num_words += len(words)
print("Number of words:")
print(num_words)

sentences = 0
for stop in fname:
    sentences = sentences + len(stop.split('.'))
print ('Number of sentences:', sentences)

letter = 0
for stop in fname:
    letter = letter =+ len(line)
         
print('Number of letters', letter)

slength = 0
for line in fname:
    slength = sum(len(stop.split()) for line in words) / len(words)

print('Average Sentence Length', slength)