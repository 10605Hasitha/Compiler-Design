def remove_left_recursion(production):
    # Example: E->E+T|T
    left = production[0]   # Left-hand side non-terminal
    rhs = production[3:]   # Skip "X->"
    
    parts = rhs.split("|")  # Split alternatives
    
    alpha = ""
    beta = ""
    
    if parts[0][0] == left:
        # Left recursive
        alpha = parts[0][1:]   # Remove left from left-recursive part
        beta = parts[1]        # Non-left recursive part

        print("\nGiven production is LEFT RECURSIVE")
        print("Grammar without left recursion:")
        print(f"{left} -> {beta}{left}'")
        print(f"{left}' -> {alpha}{left}' | ε")
    else:
        print("\nProduction is NOT left recursive.")


if __name__ == "__main__":
    production = input("Enter production (like E->E+T|T): ")
    remove_left_recursion(production)

