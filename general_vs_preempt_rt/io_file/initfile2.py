for i in range(10):
    with open("input" + str(i), "w") as f:
        for i in range(500000):
            f.write("a")
