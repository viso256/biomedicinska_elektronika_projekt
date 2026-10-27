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

= Shema z označenimi testnimi točkami

#image("dokumentacija/gsr-click-schematic-v100.svg")

== Napetostni delilnik

Enačba za izhodno napetost delilnika:
$ U_1 = U#sub[ref del] * (R_4) / (R#sub[K] + R_4) $ <divider>

Odvisnost U#sub[1] od R#sub[K]:
#image("simulacije/out/delilnik_graf.svg")

== RC filter
Izračun mejne frekvence:
$
  f#sub[m] & = 1 / (2 #sym.pi R_2 C_6) = 1 / (2 #sym.pi * #zi.kohm(100) * #zi.uF(0.10)) approx #zi.hertz(15.9)
$
#block(
  breakable: false,
  [Frekvenčni odziv filtra pro frekvencah 0,1 Hz do 10 kHz:
    #grid(
      columns: (auto, auto),
      image("simulacije/out/filter_graf_amplituda.svg"), image("simulacije/out/filter_graf_faza.svg"),
    )],
)

== Ojačevalnik

Ojačenje:
$
               A#sub[U] & = 1 + R_5 / R_3 \
  R_5 = R_3 => A#sub[U] & = 1 + 1 = 2
$
Izhodna napetost:
$
  U_3 & = U_2 * A#sub[U] = U_2 * 2
$ <opamp>

Nasičenje:
$
  U_3 = U#sub[nap] & = "5 V" => \
      U#sub[3 nas] & = (U#sub[nap]) / (A#sub[U]) = zi.V(5) / 2 = zi.V(2.5)
$

== A/D pretvornik

N vrednost:
$
  12 "bitni" => italic("N")#sub[MAX] = 2^12 -1 = 4095 \
  italic("N") = min(floor((U_3) / (U#sub[ref]) * 2^12), 2^12 - 1)
$

Izračun vhodne napetosti:

$
  U_3 = italic("N") / (2^12) * U#sub[ref]
$ <N>

Nasičenje:
$
  U_3 >= U#sub[ref] = zi.V(4.096)
$

== Napetostni sledilnik
$
   A#sub[U] & = 1 \
  U#sub[AN] & = U_3
$

== Referenčna napetost
Referenčna napetost, definirana v podatkovnem listu:
$ U#sub[ref] = zi.V(4.096) $ <uref>

// #include "izracun_iz_N.typ"

= Meje nasičenja

= Ločljivost

$
                  N & = x frac(R_4 G, 1 + R_4 G) \
       N(1 + R_4 G) & = x R_4 G \
        N + N R_4 G & = x R_4 G \
  N R_4 G - x R_4 G & = -N \
   G(N R_4 - x R_4) & = -N \
                  G & = frac(N, R_4(x - N))
$

$
  frac(d G, d N) & = frac(R_4(x - N) - N(-R_4), (R_4(x - N))^2) \
                 & = frac(R_4 x - N R_4 + N R_4, R_4^2(x - N)^2) \
                 & = frac(x, R_4(x - N)^2)
$
$
  #[nizek G (N #sym.arrow 0)]: && frac(d G, d N) & = "1,2 nS" \
         "visok G (N = 4095)": && frac(d G, d N) & = "0,0105 nS"
$

= Tabela napovedanih vrednosti

#import "tabela_vrednosti.typ"

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([G#sub[KOŽA]], [R#sub[KOŽA]], [U#sub[TP1] - delilnik], [U#sub[TP3] - ojačevalnik], [N]),
  ..tabela_vrednosti
    .tabela
    .map(row => {
      (to_usiemens(row.G), to_kohm(row.R), round_volts(row.U_del, 3), round_volts(row.U_oj, 3), num(row.ADC))
    })
    .flatten(),
)
