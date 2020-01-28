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

  def dragstart event
    console.log('dragstart', event)
    self.isDragging = true

  def dragend event
    console.log('dragend', event)
    self.isDragging = false

  def focusOnNote
    const element = self.children[0]
    element.focus()

  def render
    <self.note .dragged=(self.isDragging) draggable=true 
    :click.focusOnNote()
    ondragstart=self.dragstart ondragend=self.dragend>
      <div id=self.note.id contentEditable=true 
      :keydown.backspace.trigger('emptynote')
      :keydown.trigger('notechanged') innerHTML=self.note.body>


tag sticky-notes

  def setup
    @notes = []
    
    let keys = Object.keys(localStorage).filter do |k|
      k.startsWith("note")
    for key in keys
      @notes.unshift(JSON.parse(localStorage.getItem(key)))

  def createNew
    let count = Object.keys(localStorage).length + 1
    let id = "note-{count}"
    localStorage.setItem(id, JSON.stringify({body: '', id: id}))
    let firstNote = self.notes.children[0]
    let newNote = <sticky-note body='' id=id>
    self.notes.insertBefore(newNote, firstNote)
    newNote.focus()

  def deleteNote note
    let element = document.querySelector("#{note.id}")
    const text = element.innerText.trim()
    console.log('text', text, text.length)
    return if text.length > 0
    self.notes = self.notes.filter do |x|
      x.id != note.id
    const parent = self.notes
    localStorage.removeItem(note.id)
    if parent.length > 0
      parent[0].focus()

  def updateNote note, event
    const element = document.querySelector("#{note.id}")
    const body = element.innerHTML
    localStorage.setItem(note.id, JSON.stringify({id: note.id, body: body}))

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
          <sticky-note note=note 
          :emptynote.deleteNote(note)
          :notechanged.updateNote(note, $)>
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
