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

