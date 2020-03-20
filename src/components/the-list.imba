### css scoped
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
tag the-list
	<self>
		<div.notes>
			for note in @notes
				<sticky-note note=note 
				:emptynote.deleteNote(note)
				:notechanged.updateNote(note, $)>