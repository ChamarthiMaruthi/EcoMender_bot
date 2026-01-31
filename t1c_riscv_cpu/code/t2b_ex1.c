// t2b_ex1.c - Sum of Natural Numbers

typedef unsigned char uint8_t;

// Memory-mapped addresses
#define N_ADDR        ((volatile uint8_t *)0x02000000)
#define SUM_ADDR      ((volatile uint8_t *)0x02000004)
#define CPU_DONE_ADDR ((volatile uint8_t *)0x02000008)

// Forward declaration
int main();

// Entry point - MUST BE FIRST in .text section
void _start() __attribute__((section(".text.start")));

void _start() {
    main();
    while(1);  // Infinite loop after main returns
}

// Dummy function (compiler might optimize away if not used)
void _put_value(uint8_t val) {
    volatile uint8_t temp = val;  // Just to prevent optimization
}

void _put_str(char *str) {
    // Do nothing
}

int main() {
    volatile uint8_t *N = N_ADDR;
    volatile uint8_t *SUM = SUM_ADDR;
    volatile uint8_t *CPU_DONE = CPU_DONE_ADDR;

    *SUM = 0;  // Initialize SUM to 0
    
    for (uint8_t i = 1; i <= *N; i++) {
        *SUM = *SUM + i;
        _put_value(*SUM);  // Call dummy function
    }
    
    *CPU_DONE = 1;
    return 0;
}
