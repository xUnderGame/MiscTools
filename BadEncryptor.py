import random
import string

firststr = "centersouthpillar"
newstr = ""

for char in firststr:
    newstr = newstr+char
    for gibber in range(11):
        newstr = str(newstr+random.choice(string.ascii_letters))
print(newstr)
input(">")
