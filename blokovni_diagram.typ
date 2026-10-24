#import "@preview/circuiteria:0.2.1"



#circuiteria.circuit({
import circuiteria: *
  element.block(
    name: "NAPETOSTNI DELILNIK",
    x: 0, y: 0, w: 7, h: 2.2,
    id: "VOL_DIV",
    fill: util.colors.orange,
    ports: (
      east: (
        (id: "Vout"),
      ),
    )
  )
  element.block(
    name: "RC FILTER",
    x: 8, y: 0, w: 7, h: 2.2,
    id: "RC",
    fill: util.colors.orange,
    ports: (
      west: (
        (id: "Vin"),
      ),
    )
  )
  // wire.wire("T1", ("Vout", "Vin"))
})