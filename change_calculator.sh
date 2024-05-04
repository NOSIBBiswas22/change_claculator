#!/bin/bash

# Colors
GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Welcome message
echo -e "${GREEN}=== Change Calculator ===${NC}"

# Function to validate numeric input
validate_input() {
    local input=$1
    if ! [[ $input =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
        echo -e "${RED}Error: Invalid input. Please enter a valid number.${NC}"
        return 1
    fi
}

# Function to calculate change
calculate_change() {
    local product_price=$1
    local quantity=$2
    local amount_given=$3

    # Validate inputs
    validate_input "$product_price" || return 1
    validate_input "$quantity" || return 1
    validate_input "$amount_given" || return 1

    # Calculate total cost
    total_cost=$(awk "BEGIN { printf \"%.2f\", $product_price * $quantity }")

    # Calculate change
    change=$(awk "BEGIN { printf \"%.2f\", $amount_given - $total_cost }")

    # Print change
    echo -e "Change: ${GREEN}$change${NC} taka"
}

# Function for loading animation
loading_animation() {
    local animation_frames="/ - \\ |"
    for frame in $animation_frames; do
        echo -ne "Calculating... $frame\r"
        sleep 0.1
    done
    echo -ne "\033[K"  # Clear the line
}
clear
# Main program
while true; do
    echo " "
    read -p "Enter the price of the product (or 'q' to quit): " product_price
    if [[ "$product_price" == "q" ]]; then
        echo "Exiting..."
        exit 0
    fi

    read -p "Enter the quantity: " quantity
    read -p "Enter the amount given to the shopkeeper: " amount_given
    echo " "
    loading_animation
    calculate_change "$product_price" "$quantity" "$amount_given"
    echo "------------------------------------------"
    echo " "
done
