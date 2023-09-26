
"""
A couple of creative tools in a scuffed TUI!
"""

import random

OS_FILENAME = "oblique_strategies.txt"

def cast_i_ching_coins():
    coin_vals = [2, 3]
    casts = [random.choice(coin_vals) for x in range(3)]
    cast_sum = sum(casts)
    broken = cast_sum in [6, 8]
    changing = cast_sum in [6, 9]
    return (broken, changing)


def i_ching_cast_to_line(broken):
    if broken:
        return "- -"
    else:
        return "---"

        
def i_ching_cast_to_line_chg(broken, changing):
    if changing:
        return i_ching_cast_to_line(not broken)
    else:
        return i_ching_cast_to_line(broken)


def generate_i_ching_hexagram():
    lines = [cast_i_ching_coins() for x in range(6)]
    lines.reverse()
    changing_cnt = sum([x[1] for x in lines])
    return (lines, changing_cnt > 0)


def print_i_ching_hexagram(lines, contains_changing):
    print('main:')
    for brk, chg in lines:
        print(i_ching_cast_to_line(brk)) 

    if contains_changing:
        print()
        print('relation:')
        for brk, chg in lines:
            print(i_ching_cast_to_line_chg(brk, chg))


def main():
    with open(OS_FILENAME , "r") as stream:
        try:
            lines = stream.readlines()
            os_lines = [line.strip() for line in lines]
        except:
            print("file not found: {}".format(OS_FILENAME))

    choice = 99
    while choice != 0:
        print("*** Eno ***")
        print("1) select oblique strategy")
        print("2) cast I Ching coins")
        print("0) exit")
        print()
        choice = int(input())
        print()

        if choice == 1:
            print(random.choice(os_lines), '\n')
        elif choice == 2:
            hex_lines, contains_chg = generate_i_ching_hexagram()
            print_i_ching_hexagram(hex_lines, contains_chg)


if __name__ == "__main__":
    main()

