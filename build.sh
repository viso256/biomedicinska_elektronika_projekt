#!/usr/bin/env bash
cd simulacije
ngspice -b delilnik.cir

cd ..
typst compile Poročilo.typ