import './components/the-note'
import './components/the-header'

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
tag sticky-notes

	def localStorage
		window.localStorage

	def setup
		@notes = []

		let keys = Object.keys(localStorage()).filter do |k|
			k.startsWith("note")
		for key in keys
			@notes.unshift(JSON.parse(localStorage().getItem(key)))

	def createNew
		let count = Object.keys(localStorage()).length + 1
		const note = {body: '', id: "note-{count}"}
		localStorage().setItem(note.id, JSON.stringify(note))
		self.notes.unshift(note)
		# newNote.focus()

	def updateNote note, event
		const element = document.querySelector("#{note.id}")
		const text = element.innerText.trim()
		const key = event.originalEvent.key
		# Delete note
		if key == 'Backspace' && text.length == 0
			console.log('deleteNote', note)
			self.notes = self.notes.filter do |x|
				x.id != note.id
			localStorage().removeItem(note.id)
			# if parent.length > 0
			#  parent[0].focus()
			return
		const body = element.innerHTML
		localStorage().setItem(note.id, JSON.stringify({id: note.id, body: body}))

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
			<the-header>
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

# TODO: Support drag and drop
# TODO: Handle ordering (save order)
# TODO: Color picker
# TODO: Handle different heights on the sticky notes
# TODO: fix text selection
# TODO: add export button, print to pdf
# TODO: add default notes when the array is empty (similiar to what stickies do on macOS)
# TODO: log of the backgrounds
