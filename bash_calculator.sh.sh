#!/bin/bash

#Checking whether the numbers entered are valid
validate() {
    local input="$1"
    if [[ "$input" =~ ^-?[0-9]+$ ]]; then
        return 0
    else
        return 1
    fi
}

#Checking whether the result is a prime number
is_a_prime_number () {
    local num="$1"
    if (( num <= 1 )); then
        echo "$num: is not a prime"
        return
    fi
    if (( num == 2 )); then
        echo "$num: is a prime"
        return
    fi
    if (( num % 2 == 0 )); then
        echo "$num: is not a prime"
        return
    fi
    max=$(( num / 2 ))
    for (( i=3; i <= max; i+=2 )); do
        if (( num % i == 0 )); then
            echo "$num: is not a prime"
            return
        fi
    done
    echo "$num: is a prime"
}

#Checking whether the result is an even number
check_even_odd () {
    local num="$1"
    if (( num % 2 == 0 )); then
        echo "$num: is even"
    else
        echo "$num: is odd"
    fi  
}

#Checking whether the result is a number divisible by five
is_divisible_by_five() {
    local num="$1"
    if (( num % 5 == 0 )); then
        echo "$num: is divisible by five"
    else
        echo "$num: is not divisible by five"
    fi  
}

#Calculator operations
calculator () {
    options=("add" "subtract" "multiply" "divide" "power_of" "modulos" "exit")

    while true; do
        echo "Choose from the menu"

        select i in "${options[@]}"; do
            case $i in
                "add"|"subtract"|"multiply"|"divide"|"power_of"|"modulos")

                read -p "Enter your operation (e.g., 10+5): " input
                num1=$(echo "$input" | awk -F'[^0-9]+' '{print $1}')
                op=$(echo "$input" | awk -F'[0-9]+' '{print $2}')
                num2=$(echo "$input" | awk -F'[^0-9]+' '{print $2}')

                    if validate "$num1" && validate "$num2"; then
                        
                        case $i in
                            "add")
                                res=$(echo "$num1 + $num2" | bc);;
                            "subtract")
                                res=$(echo "$num1 - $num2" | bc);;
                            "multiply")
                                res=$(echo "$num1 * $num2" | bc);;
                            "divide")
                                if [ "$num2" -eq 0 ]; then
                                    echo "Cannot divide by zero"
                                    break
                                fi
                                res=$(echo "scale=2; $num1 / $num2" | bc);;
                            "power_of")
                                res=$(echo "$num1 ^ $num2" | bc);;
                            "modulos")
                                res=$(echo "$num1 % $num2" | bc);;
                        esac

                        echo "The answer is: $res"

                        is_a_prime_number $res
                        check_even_odd $res
                        is_divisible_by_five $res
                    else
                        echo "Invalid numbers, please enter valid numbers"
                    fi
                    echo
                    break;;
                "exit")
                    echo "Goodbye"
                    return 0;;
                *)
                    echo "Try again"
                    echo
                    break;;
            esac
        done
    done
}

calculator
