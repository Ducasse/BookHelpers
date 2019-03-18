Extension { #name : #EpMethodAddition }

{ #category : #'*EpiceaPillarOutputer' }
EpMethodAddition >> method [

	^ method
]

{ #category : #'*EpiceaPillarOutputer' }
EpMethodAddition >> source [
	"Return the current definition. This message is polymorph for modification and methods"

	^ String
		streamContents: [ :st | 
			st nextPutAll: self method realClass name asString.
			self method isMetaSide
				ifTrue: [ st nextPutAll: ' class' ].
			st nextPutAll: ' >> '.
			st nextPutAll: self method sourceCode ]
]
