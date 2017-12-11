# -*- coding: utf-8 -*-
# diamond-accounting (c) Ian Dennis Miller


def main(quantity=1):
    print("hello world!")
    print("quantity started out as {0}".format(quantity))
    quantity += 1
    print("now quantity is {0}".format(quantity))
    return(quantity)

if __name__ == '__main__':
    main(1)
