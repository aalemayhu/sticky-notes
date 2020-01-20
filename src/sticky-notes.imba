### css

html, body {
  margin: 0;
  padding: 0;
}

body {
  background: center / cover no-repeat url(https://source.unsplash.com/random);
  width: 100vw;
  height: 100vh;
}

.container {
  background: #FFF;
}
###

tag sticky-note

  @isDragging = false

  ### css scoped
    .note {
      background: purple;
      background: #FFFF80;
      min-width: 128px;
      min-height: 128px;
      padding: 1rem;
      margin: 0.15rem;
      border: 0.1rem solid black;
    }

    .dragged {
      opacity: 0.6;
      border-color: white;
    }
  ###

  def noteChanged event
    self.callback(self.id, event.code)

  def dragstart event
    console.log('dragstart', event)
    self.isDragging = true

  def dragend event
    console.log('dragend', event)
    self.isDragging = false

  def render
    <self.note .dragged=(self.isDragging) draggable=true 
    ondragstart=self.dragstart ondragend=self.dragend>
      <div id=self.note contentEditable=true :keydown.noteChanged innerHTML=self.body>

tag sticky-notes

  def setup
    @notes = []
    
    let keys = Object.keys(localStorage).filter do |k|
      k.startsWith("note")
    for key in keys
      @notes.unshift(JSON.parse(localStorage.getItem(key)))

  def createNew
    let container = document.querySelector(".notes")
    let count = Object.keys(localStorage).length + 1
    let id = "note-{count}"
    let note = {body: '', id: id}
    localStorage.setItem(id, JSON.stringify(note))
    let firstNote = container.children[0]
    let newNote = <sticky-note body='' id=id callback=self.noteChanged>
    container.insertBefore(newNote, firstNote)
    newNote.focus()

  def noteChanged identifier, keyCode
    const element = document.querySelector("#{identifier}")
    const body = element.innerHTML
    const text = element.innerText
    console.log('TEXT', text)
    if keyCode == 'Backspace' && text.length == 0
      const parent = document.querySelector(".notes")
      parent.removeChild(element)
      localStorage.removeItem(identifier)
      if parent.children.length > 0
        parent.children[0].focus()
    else
      let note = {id: identifier, body: body}
      localStorage.setItem(identifier, JSON.stringify(note))

  def header
      ### css scoped
      header {
        display: flex;
        justify-content: space-between;
        background: #00000080;
        padding: 0.9rem 1rem;
        margin: 3rem;
      }
      h1 {
          color: white;
          margin: 0.3rem;
          order: 0;
      }
      .new-note-button {
        order: 1;
      }
      ###
      <header>
        <h1> "Sticky Notes"
        <button.new-note-button :click.createNew()> "New"

  def render
    ### css scoped
    h1 {
    }
    .notes {
      display: grid;
      grid-template: 1fr / 1fr;
      margin: 3rem;
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
      self.header()
      <div.notes>
        for note in @notes
          <sticky-note id=note.id body=note.body callback=self.noteChanged>
imba.mount <sticky-notes>

### css
  @media print {
    .new-note-button {
      display: none;
    }
  }
###

# TODO: Handle ordering
# TODO: Support drag and drop
# TODO: add export button, print to pdf
# TODO: Color picker
# TODO: Handle different heights on the sticky notes
# TODO: add default notes when the array is empty (similiar to what stickies do on macOS)
