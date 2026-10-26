#set heading(numbering: "1.1")

#show figure: set figure(supplement: "Slika")

= BLOKOVNI DIAGRAM
\
#include "blokovni_diagram.typ"

== Napetostni delilnik

$ U#sub[iz] = U#sub[ref DEL] * (R#sub[ref]) / (R#sub[koža] + R#sub[ref]) $

=== Testna točka (TP1)

== RC filter

== Ojačevalnik

$
                   A & = 1 + (R#sub[PZ]) / R \
  R#sub[PZ] = R => A & = 1 + 1 = 2 \
           U#sub[iz] & = U#sub[vh] * A = U#sub[vh] * 2
$

Nasičenje:
$
  U#sub[iz] = U#sub[nap] & = "5 V" =>\
        U#sub[vh nas] & = (U#[nap]) / A = "5 V" / 2 = "2,5 V"
$

== AD pretvornik

$
  12 "bitni" => "ADC"#sub[MAX] = 2^12 -1 = 4095 \
  "ADC" = min(floor((U#sub[vh]) / (U#sub[ref]) * 2^12), 2^12 - 1)
$

Nasičenje:
$
  U#sub[vh] = U#sub[ref] = "4,096 V"
$

== Napetostni sledilnik

== Referenčna napetost

$ U#sub[REF] = "4,096 V" $

= Tabela napovedanih vrednosti

#import "tabela_vrednosti.typ"

#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([G#sub[KOŽA]\[S\]], [R#sub[KOŽA]\[#sym.Omega\]], [U#sub[D]\[V\]], [U#sub[OJ]\[V\]], [ADC]),
  ..tabela_vrednosti.tabela.flatten().map(a => [#a]),
)
