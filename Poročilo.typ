#import "@preview/zero:0.7.1": num, set-num, zi

#set-num(decimal-separator: ",")

#let to_kohm = ohm => zi.kohm(ohm / 1000)
#let round_volts = (volts, prec) => [#num(volts, digits: prec, round: (precision: prec)) V]
#let to_usiemens = siemens => [#num(siemens * 1000 * 1000, digits: 2) #sym.mu#[S]]

#set heading(numbering: "1.1")

#show figure: set figure(supplement: "Slika")

= BLOKOVNI DIAGRAM
\
#include "blokovni_diagram.typ"

== Napetostni delilnik

Izhodna napetost:
$ U#sub[iz] = U#sub[ref del] * (R#sub[ref]) / (R#sub[koža] + R#sub[ref]) $

== RC filter

== Ojačevalnik

Ojačenje:
$
A & = 1 + (R#sub[PZ]) / R \
R#sub[PZ] = R => A & = 1 + 1 = 2
$
Izhodna napetost:
$
  U#sub[iz] & = U#sub[vh] * A = U#sub[vh] * 2
$

Nasičenje:
$
  U#sub[iz] = U#sub[nap] & = "5 V" => \
           U#sub[vh nas] & = (U#[nap]) / A = zi.V(5) / 2 = zi.V(2.5)
$

== AD pretvornik

ADC vrednost:
$
  12 "bitni" => italic("ADC")#sub[MAX] = 2^12 -1 = 4095 \
  italic("ADC") = min(floor((U#sub[vh]) / (U#sub[ref]) * 2^12), 2^12 - 1)
$

Nasičenje:
$
  U#sub[vh] = U#sub[ref] = zi.V(4.096)
$

== Napetostni sledilnik

== Referenčna napetost
Referenčna napetost, definirana v podatkovnem listu:
$ U#sub[ref] = zi.V(4.096) $

= Tabela napovedanih vrednosti

#import "tabela_vrednosti.typ"

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([G#sub[KOŽA]], [R#sub[KOŽA]], [U#sub[D]], [U#sub[OJ]], [ADC]),
  ..tabela_vrednosti
    .tabela
    .map(row => {
      (to_usiemens(row.G), to_kohm(row.R), round_volts(row.U_del, 3), round_volts(row.U_oj, 3), num(row.ADC))
    })
    .flatten(),
)
