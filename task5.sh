#!/bin/bash

RED='\e[31m'
GREEN='\e[32m'
RESET='\e[0m'

declare -i step_count=1
declare -i hit_count=0
declare -i miss_count=0
declare -a numbers_colored

while :
do
    random_number=${RANDOM: -1}
    echo "Step:" ${step_count}

    read -rp "Please enter number from 0 to 9 (q - quit): " input

    case "${input}" in
        [0-9])
            if [[ "${input}" == "${random_number}" ]]
                then
                    echo -e "Hit! My number:" ${random_number}
                    hit_count=$((hit_count+1))
                    random_number_colored="${GREEN}${random_number}${RESET}"
                else
                    echo -e "Miss! My number:" ${random_number}
                    miss_count=$((miss_count+1))
                    random_number_colored="${RED}${random_number}${RESET}"
            fi
            numbers_colored+=("${random_number_colored}")
        ;;
        q)
            break
        ;;
        *)
            echo -e "Not valid input. Please repeat. \n"
            continue
        ;;
    esac

    hit_percent=$((hit_count*100/(hit_count + miss_count)))
    miss_percent=$((100-hit_percent))
    echo "Hit: ${hit_percent}%" "Miss: ${miss_percent}%"

    numbers_colored_length=${#numbers_colored[@]}
    numbers_colored_length=$(( numbers_colored_length < 10 ? numbers_colored_length : 10 ))

    echo -e "Numbers: ${numbers_colored[*]: -numbers_colored_length}"
    echo -e ""

    step_count=$((step_count+1))
done