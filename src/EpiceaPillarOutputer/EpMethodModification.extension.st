Extension { #name : #EpMethodModification }

{ #category : #'*EpiceaPillarOutputer' }
EpMethodModification >> method [
	^ self newMethod
]

{ #category : #'*EpiceaPillarOutputer' }
EpMethodModification >> source [

	^ String
		streamContents: [ :st | 
			st nextPutAll: self method realClass name asString.
			st nextPutAll: ' >> '.
			st nextPutAll: self method sourceCode ]
]
