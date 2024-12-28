#import "@preview/touying:0.5.3": *

#import "@preview/numbly:0.1.0": numbly

#let text-font = "TeX Gyre Heros"
#let tum-blue = rgb("#0065BD")

#let tum-info-block(group: "Please Adjust", school: "Please Adjust") = {
    set text(size: 0.6em, fill: tum-blue)

    group
    linebreak()
    school
    linebreak()
    "Technical University of Munich"
    linebreak()
}

#let title-slide(tum-info: tum-info-block(), ..args) = touying-slide-wrapper(self => {
    self = utils.merge-dicts(
        self,
        config-page(
            margin: (top: 2em, bottom: 2em, x: 2em)
        )
    )
    let info = self.info + args.named()
    let body = {
        tum-info
        block(
            width: 80%,
            inset: (y: 1em),
            text(size: 2em, fill: self.colors.primary, weight: "bold", font: text-font, info.title),
        )
        v(24pt)
        grid(
            columns: (1fr, 1fr),
            align(left)[
                #set text(fill: self.colors.neutral-darkest)
                #if info.author != none {
                    block(text(weight: "bold", info.author))
                }
                #if info.institute != none {
                    block(text(size: 0.8em, info.institute))
                }
                #if info.date != none {
                    block(utils.display-info-date(self))
                }
                #v(100%)
            ],
            place(bottom + right, float: true, clearance: 0em, scope: "parent", image("assets/tum_tower.svg", fit: "contain", height: 50%))
        )
    }

    touying-slide(self: self, body)
})

#let slide(title: auto, ..args) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  // set page
  let header(self) = {
    show: components.cell.with(inset: 2em)

    set align(horizon)
    set text(size: 1.8em, weight: "bold", fill: self.colors.primary)
    if self.store.title != none {
      utils.call-or-display(self, self.store.title)
    } else {
      utils.display-current-heading(level: 2)
    }
  }
  let footer(self) = {
    set align(bottom)
    show: pad.with(.4em)
    set text(fill: self.colors.neutral-darkest, size: .8em)
    utils.call-or-display(self, self.store.footer)
    h(1fr)
    context utils.slide-counter.display() + " / " + utils.last-slide-number
  }
  self = utils.merge-dicts(
    self,
    config-page(
      header: header,
      footer: footer,
    ),
  )

  touying-slide(self: self, ..args)
})

#let tum-beamer(aspect-ratio: "16-9", title: "", subtitle: none, authors: (), institute: none, ..args, body) = {
  set text(size: 18pt, font: text-font)

  show: touying-slides.with(
    config-page(
      paper: "presentation-" + aspect-ratio,
      margin: (top: 2em, bottom: 2em, x: 2em)
    ),
    config-common(
      slide-fn: slide,
      datetime-format: "[day].[month].[year]"
    ),
    config-colors(
      primary: tum-blue,
      neutral-lightest: rgb("#ffffff"),
      neutral-darkest: rgb("#000000")
    ),
    config-info(
        title: title,
        subtitle: subtitle,
        author: authors.join(", "),
        date: datetime.today(),
        institute: institute
    ),
    config-store(
      title: none,
      footer: none,
    ),
    ..args,
  )

  body
}

