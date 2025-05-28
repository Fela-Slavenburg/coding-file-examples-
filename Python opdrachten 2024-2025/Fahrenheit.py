#Fahrenheit
Fahrenheit = float(input("Geef een Fahrenheit temperatuur op "))

def temperatuur(Fahrenheit):
    Celsius = round((Fahrenheit - 32) / 1.8, 1)
    return (Fahrenheit, " graden Fahrenheit? Dat is hetzelfde als", Celsius, "graden Celcius!")

print(temperatuur(Fahrenheit))

#Celsius
Celsius = float(input("Geef een Celsius temperatuur op "))

def temperatuur(Celsius):
    Fahrenheit = round((Celsius * 1.8) + 32, 1)
    return (Celsius, " graden Celsius? Dat is hetzelfde als", Fahrenheit, "graden Fahrenheit!")

print(temperatuur(Celsius))