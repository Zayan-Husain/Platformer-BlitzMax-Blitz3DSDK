
'////////////////obstacle////////////////////

Type obstacle Extends yentity

	Field yaction:String = "none", tile_type:String = 1, activatedTimer:ytimer, activated = True, activatedTimerTime = 5
	
	Method init()
	
		Super.init()
		'bbEntityType grafic, 1
		'src_type,dest_type,detectionmethod,response
		'bbCollisions 1, 2, 2, 2
		activatedTimer = ytimer.Create( activatedTimerTime )
		
		bbEntityPickMode grafic,1
	
	End Method'end init
	
	
	Method update()
	
		Super.update()

		ydelete()
		eternalCoin()

	End Method'end update	
	
	Method ydelete()
		gw:game_world = game_world( world )
		If Not gw.deletingMode Then Return
		If click(1) Then
		  ps:TList  = get_by_type( "player" )
			p:player = player( ps.FirstLink().Value() )
			If p.make_map Then world.remove( Self )
			
		EndIf

	End Method'end ydelete
	
	Method eternalCoin()

		If Not activated Then
			 visable(0)
			If activatedTimer.finished() Then
				activated = True
				visable(1)
			EndIf
		EndIf
		
	EndMethod
	
	Function Create:obstacle( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:obstacle =  New obstacle
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "obstacle"

		
		Return e
	
	EndFunction

EndType


'////////////////end obstacle////////////////////