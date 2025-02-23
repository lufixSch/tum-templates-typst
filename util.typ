#let tum-text-font = "TeX Gyre Heros"
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
        body
    )
    v(.3em)
}
