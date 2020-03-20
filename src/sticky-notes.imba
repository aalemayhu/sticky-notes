import './components/the-header'
import './components/the-note'
import './components/the-list'

import {DefaultStore} from './store'

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

	def setup
		@store = DefaultStore.new('note')

	def updateNote note, event
		const element = document.querySelector("#{note.id}")
		const text = element.innerText.trim()
		const key = event.originalEvent.key
		# Delete note
		if key == 'Backspace' && text.length == 0
			@store.deleteNote(note.id)
			# if parent.length > 0
			#  parent[0].focus()
			return
		else
			@store.updateNote(note.id, element.innerHTML)

	def render	
		<self.container>
			<the-header>
			<the-list notes=store.notes>
imba.mount <sticky-notes>

# TODO: Support drag and drop
# TODO: Handle ordering (save order)
# TODO: Color picker
# TODO: Handle different heights on the sticky notes
# TODO: fix text selection
# TODO: add export button, print to pdf
# TODO: add default notes when the array is empty (similiar to what stickies do on macOS)
# TODO: log of the backgrounds
