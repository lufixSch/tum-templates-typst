#import "util.typ": tum-text-font, tum-blue, tum-author

#let tum-cheat-sheet(
  title: none,
  authors: (),
  date: none,
  body,
  lang: "en",
  text-size: 8pt,
  max-pages: none,
  landscape: false,
  num-columns: 2
) = {
  // Basic document properties
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 10mm, right: 10mm, top: 10mm, bottom: 10mm),
    numbering: "1",
    number-align: right,
    flipped: landscape
  )

  // Text/Font
  set text(font: tum-text-font, lang: lang, size: text-size)
  set par(first-line-indent: 0pt, spacing: 6pt, justify: true)

  show heading: set block(above: 4pt, below: 4pt)
  set heading(numbering: "1.1")

  show heading: it => {
    if it.level > 2 {
      parbreak()
      text(1.1em, style: "italic", weight: "medium", it.body + ":")
    } else {
      it
    }
  }

  // Math/Equations
  show math.equation: set block(above: .35em, below: .35em)


  // Title
  if title != none {
    align(center)[
      #text(weight: 700, size: 1.5em, title)
      #if date != none {
        h(2em, weak: true)
        text(size: 0.9em, date.display("[day].[month].[year]"))
      }
    ]
  }

  // Authors
  pad(
    top: 0em,
    bottom: .5em,
    x: 12em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(a => align(center, strong(a.name)))
    ),
  )

  // Body
  show: columns.with(num-columns, gutter: 12pt)

  // Check maximum number of pages
  if max-pages != none {
    context {
        let final_pages = counter(page).final().at(0)
        assert(final_pages <= max-pages, message: "Maximum page number reaches")
    }
  }

  body
}
