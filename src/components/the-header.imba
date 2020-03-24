### css
	@media print {
		.new-note-button {
			display: none;
		}
	}
###
tag the-header
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
	<self>
		<header>
			<h1> "Sticky Notes"
			<button.new-note-button
				:click.{console.log(#context.store.createNote())}> "New"
