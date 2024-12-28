#import "tum-templates.typ": tum-text-font, tum-info-block, tum-blue, tum-author

#let tum-article(title: "", authors: (), tum-info: tum-info-block(), date: none, body, lang: "en") = {
    // Basic document properties
    set document(author: authors.map(a => a.name), title: title)
    set page(
        margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
        numbering: "1",
        number-align: right,
        header: context { 
            if counter(page).get().first() == 1 {
                grid(columns: (2fr, 1fr),
                    tum-info,
                    place(top + right, float: true, clearance: 0pt, scope: "parent", image("assets/tum_logo.svg", fit: "contain", height: 30pt))
                )
            }
        }
    )

    // Text/Font
    set text(font: tum-text-font, lang: lang, size: 10pt)
    set par(first-line-indent: 0pt, spacing: 0.5em, justify: true)
    set heading(numbering: "1.1")

    // Title
    block(text(weight: 700, 1.6em, title), above: 20pt, below: 2em)

    // Authors
    for author in authors {
        block(above: 1em, {
            text(size: 1.1em, fill: tum-blue, weight: 600, author.name)
            if author.affiliation != none {
                linebreak()
                author.affiliation
            }
            if author.email != none {
                linebreak()
                link("mailto:" + author.email)
            }
        })
    }

    // Date
    if date != none {
        block(above: 1em, text(size: 0.9em, date.display("[day].[month].[year]")))
    }

    body
}

#let abstract(body) = {
    block(above: 2.5em, below: 2.5em, {
        text(weight: 600, fill: tum-blue, "Abstract")
        [ --- ]
        body
    })
}
