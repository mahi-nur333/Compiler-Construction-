#include <stdio.h>

void displayDetails(char initial, float score) {
    printf("Initial: %c, Score: %.2f\n", initial, score);
}

int main() {
    char nameInitial = 'R';
    float testScore = 88.75;
    displayDetails(nameInitial, testScore);
    return 0;
}
