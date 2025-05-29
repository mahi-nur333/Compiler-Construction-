#include <stdio.h>

int main() {
    int numbers[5]; 
    int i;

   
    printf("Enter 5 numbers:\n");
    for (i = 0; i < 5; i++) {
        printf("Number %d: ", i + 1);
        scanf("%d", &numbers[i]);
    }

    
    printf("\nYou entered:\n");
    for (i = 0; i < 5; i++) {
        printf("%d ", numbers[i]);
    }

    return 0;
}
