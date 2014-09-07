#include "osd.h"
#include "uart.h"
#include "small_printf.h"


static int row, col;

void OSD_Scroll()
{
	int i;
	volatile unsigned char *p1,*p2;
	p1=OSD_CHARBUFFER;
	p2=OSD_CHARBUFFER+32;
	printf("Scrolling %d, %d\n",(int)p1,(int)p2);
	for(i=0;i<(512-32);++i)
	{
		*p1++=*p2++;
	}
	for(i=0;i<32;++i)
		*p1++=' ';
}


void OSD_Putchar(int c)
{
	while(row>15)
	{
		OSD_Scroll();
		--row;
	}
	if(c=='\n')
	{
		for(;col<32;++col)
			OSD_CHARBUFFER[(row<<5)+col]=' ';
		col=0;
		++row;
	}
	else
	{
		OSD_CHARBUFFER[(row<<5)+col]=c;
		col++;
	}
	if(col==32)
	{
		col=0;
		++row;
	}
}


void OSD_Puts(char *str)
{
	int c;
	while((c=*str++))
		OSD_Putchar(c);
}


int pixelclock;

void ShowOSD()
{
	int hf, vf;
	int hh,hl,vh,vl;
	int enable=1;
	hf=HW_OSD(REG_OSD_HFRAME);
	vf=HW_OSD(REG_OSD_VFRAME);

	printf("%x, %x\n",hf, vf);

	// Extract width of frame (hh) and sync pulse (hl)
	hh=hf>>8;
	hl=hf&0xff;
	if(hh<hl)	// Might need to swap, depending on sync polarity
	{
		hl=hh;
		hh=hf&0xff;
		enable|=2; // Flip HSync polarity
	}

		
	// Extract height of frame (vh) and sync pulse (vl)
	vh=vf>>8;
	vl=vf&0xff;
	if(vh<vl)	// Might need to swap, depending on sync polarity
	{
		vl=vh;
		vh=vf&0xff;
		enable|=4; // Flip VSync polarity
	}

	hh<<=2+pixelclock;
	vh<<=3;

	pixelclock=2;
	HW_OSD(REG_OSD_PIXELCLOCK)=(1<<pixelclock)-1;

	printf("Frame width is %d, frame height is %d\n",hh,vh);

	hl=((hh-100)-80)/2;
	vl=((vh-60)-48)/2;

	printf("OSD Offsets: %d, %d\n",hl,vl);

	HW_OSD(REG_OSD_ENABLE)=enable;
	HW_OSD(REG_OSD_XPOS)=-hl;
	HW_OSD(REG_OSD_YPOS)=-vl;
}


void wait()
{
	int t;
	int i;
	for(i=0;i<100000;++i)
		t=HW_OSD(REG_OSD_VFRAME);
}


int main(int argc, char **argv)
{
	int i;

	printf("OSD Test\n");

	ShowOSD();
	wait();
	ShowOSD();

	OSD_Puts("Hello, world!\n");
	OSD_Puts("Line 1!\n");
	OSD_Puts("Line 2!\n");
	OSD_Puts("Line 3!");
	OSD_Puts("Line 4!\n");
	OSD_Puts("Line 5!\n");
	OSD_Puts("Line 6!\n");
	OSD_Puts("Line 7!\n");
	OSD_Puts("Line 8!\n");
	OSD_Puts("Line 9!\n");
	OSD_Puts("Line 10!\n");
	OSD_Puts("Line 11!\n");
	OSD_Puts("Line 12!\n");
	OSD_Puts("Line 13!\n");
	OSD_Puts("Line 14!\n");
	OSD_Puts("Line 15!\n");
	OSD_Puts("Line 16!\n");
	OSD_Puts("Line 17!\n");

	ShowOSD();

	return(0);
}

