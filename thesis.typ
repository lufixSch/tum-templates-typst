#import "util.typ": tum-author, tum-blue, tum-info-block, tum-serif-font, tum-text-font

#let _print_people(people) = {
  let n = people.len()
  for (i, p) in people.enumerate() {
    text(size: 1em, {
      if p.email != none {
        link("mailto:" + p.email)[#p.name]
      } else {
        p.name
      }

      if i < n - 1 [,#linebreak()]
    })
  }
}

#let _title_heading(title, subtitle, school) = {
  v(2em)
  align(center, {
    image(
      "assets/tum_logo.svg",
      fit: "contain",
      height: 60pt,
    )
    block(
      {
        text(2.2em, smallcaps(school))
        v(4pt)
        text(size: 1.5em, upper("Technical University of Munich"))
      },
      above: 20pt,
    )

    block(
      text(1.5em, "Master Thesis"),
      above: 60pt,
      below: 60pt,
    )

    block(
      {
        align(center, text(weight: 700, 2em, title))
        v(1em)
        if subtitle != none {
          text(2em, subtitle)
        }
      },
      above: 2em,
      below: 2em,
    )
  })
}

#let tum-thesis(
  title: "",
  subtitle: none,
  school: "",
  authors: (),
  supervisors: (),
  advisors: (),
  date: none,
  body,
  lang: "en",
  font: (:),
  skip_numbers: 1,
) = {
  // Basic document properties
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
    numbering: none,
    number-align: right,
  )
  set figure(
    numbering: n => numbering("1.1", counter(heading).get().first(), n),
  )
  show figure.caption: c => [#v(.5em)*#c.supplement #c.counter.display(c.numbering)#c.separator* #c.body]

  // Text/Font
  set text(font: tum-serif-font, lang: lang, size: font.at("size", default: 10pt))
  set par(first-line-indent: 0pt, spacing: 1.1em, justify: true, leading: .75em)

  show raw: set text(size: font.at("size", default: 10pt) - 1pt)

  set heading(numbering: "1.1.")
  show heading: set block(above: 2em, below: 1.25em)
  show heading.where(level: 1): it => {
    set text(size: 1.5em)
    block(v(20mm) + it)
  }

  // Title page
  set par(justify: false)

  _title_heading(title, subtitle, school)

  align(
    center,
    block(
      text(_print_people(authors), size: 1.5em, weight: 700),
      above: 60pt,
    ),
  )

  pagebreak()

  // Secondary Title page
  // disable justify for title page
  _title_heading(title, subtitle, school)

  // Authors/Supervisor ...
  align(
    bottom + center,
    block(
      align(
        top + left,
        table(
          columns: (auto, auto),
          stroke: none,
          strong("Author:"),
          _print_people(authors),
          strong("Supervisor:"),
          _print_people(supervisors),
          strong("Advisor:"),
          _print_people(advisors),
          ..(
            if date != none {
              (strong("Submission Date:"), date.display("[day].[month].[year]"))
            }
          ),
        ),
      ),
    ),
  )

  pagebreak()

  // enable justify
  set par(justify: true)

  counter(page).update(1)
  set page(numbering: "1")

  body
}

#let acknowledgement(body) = {
  block(above: 2.5em, below: 2.5em, {
    text(weight: 600, fill: tum-blue, "Acknowledgements")
    [ --- ]
    body
  })
}

#let disclaimer(authors, location, date, doctype) = {
  align(
    bottom,
    {
      [I confirm, that this #doctype is my own work and I have documented all sources and material used.]
      v(15mm)
      grid(
        columns: (1fr, 1fr),
        ..for author in authors {
          ([#location, #date.display("[month repr:long] [day], [year]")], [#author.name])
        }
      )
    },
  )
}
