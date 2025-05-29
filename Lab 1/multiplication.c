#include <stdio.h>

int main() {
    int id, num;

    printf("My ID= ");
    scanf("%d", &id);

    printf("Enter any number for multilitcation= ");
    scanf("%d", &num);
    printf("Multiplication= %d * %d = %d\n", id, num, id * num);
    
        return 0;
}
