import random


def gen_time():
    return f"{random.randint(0, 23)}:{random.randint(0, 59)}:{random.randint(0, 59)}"


def gen_tuple():
    s = "("
    s += f"{random.randint(1, 15)}, "
    s += f"{gen_time()}, "
    s += f"{gen_time()}),"
    return s


for i in range(30):
    print(gen_tuple())
