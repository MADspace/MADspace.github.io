#!/bin/sh
pandoc -s -t latex definities.md -o definities.pdf
pandoc -s -t latex huisregels.md -o huisregels.pdf
