#include "uart.h"
#include "fat.h"
#include "small_printf.h"

#include "soundhw.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>


fileTYPE *file;

char string[]="Hello world!\n";

static struct stat statbuf;


char *LoadFile(const char *filename)
{
	char *result=0;
	int fd=open(filename,0,O_RDONLY);
	printf("open() returned %d\n",fd);
	if((fd>0)&&!fstat(fd,&statbuf))
	{
		int n;
		printf("File size is %d\n",statbuf.st_size);
		result=(char *)malloc(statbuf.st_size);
		if(result)
		{
			if(read(fd,result,statbuf.st_size)<0)
			{
				printf("Read failed\n");
				free(result);
				result=0;
			}
		}
	}
	return(result);
}


int main(int argc, char **argv)
{
	char *modptr;
	modptr=LoadFile("drumloopraw");
//	mt_init(0x10000);
//	mt_music();
	REG_SOUNDCHANNEL[0].DAT=modptr;
	REG_SOUNDCHANNEL[0].LEN=statbuf.st_size/2;
	REG_SOUNDCHANNEL[0].VOL=63;
	REG_SOUNDCHANNEL[0].PERIOD=200;
	return(0);
}