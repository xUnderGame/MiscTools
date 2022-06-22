text = """hola"""
checked = ""
addChar = ""
errors = 0
doCheck = False
for char in text:
    if doCheck == True and char not in [""," "]:
        addChar = "None"
    else:
        doCheck = False
        addChar = char
        if char in [",","."]:
            errors = errors + 1
            print("Total Errors: "+str(errors))
            doCheck = True
    if addChar != "None":
        checked = checked+addChar
print("----------------\n"+checked+"\n----------------")
