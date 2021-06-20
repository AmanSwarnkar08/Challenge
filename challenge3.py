# Author: Aman Swarnkar


def get_value(key, var):
    '''
    This function takes key and an object as its arguments
    and returns the value in the object of the passed key.
    '''
    for k, v in var.items():
        if k == key:
           yield v
        if isinstance(v, dict):
            for result in get_value(key, v):
                yield result

if __name__ == '__main__':
    var = {"a":{"b":{"c":"d"}}}
    key='b'
    print(list(get_value(key,var)))