def left_factoring(production):
    # Example input: A->abc|abd
    head, body = production.split("->")
    part1, part2 = body.split("|")

    # Find common prefix
    prefix = ""
    pos = 0
    for i in range(min(len(part1), len(part2))):
        if part1[i] == part2[i]:
            prefix += part1[i]
            pos = i + 1
        else:
            break

    # Modified grammar
    modifiedGram = prefix + "X"
    newGram = part1[pos:] + "|" + part2[pos:]

    print("\nAfter Left Factoring:")
    print(f"{head}->{modifiedGram}")
    print(f"X->{newGram}")


if __name__ == "__main__":
    production = input("Enter Production (Example: A->abc|abd): ")
    left_factoring(production)

