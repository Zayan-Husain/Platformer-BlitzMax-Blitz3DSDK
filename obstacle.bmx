
'////////////////obstacle////////////////////

Type obstacle Extends yentity

	Field yaction:String = "none", tile_type:String = 1
	
	Method init()
	
		Super.init()
		bbEntityType grafic, 1
		'src_type,dest_type,detectionmethod,response
		bbCollisions 1, 2, 2, 2
	
	
	End Method'end init
	

	
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