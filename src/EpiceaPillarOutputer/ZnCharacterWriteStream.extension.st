Extension { #name : #ZnCharacterWriteStream }

{ #category : #'*EpiceaPillarOutputer' }
ZnCharacterWriteStream >> crlf [
	self cr; lf
]

{ #category : #'*EpiceaPillarOutputer' }
ZnCharacterWriteStream >> newLine [
	self nextPutAll: OSPlatform current lineEnding
]
