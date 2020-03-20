export class DefaultStore
	def constructor key
		@localStorage = window.localStorage
		@notes = []

		let keys = Object.keys(@localStorage).filter do |k|
			k.startsWith("note")
		for key in keys
			@notes.unshift(JSON.parse(@localStorage.getItem(key)))

	def createNote body=''
		const length = Object.keys(@localStorage).length
		const note = {body: body, id: "note-{length + 1}"}
		@localStorage.setItem(note.id, JSON.stringify(note))
		@notes.unshift(note)
	
	def deleteNote id
		@notes = @notes.filter do |x| x.id != id
		@localStorage.removeItem(id)

	def updateNote id, body
		const p = JSON.stringify({id: note.id, body: body})
		@localStorage.setItem(note.id, p)
