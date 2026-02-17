#include <stdio.h>
#include <stdlib.h>

int main()
{
    int i = 0;
    int a[2];
    a[-1] = 1000000;
    a[2] = -1000000;
    printf("&i = %p\n", &i);
    printf("&a = %p\n", &a);
    printf("i = %d\n", i);
    return EXIT_SUCCESS;
}
