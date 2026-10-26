#import "@preview/zero:0.7.1": num, set-num, zi

#set-num(decimal-separator: ",")

#let to_kohm = ohm => zi.kohm(ohm / 1000)
#let round_volts = (volts, prec) => [#num(volts, digits: prec, round: (precision: prec)) V]
#let to_usiemens = siemens => [#num(siemens * 1000 * 1000, digits: 2) #sym.mu#[S]]

#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)", supplement: [])

#show figure: set figure(supplement: "Slika")

#title[Projekt EDA (GSR Click) – Bločni diagram in tabela napovedi]


= Bločni diagram
\
#include "blokovni_diagram.typ"

== Napetostni delilnik

Enačba za izhodno napetost delilnika:
$ U#sub[iz] = U#sub[ref del] * (R#sub[ref]) / (R#sub[koža] + R#sub[ref]) $ <divider>

Odvisnost U#sub[iz] od R#sub[koža]:
#image("simulacije/out/delilnik_graf.svg")

== RC filter
Izračun mejne frekvence:
$
  f#sub[m] &= 1 / (2 #sym.pi R C) = 1 / (2 #sym.pi * #zi.kohm(100) * #zi.uF(0.10)) approx #zi.hertz(15.9)
$
Simulacija:
#grid(
  columns:(auto, auto),
  image("simulacije/out/filter_graf_amplituda.svg"),
  image("simulacije/out/filter_graf_faza.svg"),
)

== Ojačevalnik

Ojačenje:
$
                   A#sub[U] & = 1 + (R#sub[PZ]) / R \
  R#sub[PZ] = R => A#sub[U] & = 1 + 1 = 2
$
Izhodna napetost:
$
  U#sub[iz] & = U#sub[vh] * A#sub[U] = U#sub[vh] * 2
$ <opamp>

Nasičenje:
$
  U#sub[iz] = U#sub[nap] & = "5 V" => \
           U#sub[vh nas] & = (U#sub[nap]) / (A#sub[U]) = zi.V(5) / 2 = zi.V(2.5)
$

== A/D pretvornik

ADC vrednost:
$
  12 "bitni" => italic("ADC")#sub[MAX] = 2^12 -1 = 4095 \
  italic("ADC") = min(floor((U#sub[vh]) / (U#sub[ref]) * 2^12), 2^12 - 1)
$

Izračun vhodne napetosti:

$
  U#sub[vh] = italic("ADC") / (2^12) * U#sub[ref]
$ <adc>

Nasičenje:
$
  U#sub[vh] = U#sub[ref] = zi.V(4.096)
$

== Napetostni sledilnik
$
  U#sub[iz] = U#sub[vh]
$

== Referenčna napetost
Referenčna napetost, definirana v podatkovnem listu:
$ U#sub[ref] = zi.V(4.096) $ <uref>

// #include "izracun_iz_adc.typ"

= Tabela napovedanih vrednosti

#import "tabela_vrednosti.typ"

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([G#sub[KOŽA]], [R#sub[KOŽA]], [U#sub[TP1] - delilnik], [U#sub[TP3] - ojačevalnik], [ADC]),
  ..tabela_vrednosti
    .tabela
    .map(row => {
      (to_usiemens(row.G), to_kohm(row.R), round_volts(row.U_del, 3), round_volts(row.U_oj, 3), num(row.ADC))
    })
    .flatten(),
)
