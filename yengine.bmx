



Type yengine

	Field current_world:yworld,camera,light
	
	Field worlds:TList =  New TList

	
	Method init()


'		worlds:TList =  New TList

		light=bbCreateLight()
		camera=bbCreateCamera()

		bbPositionEntity camera,0,0,-4
		
		current_world.init()
		
		While Not bbKeyHit(1)
			
			update()
	
			bbRenderWorld
			twodupdate()
			bbFlip 1
			
			
		Wend
		
	End Method 'end init
	
	Method update()
	
		If current_world Then
			current_world.update()
		EndIf
		
	End Method
	
	Method twodupdate()
	
		If current_world Then
			current_world.twodupdate()
		EndIf
		
	End Method
	
	Method render()
	
		'current_world.update()
		
	End Method
	
	Method add_world(w:yworld,name$)
	

		'Print name
		
		w.name = name
		
		w.ye = Self

		worlds.AddFirst w 
		
		
	End Method 'add_world
	
	Method change_world(name$,init=0)
	
		w:yworld = Null;
		'Print "change world to "+name
		'find world
		For wt:yworld=EachIn worlds
			'Print  wt.name+" = "+name
			If wt.name = name Then
			
				w = wt
			EndIf
		Next
		'if not found exit
	   If w = Null Then Return
		
		If init = 1 And w <> Null Then
			w.init()
		EndIf

		If current_world Then current_world.hide_all()	
For wt:yworld=EachIn worlds
	wt.hide_all()
Next
		current_world = w

		current_world.show_all()
	
	End Method 'change_world
	
	Function Create:yengine()
	
		ye:yengine = New yengine
		Return ye
	
	End Function

End Type

Type yworld

	Field mcs:TList =  New TList
	Field name$,ye:yengine
	
	Method init()
		remove_all()
		mcs = New TList
	End Method
	
	Method update()
		
		For e:yentity=EachIn mcs
			e.update()
		Next
	End Method
	
	Method twodupdate()
		

	End Method
	
	Method render()
	
		For e:yentity=EachIn mcs
			e.render()
		Next
		
	End Method
	
	Method add(e:yentity)
		
		 e.world = Self
		 e.init()
		
		 mcs.AddFirst e
	End Method
		
	Method remove(e:yentity)
		 e.remove()
		 mcs.Remove(e)
	End Method
	
	Method remove_all()
		For e:yentity=EachIn mcs
			remove(e)
		Next
	End Method
	
	Method hide_all()
		
		For e:yentity=EachIn mcs
			If e.grafic Then
				bbHideEntity(e.grafic)
			EndIf
		Next
	End Method
	
	Method show_all()

		For e:yentity=EachIn mcs
			If e.grafic Then
				bbShowEntity(e.grafic)
			EndIf
		Next
	End Method
		
	Function Create:yworld()
	
		yw:yworld= New yworld
		yw.mcs = New TList

		
		Return yw
	
	End Function
	
End Type

'test world
Type tstw Extends yworld

	Method update()
		Super.update()
		
	End Method
	
	Method init()
		Super.init()
		c =  bbCreateCube()
		add(yentity.Create(0,0,0,c,2))
	
		ct =  bbCreateCube()
		add(yentity.Create(0,0,2,ct,2))
	
	End Method
	
	Function Create:tstw()
		
		tst:tstw =  New tstw 

		
		Return tst
	
	End Function

End Type


Type yentity
	
	Field x#,y#,z#,speed#,grafic,ytype$="entity",world:yworld,collide_c# = 2
	
	Method init()
		'Print "init entity"
		
		If grafic<> Null Then
		bbPositionEntity grafic,x,y,z
		EndIf 
		
		

		
	End Method
	
	Method update()
		
		If grafic =Null Then Return
		
	    x = bbEntityX(grafic)
		y = bbEntityY(grafic)	
		z = bbEntityZ(grafic)
		'Print x+"xe"
		'Print y+"ye"
		'Print z+"ze"
		Rem If collide("entity",0,0,1) Then
			Print "hit"
		EndIf
		End Rem
		'If click() Then Print "click"
		
		'If kd(200) Then Print "up"

	
	End Method
	
	Method render()
	
		
	End Method	
	
	Method move_by(mx#=0,my#=0,mz#=0)
	
		If grafic <> 0 Then bbMoveEntity grafic ,mx#,my#,mz#
	
		
		
	End Method	
	
		
	Method set_pos(mx#=0,my#=0,mz#=0)
		bbPositionEntity grafic ,mx#,my#,mz#
		
	End Method	
	
	Method get_by_type:TList (stype$)
		ret:TList =   New TList
		
		For e:yentity=EachIn world.mcs
			If e.ytype = stype Then
				ret.AddFirst e
			EndIf
		Next
		Return ret
	End Method 'get_by_type
	
	Method collide:yentity(stype$,mx#=0,my#=0,mz#=0)
		
		dist#=0
		
		tst = bbCreatePivot(grafic)
		bbTranslateEntity tst ,mx,my,mz
		es:TList  = get_by_type(stype)
		
		For e:yentity=EachIn es
			dist = bbEntityDistance(tst ,e.grafic)
			If dist < collide_c And e <> Self Then
				Return e
			EndIf
		Next
		
		Return Null
	End Method 'end collide
	
		
	Method remove()
		bbFreeEntity grafic
		grafic =0
		
	End Method ' remove
	
	Method alpha(a#)
	
		bbEntityAlpha grafic, a# 
		
	End Method 'alpha
	
		
	Method click()

		bbEntityPickMode grafic,1
		If bbMouseDown (1)Then
			picked = bbCameraPick (world.ye.camera, bbMouseX (), bbMouseY())
			'Print(picked +" "+grafic )
			If picked = grafic Then
				Return True
			EndIf
		EndIf 	
		Return False
		
	End Method ' click
	
	Method kd(key)
	
		If bbKeyDown (key) Then Return True
		
	End Method 'key down
	
	Method sxyz(mx#=0,my#=0,mz#=0)
		bbPositionEntity grafic,mx,my,mz
	End Method	
	
	Method sy(v#)
	
		bbPositionEntity grafic, bbEntityX(grafic),v,bbEntityZ(grafic)
		
	End Method 'sy
	
	Method printxyz()
		 Print x+"xe"
		Print y+"ye"
		Print z+"ze"
	End Method
	
	
	Function Create:yentity(x#=0,y#=0,z#=0,grafic%=0,speed#=0)
		e:yentity = New yentity
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic= grafic
		e.ytype = "entity"
		Return e
	
	End Function

End Type

Type ytimer
	
	Field count, max_count, yfinished
	
	Method finished()
		
		yfinished = False
		count = count+1
		If count >= max_count Then
			count = 0
			yfinished = True
		EndIf
		Return 	yfinished 
	End Method
	
	
	Function Create:ytimer(max_count2=1)
		t:ytimer= New ytimer
		max_count2 = max_count2 * 20
		t.count =0
		t.max_count = max_count2
		t.yfinished=0
		
		Return t
	
	End Function
End Type


'//////////////////helper funcs/////////////////////////


Function ycount_filis_in_dir:Int(dirn$)

	dir=ReadDir(dirn)
	
	c=0
	
	Repeat
		t$=NextFile( dir )
		If t="" Exit
		If t="." Or t=".." Continue
		'Print t	
		c=c+1
	Forever
	


	Return c
EndFunction
