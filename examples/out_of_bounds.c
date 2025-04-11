#include <stdlib.h>
#include <stdio.h>

int main() {
  int i = 0;
  int a[2];
  a[-1] = 1000000;
  printf("&i = %p\n", &i);
  printf("&a = %p\n", &a);
  printf("i = %d\n", i);
  return EXIT_SUCCESS;
}
