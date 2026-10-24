#set heading(numbering: "1.1")

#show figure: set figure(supplement: "Slika")

= BLOKOVNI DIAGRAM

#include "blokovni_diagram.typ"

== Napetostni delilnik

$ U#sub[iz] = U#sub[ref DEL] * (R#sub[ref]) / (R#sub[koža] + R#sub[ref]) $

=== Testna točka (TP1)

== RC filter

== Ojačevalnik

$ A = 1 + (R#sub[PZ]) / R $

== AD pretvornik

$ 12 "bitni" -> "ADC"#sub[MAX] = 2^12 -1 = 4095 $
$ "ADC" = min(floor((U#sub[vh]) / (U#sub[ref]) * 2^12), 2^12 - 1) $

== Napetostni sledilnik

== Referenčna napetost

= Tabela napovedanih vrednosti

#include "tabela.typ"
