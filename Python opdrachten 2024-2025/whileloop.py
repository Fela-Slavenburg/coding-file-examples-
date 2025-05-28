Frederiek = 0
Tim = 0 
while True:
    stem = input("Frederiek of Tim").lower()
    if stem == "uitslag":
        break
    elif stem == "frederiek":
        Frederiek += 1
    elif stem == "tim":
        Tim += 1

if Frederiek > Tim:
    print("Frederiek heeft gewonnen!!")
elif Tim > Frederiek:
    print("Tim heeft gewonnen!!")
else:
    print("Het is gelijk!!")
