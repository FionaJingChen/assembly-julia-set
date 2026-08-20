#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

# include <sys/types.h>
# include <sys/stat.h>
#include <sys/mman.h>
# include <fcntl.h>

#define FRAME_WIDTH    640
#define FRAME_HEIGHT   480
# define FRAME_BUFFER_DEVICE "/dev/fb0"

extern char **name();
extern int **id();
extern void drawJuilaSet(int cX, int cY, int width, int height, int16_t(*frame)[FRAME_WIDTH]);

int main()
{
    int16_t frame[FRAME_HEIGHT][FRAME_WIDTH];

    int min_cY =270;
    int cY_step = -5;
    int cX = -700;
    int cY;
    int fd;
    char **aname;
    int **intdata;


    printf("Function1: Name\n");
    aname = name();
    printf("Function2: ID\n");
    intdata = id();

    printf("Main Function:\n");
    printf("*****Print All*****\n");
    printf("%s", aname+12);
    printf("%d %s", *(intdata+1), aname+16);
    printf("%d %s", *(intdata+2), aname+20);
    printf("%d %s", *(intdata+3), aname+24);
    printf("ID Summation = %d\n", *intdata+0);
    printf("*****End Print*****\n");

    printf( "\n***** Please enter p to draw Juila Set animation *****\n");

    while(getchar()!='p'){};

    system("clear");

    fd = open(FRAME_BUFFER_DEVICE,(O_RDWR|O_SYNC));

    if(fd < 0 )
    {printf("Frame Buffer Device Open Error!!\n");}
    else{
        for ( cY = 400; cY >= min_cY ; cY = cY + cY_step)
        {
            drawJuilaSet(cX,cY,FRAME_WIDTH,FRAME_HEIGHT,frame);

            write(fd,frame,sizeof(int16_t)*FRAME_HEIGHT*FRAME_WIDTH);

            lseek(fd,0,SEEK_SET);
        }

        printf(".*.*.*.<:: Happy New Year ::>.*.*.*.\n");
        printf("by %s", aname+12);
        printf("%d %s", *(intdata+1), aname+16);
        printf("%d %s", *(intdata+2), aname+20);
        printf("%d %s", *(intdata+3), aname+24);
        close(fd);
    }

    while(getchar()!= 'p'){}

    return 0;

}
