"
I output pillar definition out of changes. 

Method addition, modification are considered as method definition in pillar. Class addition. modification are  considered as class definition in pillar. Removal are not interpreter.

In addition saving a new version of a MC package is interpreted as creating a section.  Therefore you can code a new features and once you save the package, selecting the save and the changes will create a section with all the changes. 

I make sure  that the changes are outputted using the line ending convention of the platform. 



"
Class {
	#name : #EpPillarExporter,
	#superclass : #Object,
	#traits : 'EpTEventVisitor',
	#classTraits : 'EpTEventVisitor classTrait',
	#instVars : [
		'file',
		'stream'
	],
	#category : #EpiceaPillarOutputer
}

{ #category : #convenience }
EpPillarExporter class >> askFileNameAndFileOut: entries in: aDirectory [
	| fileNameOrNil file |
	fileNameOrNil := UIManager default
		request: 'Enter a file name (without extension)'
		initialAnswer: 'FileOut_' , (UUID new asString36 first: 3) , '.pillar'.
	fileNameOrNil ifNil: [ ^ self ].
	(fileNameOrNil endsWith: '.pillar') 
		ifFalse: [ fileNameOrNil := fileNameOrNil , '.pillar' ].
	file := (aDirectory / fileNameOrNil) asFileReference.
	self new
		file: file;
		fileOut: entries
]

{ #category : #accessing }
EpPillarExporter >> file [
	^ file
]

{ #category : #accessing }
EpPillarExporter >> file: anObject [
	file := anObject
]

{ #category : #support }
EpPillarExporter >> fileOut: epiceaEntries [
	| visitor |
	visitor := self visitorClass new.
	[ stream := ZnCharacterWriteStream on: ((File named: file fullName ) writeStream).
	visitor stream: stream.
	epiceaEntries reverseDo:
		 [ :anEntry | 
			anEntry content accept: visitor.
			visitor stream newLine ]] ensure: [ stream close ].
]

{ #category : #accessing }
EpPillarExporter >> stream [
	^ stream
]

{ #category : #accessing }
EpPillarExporter >> stream: anObject [
	stream := anObject
]

{ #category : #visitor }
EpPillarExporter >> visitClassChange: aChange [
	self wrappedCode: aChange
]

{ #category : #visitor }
EpPillarExporter >> visitClassRemoval: aChange [
	^ self
]

{ #category : #visitor }
EpPillarExporter >> visitEvent: aChange [
	"does nothing by default"
	^ self
]

{ #category : #visitor }
EpPillarExporter >> visitMethodChange: aChange [

	self wrappedCode: aChange
]

{ #category : #visitor }
EpPillarExporter >> visitMethodRemoval: aChange [
	^ self 
]

{ #category : #visitor }
EpPillarExporter >> visitMonticelloVersionSave: anEvent [
	"to avoid to have two sections when saving on a repo and to have to select only one."
	(anEvent repositoryDescription beginsWith: 'http')
		ifTrue: [ ^ self ].
	stream
		nextPutAll: '!! New Section';
		cr
]

{ #category : #hooks }
EpPillarExporter >> visitorClass [
	^ EpPillarExporter
]

{ #category : #support }
EpPillarExporter >> wrappedCode: aChangeEntity [
	stream
		nextPutAll: '[[[';
		newLine.
	stream
		nextPutAll:
			(aChangeEntity source
				copyReplaceAll: Character cr asString
				with: OSPlatform current lineEnding).
	stream
		newLine;
		nextPutAll: ']]]';
		newLine
]
