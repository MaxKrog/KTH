def falling_distance(tid):
	tidSquared = tid * tid
	return 9.82 * tidSquared/2

def main():
	for n in range(1,10):
		print(str(n)  + ":" + str(falling_distance(n)))