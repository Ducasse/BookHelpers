Extension { #name : #WriteStream }

{ #category : #'*EpiceaPillarOutputer' }
WriteStream >> newLine [
	self nextPutAll: OSPlatform current lineEnding
]
