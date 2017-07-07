/* MIT License

Copyright (c) 2017 catch22eu

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/


#include "LPC11xx.h"

#define GPIO1DATA		(*((volatile uint32_t *) 0x50013FFC ))
#define GPIO1DIR		(*((volatile uint32_t *) 0x50018000 ))

#define SYSAHBCLKCTRL	(*((volatile uint32_t *) 0x40048080 ))

int main(void)
{
//	LPC_SYSCON->SYSAHBCLKCTRL |= (1<<6) | (1<<16);
//	SYSAHBCLKCTRL |= (1<<6) + (1<<16);
	
	// set pin 5 of GPIO1 as output 
	GPIO1DIR |= (1 << 5);
	
//	GPIO1DATA |= (1 << 5);
	while(1)
	{
		// toggle bit 5 of GPIO1
		GPIO1DATA ^= (1 << 5);
		//wait loop
		for (int i=0; i<1000000;i++); 
	}
}

