trigger ContentDocumentLinkTrgr on ContentDocumentLink (before insert,after insert,before update,after update) {
	System.debug('ContentDocumentLink-Trigger');
}