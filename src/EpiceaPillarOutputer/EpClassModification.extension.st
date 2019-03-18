Extension { #name : #EpClassModification }

{ #category : #'*EpiceaPillarOutputer' }
EpClassModification >> source [
	"Return the current definition. This message is polymorph for modification and methods"

	^ newClass definitionSource
]
