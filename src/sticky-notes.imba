### css
body {
  margin: 0;
  padding: 0;
}

.container {
  background: #FFF;
}
###

let persisted = localStorage.getItem('notes')
var notes = persisted ? JSON.parse(persisted) : []

tag sticky-notes

  def syncStorage
    console.log "syncStorage"
    localStorage.setItem('notes', JSON.stringify(self.notes))

  # TODO: also handle deletion, maybe delete when hitting backspace in an empty
  # note
  def createNew
    console.log "createNew"
    self.notes.push({body: ''})
    syncStorage()

  def noteChanged index
    console.log "noteChanged",index
    let note = document.querySelector("#note-{index}").innerText
    # console.log("note ->: ",note, 'EOF')
    @notes[index].body = note
    self.syncStorage()

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
          let index = @notes.indexOf(note)
          <div.note id="note-{index}" contentEditable=true :keydown.noteChanged(index)>
            <p> note.body
          # TODO: refactor note div into a own tag.
imba.mount <sticky-notes notes=notes>
