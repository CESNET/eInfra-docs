#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" modules_matrix """

from __future__ import print_function

import argparse
import csv
import itertools
import json
import os.path
import packaging.specifiers

def arg_parse():
    """
    argument parser
    """
    parser = argparse.ArgumentParser(
        description="Module_matrix"
    )
    parser.add_argument('--json',
                        action='store_true',
                        help="get json")
    return parser.parse_args()

def get_data(filename):
    '''function to read the data form the input csv file to use in the analysis'''
    reader = []  # Just in case the file open fails
    with open(filename, 'r') as fdata:
        reader = csv.reader(fdata, delimiter=',')
        # returns all the data from the csv file in list form
#        print(list(reader))
        return list(reader)  # only return the reader when you have finished.

def get_datalist():
    """ get_datalist """
    datalist = []
    for name in ['karolina', 'dgx', 'barbora']:
        path = os.path.join('scripts', "{}.csv".format(name))
        datalist += get_data(path)
    return datalist

def get_counts(datalist):
    """ get_counts """
    counts = dict()
    for i in datalist:
        counts[i[0]] = counts.get(i[0], 0) + int(i[1])
    return counts

def get_matrix():
    """ get_matrix """
    #     1    2    4    8    16   32
    chars = ['K', 'B', 'D']
    arr = []
    mask = ''.join(reversed(chars))
    for bits in itertools.product([0, 1], repeat=len(chars)):
        sbit = "".join(str(bit) for bit in bits)
        nst = ""
        for i, _ in enumerate(sbit):
            if sbit[i] == "1":
                nst += mask[i]
            else:
                nst += "-"
        arr.append(nst)
    return arr

def get_software(datalist):
    """ get_software """
    matrix = get_matrix()
    counts = get_counts(datalist)
    software = dict()
    prev = ''
    for mat, i in sorted(counts.items()):
        split = mat.split('/')
        if len(split) > 1:
            if split[0] != prev:
                software[split[0]] = {}
            software[split[0]][split[1]] = '`' + matrix[i] + '`'
            prev = split[0]
    return software

def packages_json(software):
    """ packages_json """
    packages = {}
    for module in sorted(software.items(), key=lambda i: i[0].lower()):
        packages[module[0]] = sorted(module[1],
                                     key=packaging.specifiers.LegacyVersion)[len(module[1]) - 1]
    data = {'total': len(packages), 'projects': packages}
    return data

def print_software(software):
    """ print_software """
    versions = ''
    clusters = ''
    for module in sorted(software.items(), key=lambda i: i[0].lower()):
        software = module[0]
        versions = []
        clusters = []
        for key in sorted(module[1].keys(), key=packaging.specifiers.LegacyVersion):
            versions.append(key)
            clusters.append(module[1][key])
        print("| {} | {} | {} |".format(software, '</br>'.join(versions), '</br>'.join(clusters)))
    print()
    print('---8<--- "modules_matrix_search.md"')

def print_hint():
    """ print_hint """
    print('!!! Hint "Cluster Acronyms"')
    print('    ```')
    print('    D B K')
    print('    | | |')
    print('    | | +----> Karolina')
    print('    | +------> Barbora')
    print('    +--------> DGX')
    print('    ```')
    print()
    print("{} {} {}".format('| Module </br><form><input id="searchInput" placeholder="🔍 Filter"',
                            'style="width: 8rem; border-radius: 0.2rem; color: black;',
                            'padding-left: .2rem;"></form> | Versions | Clusters |'))
    print("| ------ | -------- | -------- |")

def main():
    """
    main function
    """
    arg = arg_parse()
    datalist = get_datalist()
    software = get_software(datalist)

    if arg.json:
        print(json.dumps(packages_json(software)))
    else:
        print_hint()
        print_software(software)

if __name__ == "__main__":
    main()
