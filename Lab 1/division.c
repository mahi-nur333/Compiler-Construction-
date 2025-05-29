#include <stdio.h>

int main() {
    int id, num;

    printf("My ID= ");
    scanf("%d", &id);

    printf("Enter any number for Division= ");
    scanf("%d", &num);
       if (num != 0) {
        printf("Division: %d / %d = %.2f\n", id, num, (float)id / num);
    } else {
        printf("Division: Cannot divide by zero.\n");
    }
    
    return 0;
}
