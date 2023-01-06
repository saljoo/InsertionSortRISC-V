# Insertion sort algorithm to sort the given array
# using RISC-V assembly-language.
# Values and size of the array are hardcoded into the code
# but can easily be modified by user

# Size of the array. User can modify this based on the size of
# the array. Last parameter determines the size
addi a2, x0, 8

# Add values to temporary register and store values into
# memory address at 0x0
addi t0, x0, 10
sw t0, 0(a0)
addi t0, x0, 8
sw t0, 4(a0)
addi t0, x0, 5
sw t0, 8(a0)
addi t0, x0, 25
sw t0, 12(a0)
addi t0, x0, 34
sw t0, 16(a0)
addi t0, x0, 2
sw t0, 20(a0)
addi t0, x0, 48
sw t0, 24(a0)
addi t0, x0, 19
sw t0, 28(a0)
  
# Let’s use register s11 to keep count what memory address should be
# accessed to get the next value to be compared
addi s11, x0, 4
# Let’s use register s10 to keep count how many numbers have been sorted
# and exit loop when all numbers are in correct order
addi s10, x0, 1

# Start sorting algorithm
jal x0, INSERTIONSORT
jal x0, EXIT

INSERTIONSORT:
# Let’s use register a1 to access correct memory locations and load
# correct numbers that will be compared
add a1, x0, s11
lw t1, 0(a1)
addi a1, a1, -4
lw t2, 0(a1)
# Check if number in register t1 is smaller than number in register t2
# If true, jump to SWAP algorithm
BLT t1, t2, SWAP
# If numbers are in correct order, increase the counters
addi s11, s11, 4
addi s10, s10, 1
# If all numbers are in correct order, jump to EXIT
# Else call INSERTIONSORT recursively
BEQ s10, a2, EXIT
jal x0, INSERTIONSORT

# Part of the algorithm that will be executed if SWAP is done and
# smaller number is not placed in the first memory location
# Works in the same way as INSERTIONSORT but register a1 is not
# updated to match register s11
SORT:
lw t1, 0(a1)
addi a1, a1, -4
lw t2, 0(a1)
BLT t1, t2, SWAP
addi s11, s11, 4
addi s10, s10, 1
# If all numbers are in correct order, exit program
# Else call INSERTIONSORT recursively
BEQ s10, a2, EXIT
jal x0, INSERTIONSORT

# Algorithm that switches the places of two numbers
SWAP:
addi a1, a1, 4
sw t2, 0(a1)
addi a1, a1, -4
sw t1, 0(a1)
# Jump to INCREASE_COUNT if smaller number is placed in the
# first memory location
BEQ a1, x0, INCREASE_COUNT
jal x0, SORT

# Increases value of the register s11 in case the algorithm has found
# the smallest number so far
INCREASE_COUNT:
addi s11, s11, 4
addi s10, s10, 1
# Check if all the numbers have been sorted and jump to EXIT if true
BEQ s10, a2, EXIT
jal x0, INSERTIONSORT

EXIT: