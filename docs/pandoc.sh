#!/bin/sh
pandoc -s -t latex definities.md -o definities.pdf
pandoc -s -t latex huisregels.md -o huisregels.pdf
pandoc -s -t latex inventaris.md -o inventaris.pdf
pandoc -s -t latex prijslijst.md -o prijslijst.pdf
pandoc -s -t latex zelf_organiseren.md -o zelf_organiseren.pdf

