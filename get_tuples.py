import random
tuples = []
for i in range(30):
    t = f"({random.randint(1, 15)}, {random.randint(1, 3)}"
    while t in tuples:
        t = f"({random.randint(1, 15)}, {random.randint(1, 3)}"
    print(f"{t}, {random.randint(500,5000)}),")
    tuples.append(t)
