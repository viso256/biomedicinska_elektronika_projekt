#import "@preview/zero:0.7.1": zi

= Izračun prevodnosti kože iz surove vrednosti ADC

Iz enačbe @divider delilnika izpeljemo odvisnost prevodnosti kože od napetosti v TP1:
$
  R#sub[koža] & = R#sub[ref] * ((U#sub[ref del]) / (U#sub[TP1]) - 1) \
  G#sub[koža] & = 1/(R#sub[koža]) = 1 / (R#sub[ref] * ((U#sub[ref del]) / (U#sub[TP1]) - 1)) = (U#sub[TP1]) / (R#sub[ref] * (U#sub[ref del] - U#sub[TP1]))
$

RC filter ima pri nizkih frekvencah zanemarljiv vpliv, zato:
$
  U#sub[TP2] = U#sub[TP1]
$

Iz enačbe @opamp ojačevalnika izpeljemo odvisnost napetorsti v TP2 in TP3:
$
  U#sub[TP2] = (U#sub[TP3]) / 2
$

Upoštevamo še enačbo @adc A/D pretvornika in vrednost @uref referenčne napetosti:
$
  U#sub[TP3] = (U#sub[ref]) / 4096 * italic("ADC") = zi.V(4.096) / 4096 * italic("ADC") = italic("ADC") * zi.V(0.001)
$

Tako dobimo:
#let TP_3 = $italic("ADC") * zi.V(0.001)$
$
  G#sub[koža] &= (U#sub[TP1]) / (R#sub[ref] * (U#sub[ref del] - U#sub[TP1])) = (U#sub[TP3])/2 / (R#sub[ref]*(U#sub[ref del]-(U#sub[TP3])/2)) \
  &= (U#sub[TP3]) / (R#sub[ref]*(2 * U#sub[ref del]-U#sub[TP3])) = #TP_3 / (zi.kohm(100)*(2 * zi.V(3.3)-#TP_3)) \
  &= ... #[ S]
$
