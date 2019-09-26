Class {
	#name : #BaselineOfBugJarTarandi,
	#superclass : #BaselineOf,
	#category : #BaselineOfBugJarTarandi
}

{ #category : #baselines }
BaselineOfBugJarTarandi >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec package: 'BugJarTarandi'.	
		
	]
]
