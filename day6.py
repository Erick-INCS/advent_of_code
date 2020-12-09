with open("day6_input.txt", "rt") as file:
    file = file.read().strip().split('\n\n')
    
print(sum(len(set(g.replace('\n', ''))) for g in file))