
Type helperPivot Extends TBBType
	Field ACube,ACubeTop,ACubeBottom,ACubeFront,ACubeBack,ACubeLeft,ACubeRight 
	
	
	Function makeHelperCube(parent,x#,y#,z#,name$,w#,h#,d#)
		'Print"in makeHelperCube"
		Local ret=bbCreateCube(parent)
		bbPositionEntity ret,x,y,z
		bbScaleEntity ret,w,h,d
		bbEntityPickMode ret,2
		bbNameEntity ret,name
		bbEntityAlpha ret,.5
		
		Return ret
	
	End Function 
	
	Method getPos:Int[]()
		Local ret:Int[3] 
		ret[0] = Int( bbEntityX(ACube) )
		ret[1] = Int( bbEntityY(ACube) )
		ret[2] = Int( bbEntityZ(ACube) )
		Return ret
	End Method 'getPos
	
	Method isHelperCube(pick)

	  If pick<>0 And pick<>ACubeTop And pick<>ACubeBottom And pick<>ACubeFront And pick<>ACubeBack And pick<>ACubeLeft And pick<>ACubeRight Then
		'Print 1
		Return 1
	  End If
	  Return 0
	End Method
	
	Method hide()
		bbHideEntity ACube
	End Method 
	
	
	Function Create:helperPivot()
		Local hp:helperPivot =  New helperPivot
		hp.ACube=bbCreatePivot()
		hp.ACubeTop = makeHelperCube(hp.ACube,0,1,0,"top",1,.05,1)
		hp.ACubeBottom = makeHelperCube(hp.ACube,0,-1,0,"bottom",1,.05,1)
		hp.ACubeFront = makeHelperCube(hp.ACube,0,0,1,"front",1,1,.05)
		hp.ACubeBack = makeHelperCube(hp.ACube,0,0,-1,"back",1,1,.05)
		hp.ACubeLeft= makeHelperCube(hp.ACube,-1,0,0,"left",.05,1,1)
		hp.ACubeRight= makeHelperCube(hp.ACube,1,0,0,"right",.05,1,1)
		
		bbHideEntity hp.ACube
		Return hp
	End Function
	
	
	
EndType
