#import "util.typ": tum-author, tum-blue, tum-info-block, tum-text-font

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
) = {
  // Basic document properties
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
    numbering: (..nums) => if nums.at(0) != 1 {numbering("1", nums.at(0))},
    number-align: right,
  )

  // Text/Font
  set text(font: tum-text-font, lang: lang, size: 10pt)
  set par(first-line-indent: 0pt, spacing: 0.5em, justify: true)
  set heading(numbering: "1.1")

  // Title page
  align(center, {
    image(
      "assets/tum_logo.svg",
      fit: "contain",
      height: 50pt,
    )
    block(
      {
        text(weight: 700, 2em, "Technical University of Munich")
        v(2em)
        text(1.8em, school)
      },
      above: 30pt,
      below: 2em,
    )

    block(
      text(1.5em, "Master Thesis"),
      above: 80pt,
      below: 80pt,
    )

    block(
      {
        text(weight: 700, 2em, title)
        v(1em)
        if subtitle != none {
          text(2em, subtitle)
        }
      },
      above: 2em,
      below: 2em,
    )
  })

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

  body
}
