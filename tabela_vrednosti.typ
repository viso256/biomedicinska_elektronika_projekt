#let R_test = (47000, 68000, 100000, 220000, 470000, 1000000, 2200000, 4700000)

#let R_ref = 100000
#let U_ref_del = 3.3

#let U_ref_oj = 3.3
#let U_oj_max = 5

#let U_ref_ADC = 4.096
#let ADC_bits = 12

#let get_G_from_R = R => 1 / R
#let delilnik = (U_ref_del, R_kože, R_ref) => U_ref_del * (R_kože / (R_kože + R_ref))
#let ojacevalnik = U_in => calc.min(U_in * 2, U_oj_max)
#let ADC = (U_ref, U_in) => calc.min(calc.floor((U_in / U_ref) * calc.pow(2, ADC_bits)), calc.pow(2, ADC_bits) - 1)

#let G_k = R_test.map(R => get_G_from_R(R))
#let U_del = R_test.map(R => delilnik(U_ref_del, R, R_ref))
#let U_oj = U_del.map(U => ojacevalnik(U))
#let ADC_vrednosti = U_oj.map(U => ADC(U_ref_ADC, U))

#let tabela = (
  R_test
    .enumerate()
    .map(((i, R)) => {
      let G = G_k.at(i)
      let U_del = U_del.at(i)
      let U_oj = U_oj.at(i)
      let ADC_vrednost = ADC_vrednosti.at(i)
      (G: 0, R: R, U_del: U_del, U_oj: U_oj, ADC: ADC_vrednost)
    })
)
