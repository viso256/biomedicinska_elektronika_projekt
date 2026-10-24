#import "@preview/circuiteria:0.2.1"



#circuiteria.circuit({
  import circuiteria: *
  element.block(
    name: "KOŽA",
    x: 0,
    y: 3,
    w: 8,
    h: 2,
    id: "SKIN",
    fill: util.colors.blue,
  )
  element.block(
    name: "NAPETOSTNI DELILNIK",
    x: 0,
    y: 0,
    w: 8,
    h: 2,
    id: "VOL_DIV",
    fill: util.colors.blue,
  )
  wire.wire("T0", ("SKIN", "VOL_DIV"))
  element.block(
    name: "RC FILTER",
    x: 2,
    y: -4,
    w: 4,
    h: 2,
    id: "RC",
    fill: util.colors.blue,
  )
  wire.wire("T1", ("VOL_DIV", "RC"))
  wire.stub("T1", "west", name: [TP#sub[1]])
  element.block(
    name: "OJAČEVALNIK",
    x: 1,
    y: -8,
    w: 6,
    h: 2,
    id: "OPAMP",
    fill: util.colors.blue,
  )
  wire.wire("T2", ("RC", "OPAMP"))
  wire.stub("T2", "west", name: [TP#sub[2]])
  element.block(
    name: "AD PRETVORNIK",
    x: 1,
    y: -12,
    w: 6,
    h: 2,
    id: "ADC",
    fill: util.colors.blue,
    ports: (
      south: (
        (id: "south"),
      ),
    ),
  )
  wire.wire("T3", ("OPAMP", "ADC"))
  wire.stub("T3", "west", name: [TP#sub[3]])
  element.block(
    name: "NAPETOSTNI SLEDILNIK",
    x: 8,
    y: -12,
    w: 7,
    h: 2,
    id: "FOL",
    fill: util.colors.blue,
    ports: (
      south: (
        (id: "TP4"),
      ),
      north: (
        (id: "north"),
      ),
    ),
  )
  wire.wire("FOL", ("OPAMP", "FOL-port-north"), style: "zigzag", zigzag-dir: "horizontal")
  wire.stub("FOL-port-TP4", "south", name: [TP#sub[4]])
  wire.stub("ADC-port-south", "south")
  element.block(
    name: "REFERENČNA\n NAPETOST",
    x: -6,
    y: -12,
    w: 5,
    h: 2,
    id: "UREF",
    fill: util.colors.blue,
  )
  wire.wire("REF", ("UREF", "ADC"))
  wire.stub("REF", "south", name: [TP#sub[5]])
})
