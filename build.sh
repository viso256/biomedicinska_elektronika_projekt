#!/usr/bin/env bash
cd simulacije
ngspice -b delilnik.cir
ngspice -b filter.cir

cd ..
typst compile Poročilo.typ