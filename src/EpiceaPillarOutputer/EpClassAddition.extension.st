Extension { #name : #EpClassAddition }

{ #category : #'*EpiceaPillarOutputer' }
EpClassAddition >> source [
	"Return the current definition. This message is polymorph for modification and methods"
	
	^ class definitionSource
]
