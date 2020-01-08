### css
body {
  margin: 0;
  padding: 0;
}

.container {
  background: #FFF;
}
###

var notes = []

tag sticky-notes

  def createNew
    console.log "createNew"
    # TODO: make it a placeholder text?
    self.notes.push({body: 'Enter note here'})

  def render
    ### css scoped
    h1 {
    }
    .note {
      background: purple;
      background: #FFFF80;
      min-width: 128px;
      min-width: 128px;
      padding: 1rem;
      margin: 0.15rem;
    }
    .notes {
      display: grid;
      grid-template: 1fr / 1fr;
    }
    
    @media (min-width: 640px) {
      .notes {
        grid-template: 1fr / repeat(3, 1fr);
      }
    }

    @media (min-width: 1024px) {
      .notes {
        grid-template: 1fr / repeat(4, 1fr);
      }
    }
    ###
    <self.container>
      <button :click.createNew()> "New"
      <div.notes>
        for note in @notes
          <div.note contentEditable=true>
            <p> note.body
            <pre> JSON.stringify(note, null, 2)

imba.mount <sticky-notes notes=notes>
