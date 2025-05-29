#include <stdio.h>

int main() {
    int id, num;

    printf("My ID= ");
    scanf("%d", &id);

    printf("Enter any number for substraction= ");
    scanf("%d", &num);
     printf("Subtraction= %d - %d = %d\n", id, num, id - num);
     
         return 0;
}
