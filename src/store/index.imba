export class DefaultStore
	def constructor key
		@localStorage = window.localStorage
		@notes = []

		let keys = Object.keys(@localStorage).filter do |k|
			k.startsWith("note")
		for key in keys
			@notes.unshift(JSON.parse(@localStorage.getItem(key)))

		if @notes.length == 0
			@notes = [
				{"id":"note-4","body":"<div>Hei there,</div><div><br></div><div>this is an example note<br></div>"}
			]


	def createNote body=''
		const length = Object.keys(@localStorage).length
		const note = {body: body, id: "note-{length + 1}"}
		@localStorage.setItem(note.id, JSON.stringify(note))
		@notes.unshift(note)
	
	def deleteNote id
		@notes = @notes.filter do |x| x.id != id
		@localStorage.removeItem(id)

	def updateNote id, body
		const p = JSON.stringify({id: id, body: body})
		@localStorage.setItem(id, p)
