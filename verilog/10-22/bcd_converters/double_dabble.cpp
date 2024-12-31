#include <ios>
#include <iostream>
#include <bitset>

const int BIN_SIZE = 8;
const int BCD_SIZE = 4;
const int BCD_DIGITS = 3;

void printBits(std::bitset<20> bits, int n) {
	for (int i = n - 1; i >= 0; --i) {
        std::cout << bits[i];
    }
}

void printStep(std::bitset<20> bits) {
	std::bitset<20> a = bits & std::bitset<20>("11110000000000000000");
	std::bitset<20> b = bits & std::bitset<20>("1111000000000000");
	std::bitset<20> c = bits & std::bitset<20>("111100000000");
	a = a >> 16;
	b = b >> 12;
	c = c >> 8;

	std::bitset<20> lower = bits & std::bitset<20>("11111111");

	printBits(a, 4); 
	std::cout << " ";
	printBits(b, 4); 
	std::cout << " ";
	printBits(c, 4); 
	std::cout << " ";
	printBits(lower, 8); 
	std::cout << "\n";

	unsigned int full = bits.to_ulong();
	std::cout << std::hex << full << "\n\n";
}

void doubleDabble(std::bitset<20> bits) {
	printStep(bits);

	for(int i = 0; i < 8; i++) {		
		std::bitset<20> a = bits & std::bitset<20>("11110000000000000000");
		std::bitset<20> b = bits & std::bitset<20>("1111000000000000");
		std::bitset<20> c = bits & std::bitset<20>("111100000000");
		a = a >> 16;
		b = b >> 12;
		c = c >> 8;

		std::bitset<20> lower = bits & std::bitset<20>("11111111");

		unsigned int a_int = a.to_ulong();
		unsigned int b_int = b.to_ulong();
		unsigned int c_int = c.to_ulong();	
	
		if(a_int >= 5) a_int += 3;
		if(b_int >= 5) b_int += 3;
		if(c_int >= 5) c_int += 3;
	
		a = (std::bitset<20>(a_int) & std::bitset<20>("1111")) << 16;
		b = (std::bitset<20>(b_int) & std::bitset<20>("1111")) << 12;
		c = (std::bitset<20>(c_int) & std::bitset<20>("1111")) << 8;
		bits = lower | a | b | c;
		
		bits = bits << 1;

		printStep(bits);
	}
}

int main() {
	int num;
	std::cout << "Enter number: ";
	std::cin >> num;

	if(num > 255) {
		std::cout << "Too big, exiting...";
		return 0;
	}

	std::bitset<20> bits = num;
	doubleDabble(bits);
	
	return 0;
}
