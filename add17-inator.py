toAdd = []
addedNum = ""
num = int(input("What’s the number you wanna add?\n"))
for char in toAdd:
    charStart = ""

    #Checks if the two digits are numbers
    if str(char).isdigit() == False:
        charStart = str(char[:1])
        charEnd = str(char[1-2])

        #Sums 17 and adds to string
        charStart = int(charStart) + num 
        addedNum=str(addedNum+" "+str(charStart)+str(charEnd))
    else:
        #Sums 17 and adds to string
        char = int(char) + num 
        addedNum=str(addedNum+" "+str(char))
    
#Prints ending
print(addedNum)
