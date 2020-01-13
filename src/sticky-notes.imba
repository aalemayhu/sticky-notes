### css
body {
  margin: 0;
  padding: 0;
}

.container {
  background: #FFF;
}
###

tag sticky-notes

  def setup
    @notes = []
    
    let keys = Object.keys(localStorage).filter do |k|
      k.startsWith("note")
    for key in keys
      @notes.push(JSON.parse(localStorage.getItem(key)))

  def syncStorage
    console.log "syncStorage"
    localStorage.setItem('notes', JSON.stringify(self.notes))

  # TODO: also handle deletion, maybe delete when hitting backspace in an empty
  # note
  # TODO: support pasting into the sticky notes
  def createNew
    let container = document.querySelector(".notes")
    let count = Object.keys(localStorage).length + 1
    let id = "note-{count}"
    let note = {body: '', id: id}
    localStorage.setItem(id, JSON.stringify(note))
    # TODO: touch the DOM

  def noteChanged identifier
    let body = document.querySelector("#{identifier}").innerHTML
    let id = identifier
    let note = {id: id, body: body}
    localStorage.setItem(id, JSON.stringify(note))

  def render
    ### css scoped
    h1 {
    }
    .note {
      background: purple;
      background: #FFFF80;
      min-width: 128px;
      min-height: 128px;
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
          <div.note id="{note.id}" contentEditable=true :keydown.noteChanged(note.id)>
            <p> note.body
          # TODO: refactor note div into a own tag.
imba.mount <sticky-notes>
