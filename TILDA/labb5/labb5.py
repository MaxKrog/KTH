from modules import HashTableDict

choice = " "
while not choice == "":
	choice = input("Atombeteckning (lämna tomt för att avsluta) : ")

	if not choice == "":
		try:
			print(hashtabell.get(choice))
		except KeyError:
			print("Atom finns icke.")


