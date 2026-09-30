#import "@preview/subpar:0.2.2"

#let tum-text-font = "TeX Gyre Heros"
#let tum-serif-font = "Noto Serif"
#let tum-blue = rgb("#0065BD")

#let tum-info-block(group: "Please Adjust", school: "Please Adjust") = {
  set text(size: 9pt, fill: tum-blue, bottom-edge: 5pt)

  group
  linebreak()
  school
  linebreak()
  "Technical University of Munich"
  linebreak()
}

#let tum-author(name, affiliation: none, email: none) = {
  return (name: name, affiliation: affiliation, email: email)
}

#let tum-emphasize(severity: none, body) = {
  let color = if severity == none { black } else if severity == "info" { tum-blue }

  v(.3em)
  block(
    stroke: color,
    width: 100%,
    inset: 0pt,
    outset: 4pt,
    radius: .2em,
    body,
  )
  v(.3em)
}

#let abstract(body) = {
  block(above: 2.5em, below: 2.5em, {
    text(weight: 600, fill: tum-blue, "Abstract")
    [ --- ]
    body
  })
}

#let figure-grid = subpar.grid.with(
  numbering: n => numbering("1.1", counter(heading).get().first(), n),
)

#let tum-outline() = {
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set block(above: 1.5em)
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  set outline.entry(fill: repeat([.], gap: .5em))

  outline()
}
