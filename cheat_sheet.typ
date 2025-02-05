#import "util.typ": tum-text-font, tum-blue, tum-author

#let tum-cheat-sheet(
  title: "",
  authors: (),
  date: none,
  body,
  lang: "en",
  text-size: 8pt,
  max-pages: none
) = {
  // Basic document properties
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 10mm, right: 10mm, top: 10mm, bottom: 10mm),
    numbering: "1",
    number-align: right,
  )

  // Text/Font
  set text(font: tum-text-font, lang: lang, size: text-size)
  set par(first-line-indent: 0pt, spacing: .7em, justify: true)

  show heading: set block(above: .8em, below: .6em)
  set heading(numbering: "1.1")

  show heading: it => {
    if it.level > 2 {
      parbreak()
      text(1.2em, style: "italic", weight: "regular", it.body + ":")
    } else {
      it
    }
  }

  // Title
  align(center)[
    #text(weight: 700, size: 1.5em, title)
    #if date != none {
      h(2em, weak: true)
      text(size: 0.9em, date.display("[day].[month].[year]"))
    }
  ]

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
  show: columns.with(2, gutter: 2em)

  // Check maximum number of pages
  if max-pages != none {
    context {
        let final_pages = counter(page).final().at(0)
        assert(final_pages <= max-pages, message: "Maximum page number reaches")
    }
  }

  body
}
