#!/usr/bin/env python2
# -*- coding: utf-8 -*-
""" titlemd """

from __future__ import print_function

import argparse
import sys

try:
    from titlecase import titlecase
except ImportError:
    print("Please install titlecase")

def arg_parse():
    """
    argument parser
    """
    parser = argparse.ArgumentParser(
        description="Titlemd"
    )
    parser.add_argument('-t', '--test',
                        action='store_true',
                        help="test")
    parser.add_argument('location',
                        nargs='?',
                        default='.',
                        help="location, default current directory")
    return parser.parse_args()

def mkdocs_available(location):
    """ Is mkdocs.yml available? """
    if location.find("mkdocs.yml") != -1:
        return True
    return False

def linestart(line, disabled, test, prev_line=None):
    """ linestart """
    if test:
        if (line.startswith("``") or line.startswith("extra:")) and not disabled:
            return True
        if (line.startswith("``") or prev_line.startswith("pages:")) and disabled:
            return False
    else:
        if line.startswith("``") and not disabled:
            return True
        if line.startswith("``") and disabled:
            return False
    return disabled

def testdata(arg):
    """ test """
    # Spelling exceptions
    with open('.spelling') as fdata:
        spelling = fdata.readlines()

    # pylint: disable=unused-argument,inconsistent-return-statements
    def abbreviations(word, **kwargs):
        """ abbreviations """
        if word+"\n" in spelling:
            return word

    # Open the file and read the lines as a list
    with open(arg.location) as fdata:
        lines = fdata.readlines()

    # Loop through the list of lines and titlecase
    # any line beginning with '#'.
    return_value = 0
    prev_line = lines[0]
    echo_filename = False
    disabled = mkdocs_available(arg.location)
    for line in lines:
        disabled = linestart(line, disabled, arg.test, prev_line)
        if line.startswith('#') and not disabled and not mkdocs_available(arg.location):
            if line != titlecase(line[:(line.find("]"))],
                                 callback=abbreviations)+line[(line.find("]")):]:
                if return_value == 0 and not echo_filename:
                    print("%s" % arg.location)
                    echo_filename = True
                print("-"+line, end="")
                print("+"+titlecase(line[:(line.find("]"))],
                                    callback=abbreviations)+line[(line.find("]")):], end="")
                print()
                return_value = 1
        if (line.startswith('---') or line.startswith('===')) and not disabled:
            if prev_line != titlecase(prev_line[:(prev_line.find("]"))],
                                      callback=abbreviations)+prev_line[(prev_line.find("]")):]:
                if return_value == 0 and not echo_filename:
                    print("%s" % arg.location)
                    echo_filename = True
                print("-"+prev_line, end="")
                print("+"+titlecase(prev_line[:(prev_line.find("]"))],
                                    callback=abbreviations)+prev_line[(prev_line.find("]")):],
                      end="")
                print()
                return_value = 1
        if (mkdocs_available(arg.location) and not line.startswith('#') and not disabled):
            if line != titlecase(line[:(line.find(":"))],
                                 callback=abbreviations)+line[(line.find(":")):]:
                if return_value == 0 and not echo_filename:
                    print("%s" % arg.location)
                    echo_filename = True
                print("-"+line, end="")
                print("+"+titlecase(line[:(line.find(":"))],
                                    callback=abbreviations)+line[(line.find(":")):], end="")
                print()
                return_value = 1
            prev_line = line
    return return_value

def writedata(arg):
    """ writedata """
    # Spelling exceptions
    with open('.spelling') as fdata:
        spelling = fdata.readlines()

    # pylint: disable=unused-argument,inconsistent-return-statements
    def abbreviations(word, **kwargs):
        """ abbreviations """
        if word+"\n" in spelling:
            return word

    # Open the file and read the lines as a list
    with open(arg.location) as fdata:
        lines = fdata.readlines()

    with open(arg.location, 'w') as fdata:
        # Loop through the list of lines and titlecase
        # any line beginning with '#'.
        prev_line = lines[0]
        disabled = False
        for line in lines:
            disabled = linestart(line, disabled, arg.test)
            if line.startswith('#') and not disabled:
                line = titlecase(line[:(line.find("]"))],
                                 callback=abbreviations)+line[(line.find("]")):]
            if (line.startswith('---') or line.startswith('===')) and not disabled:
                prev_line = titlecase(prev_line[:(prev_line.find("]"))],
                                      callback=abbreviations)+prev_line[(prev_line.find("]")):]
            fdata.write(prev_line)
            prev_line = line
        fdata.write(prev_line)

def main():
    """
    main function
    """

    arg = arg_parse()

    if arg.test:
        sys.exit(testdata(arg))
    else:
        writedata(arg)

if __name__ == "__main__":
    main()
