def is_prime(num):
	if(num <= 1):
		return False

	for n in range(2,num - 1):
		if(num % n == 0):
			return False
	return True

def primes(start,slut):
	start = int(start)
	slut = int(slut)
	if( slut < start):
		temp = slut
		slut = start
		start = temp


	retList=[]
	for n in range(start,slut):
		if(is_prime(n)):
			retList.append(n)

	return retList

def main():
	start = input("Starttal")
	slut = input("Sluttal")
	print(primes(start,slut))

main()

