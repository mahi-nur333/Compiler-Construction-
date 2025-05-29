#include <stdio.h>

int main() {
    int id, num;

    printf("My ID= ");
    scanf("%d", &id);

    printf("Enter any number for addition= ");
    scanf("%d", &num);

    printf("Addition= %d + %d = %d\n", id, num, id + num);

    return 0;
}