#!/bin/bash

# color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
WHITE='\033[0;37m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
TURQUOISE='\033[0;36m'
GRAY='\033[0;90m'
NC='\033[0m'

vendor1=(1 2 3 4 5 6)
vendor2=(9 9 9 9 9 9)
vendor3=(2 2 2 21 1 1)
vendor4=(1 23 1 233 0)

opcion1() {
    for i in {1..4}; do
       eval "echo \${vendor$i[@]}"
    done
}

opcion2() {
    suma=0
    echo -ne "${YELLOW}[+] Seleccione vendor (1-4): ${NC}"
    read res

    if [ -z $res ]; then
        echo -e "${RED}[!] No ha introducido un vendor"
        exit 1
    fi
    
    eval "vendor=(\${vendor$res[@]})"

    for i in $(seq 0 ${#vendor[@]}); do
        suma=$((suma + vendor[i]))
    done
    echo -e "${GREEN}[!] La media es $((suma / ${#vendor[@]}))${NC}"
}

opcion3() {
    for i in {1..4}; do
        eval "vendor=(\${vendor$i[@]})"
        echo -e "\n${GREEN}[+] vendor$i: ${NC}"
        for j in "${!vendor[@]}"; do
            if [[ "${vendor[j]}" -le '3' ]]; then
                echo -ne "${PURPLE} ${vendor[j]}.000 euros${NC}"
            fi
        done 
    done
    echo ""
}

main() {
    while true; do
        echo -e "\n${BLUE}Seleccione operacion${NC}"
        echo -e "${TURQUOISE}1: Listado completo${NC}"
        echo -e "${TURQUOISE}2: Valor total anual${NC}"
        echo -e "${TURQUOISE}3: Buscar vendedor <3k${NC}"
        echo -e "${TURQUOISE}q: salir${NC}"

        read -p "respuesta: " respuesta

        case $respuesta in
            '1') opcion1
            ;;
            '2') opcion2
            ;;
            '3') opcion3
            ;;
            'q') exit
            ;;
        esac
    done
}

main
