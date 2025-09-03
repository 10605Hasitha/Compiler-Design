# LL(1) Parser in Python

MAX = 100

# Non-terminals and Terminals
nts = "EATBF"
ts = "i+*()$"

# Parse table (same as C program)
table = [
    #      i       +       *       (       )       $
    ["TA",   "",     "",    "TA",    "",    ""],   # E
    ["",   "+TA",   "",     "",    "e",   "e"],   # A
    ["FB",   "",     "",    "FB",    "",    ""],   # T
    ["",    "e",   "*FB",   "",    "e",   "e"],   # B
    ["i",    "",     "",   "(E)",   "",    ""]    # F
]

def idx(c, s):
    """Get index of symbol c in string s"""
    try:
        return s.index(c)
    except ValueError:
        return -1

def main():
    stack = []
    stack.append('$')
    stack.append('E')

    # Input string
    input_str = input("Enter input string: ").strip()
    input_str += "$"

    ip = 0  # input pointer

    print("\nStack\t\tInput\n-----\t\t-----")

    while stack:
        # Print stack and remaining input
        print("".join(stack), "\t\t", input_str[ip:])

        X = stack[-1]  # top of stack
        a = input_str[ip]  # current input symbol

        if X == a:  # match terminal
            stack.pop()
            ip += 1
        elif X in ts:  # terminal mismatch
            print("\nFAILURE")
            return
        else:
            r, c = idx(X, nts), idx(a, ts)
            if r < 0 or c < 0 or table[r][c] == "":
                print("\nFAILURE")
                return
            stack.pop()
            prod = table[r][c]
            if prod != "e":  # push RHS in reverse order
                for ch in reversed(prod):
                    stack.append(ch)

    if ip == len(input_str):
        print("\nSUCCESS")
    else:
        print("\nFAILURE")

if __name__ == "__main__":
    main()

