Extension { #name : #EpLogBrowserPresenter }

{ #category : #'*EpiceaPillarOutputer' }
EpLogBrowserPresenter >> addMenuItemsForSelectedItemsIn: aMenu [
	aMenu
		addGroup: [ :aGroup | 
			self menuActionsForSelectedItems
				do: [ :oldStyleMenuItemArray | 
					aGroup
						addItem: [ :anItem | 
							anItem
								name: oldStyleMenuItemArray first;
								description: oldStyleMenuItemArray third;
								icon: (self iconNamed: oldStyleMenuItemArray fourth);
								action: [ self perform: oldStyleMenuItemArray second ] ] ] ].
	aMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Filters';
						icon: (self iconNamed: #smallFindIcon);
						subMenu: self filtersSubMenu ] ].
	aMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'File Out';
						description: 'Write selected entries to an Ombu file';
						icon: (self iconNamed: #smallSaveAsIcon);
						action: [ self fileOutSelection ] ] ].
	aMenu
		addGroup: [ :aGroup | 
			aGroup
				addItem: [ :anItem | 
					anItem
						name: 'Pillar File Out';
						description: 'Write selected entries to a pillar file';
						icon: (self iconNamed: #smallSaveAsIcon);
						action: [ self pillarOutSelection ] ] ]
]

{ #category : #'*EpiceaPillarOutputer' }
EpLogBrowserPresenter >> pillarOutSelection [
	| entries outputDirectory |
	entries := (self selectedEntryItems collect: [ :each | each entry ]) reversed.
	EpPillarExporter askFileNameAndFileOut: entries in: FileSystem workingDirectory 
]
