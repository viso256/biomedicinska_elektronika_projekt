#import "@preview/zero:0.7.1": num, set-num, zi

#set-num(decimal-separator: ",")

#let to_kohm = ohm => if (ohm == calc.inf) { sym.infinity } else { zi.kohm(ohm / 1000) }
#let to_ua = amp => [#num(amp * (1000 * 1000), digits: 1, round: (precision: 1)) #sym.mu#[A]]
#let round_volts = (volts, prec) => [#num(volts, digits: prec, round: (precision: prec)) V]
#let to_usiemens = siemens => [#num(siemens * 1000 * 1000, digits: 2) #sym.mu#[S]]
#let follower_voltage = volt => if (volt > 3.9) {
  "> 3,9 V"
} else { round_volts(volt, 3) }

#set heading(numbering: "1.1")
// #set math.equation(numbering: "(1)", supplement: [])

#show figure: set figure(supplement: "Slika")

#align(center)[
  #text(18pt, weight: "bold")[Projekt EDA (GSR Click) – Bločni diagram in tabela napovedi] \
  #v(0.5em)
  #text(12pt)[Neža Povh, Vid Sojer]
]


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
#pagebreak()

== RC filter
Izračun mejne frekvence:
$
  f#sub[m] & = 1 / (2 #sym.pi R_2 C_6) = 1 / (2 #sym.pi * #zi.kohm(100) * #zi.uF(0.10)) approx #zi.hertz(15.9)
$
#block(
  breakable: false,
  [Frekvenčni odziv filtra pri frekvencah 0,1 Hz do 10 kHz:
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

- Zgornja meja A/D pretvornika:
$
  4095 quad (U_3 = 4,096 "V")
$

$
  U_2 = frac(U_3, 2) = 2,048 "V" = U_1
$
$
                U_1 & = U_"CC" frac(R_4, R_"K" + R_4) \
  U_1 (R_"K" + R_4) & = U_"CC" R_4 \
              R_"K" & = frac(U_"CC" R_4, U_1) - R_4
                      = R_4 (frac(U_"CC", U_1) - 1) \
$

$
  G_S = frac(1, R_"K") = 1,4 "µS"
  quad arrow.r quad N = 4095
$

- MCP607

  $
    U_"SS" - 0,3 "V" <= U_"IN" <= U_"DD" - 1,1 "V" \
                        -0,3 "V" <= U_3 <= 3,9 "V" \
                          U_1 = U_2 = frac(U_3, 2)
                          quad arrow.r quad U_1    & <= 1,95 "V"
  $
  $
    R_S & = 69,2 "kΩ" \
      G & = 14,4 "µS" quad ("manj od A/D")
  $

- Spodnja meja A/D pretvornika:
$
  N = 1 \
  N = 4096 frac(u_3, U_"ref")
  quad arrow.r quad
  U_3 = frac(N * U_"ref", 4096) = 1 "mV" \ U_1 = 0,5 "mV" \
  R_S = R_4 (frac(U_"CC", U_1) - 1) \
  G = 1,5 "nS"
$

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
  #[nizek G (N #sym.arrow 0)]: quad && frac(d G, d N) & = "1,2 nS" \
         "visok G (N = 4095)": quad && frac(d G, d N) & = "0,0105 nS"
$

= Največji tok skozi kožo

$
                   I & = (U#sub[CC]) / (R#sub[K] + R_4) \
  R#sub[K] -> 0 => I & < (U#sub[CC]) / (R_4) = zi.uA(33)
$

#let calculate_skin_current = r_s => 3.3 / (r_s + 100000)

#let skin_resistances = (0, 100000, 1000000)
#let skin_currents = skin_resistances.map(calculate_skin_current)

#table(
  columns: (auto, auto),
  table.header([R#sub[K]], [I]),
  ..skin_resistances.map(to_kohm).zip(skin_currents.map(to_ua)).flatten(),
  sym.infinity, [0],
)

#pagebreak()

= Tabela napovedanih vrednosti

#import "tabela_vrednosti.typ"

#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto, auto, auto, auto),
  table.header([G#sub[K]], [R#sub[K]], ..range(1, 9).map(i => [TP#sub([#i])]), [N#sub[ADC]]),
  ..tabela_vrednosti
    .tabela
    .map(row => {
      (
        to_usiemens(row.G),
        to_kohm(row.R),
        round_volts(row.U_del, 3),
        round_volts(row.U_del, 3),
        round_volts(row.U_oj, 3),
        follower_voltage(row.U_oj),
        "4,096 V",
        "3,3 V",
        "5,0 V",
        "0 V",
        num(row.ADC),
      )
    })
    .flatten(),
)
