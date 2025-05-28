jaar = int(input("Geef een jaar op? "))

if jaar % 4 != 0:
    print(jaar, "is geen schikkeljaar.")
elif jaar % 100 != 0:
        print(jaar, "is wel schikkeljaar.")
elif jaar % 400 == 0:
        print(jaar, "is wel schikkeljaar.")
else:
       print(jaar, "is geen schikkeljaar.")
