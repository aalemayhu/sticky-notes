### css
body {
  margin: 0;
  padding: 0;
}

.container {
  background: #FFF;
}
###

tag sticky-note

  ### css scoped
    .note {
      background: purple;
      background: #FFFF80;
      min-width: 128px;
      min-height: 128px;
      padding: 1rem;
      margin: 0.15rem;
    }
  ###

  def noteChanged event
    self.callback(self.id, event.code)

  def render
    <self.note id=self.note contentEditable=true
      :keydown.noteChanged
      innerHTML=self.body>

tag sticky-notes

  def setup
    @notes = []
    
    let keys = Object.keys(localStorage).filter do |k|
      k.startsWith("note")
    for key in keys
      @notes.push(JSON.parse(localStorage.getItem(key)))

  # TODO: also handle deletion, maybe delete when hitting backspace in an empty
  # note
  def createNew
    let container = document.querySelector(".notes")
    let count = Object.keys(localStorage).length + 1
    let id = "note-{count}"
    let note = {body: '', id: id}
    localStorage.setItem(id, JSON.stringify(note))
    container.appendChild(<sticky-note body='' id=id callback=self.noteChanged>)

  def noteChanged identifier, keyCode
    const element = document.querySelector("#{identifier}")
    const body = element.innerHTML
    const text = element.innerText
    console.log('TEXT', text)
    if keyCode == 'Backspace' && text.length == 0
      const parent = document.querySelector(".notes")
      parent.removeChild(element)
      localStorage.removeItem(identifier)
    else
      let note = {id: identifier, body: body}
      localStorage.setItem(identifier, JSON.stringify(note))

  def render
    ### css scoped
    h1 {
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
          <sticky-note id=note.id body=note.body callback=self.noteChanged>
imba.mount <sticky-notes>
# TODO: investigate why the last character keeps disappearing randomly during refresh
# TODO: Handle ordering
# TODO: Support drag and drop

