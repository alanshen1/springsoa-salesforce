trigger ContentDocumentTrgr on ContentDocument (before insert,after insert,before update,after update) {
	System.debug('ContentDocument-Trigger');
}