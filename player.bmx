
'////////////////player////////////////////

Type player Extends yentity

	'cams = cam speed, grav = gravity
	Field jumping = False, cams:Float = 0.08, grav:Float = 0.5, ograv:Float = 0.5, jump_power:Float = 4
	Field canJump = True, powerupTimer:ytimer, effect:String = "none", make_map, tmap:ytilemap, currt = 1

	Field speedx:Float, speedy:Float, speedz:Float, hspeed:Float = 0.01, dspeed:Float = 0.01, vspeed:Float = 0.05, yaw:Float = 0

	Method init()
	
		Super.init()
		'bbEntityType grafic, 2
		'src_type,dest_type,detectionmethod,response
		'bbCollisions 2, 1, 2, 2
		powerupTimer = ytimer.Create( 25 )
		

		
		
		'get tilemap
		tmaps:TList  = get_by_type( "tilemap" )
		
		tmap = ytilemap( tmaps.FirstLink().Value() )
		
	End Method'end init
	
	Method update()
	
		Super.update()
		
		editMove()
		move()
		cam_pos()
		hit()
		update_effects()
		If Not make_map Then
			adjustPosX()
			adjustPosY()
			adjustPosZ()
		EndIf

	End Method'end update
	'/////////////// cam_po/////////
		
	'/////////////// cam_po/////////

Method cam_pos()

	cam = ye.camera
	
	If Not grafic Then Return
	turn_speed:Float = 1
	
	If kd( 203 ) Then yaw = yaw+turn_speed
	If kd( 205 ) Then yaw = yaw-turn_speed
	
	bbRotateEntity grafic, 0, yaw, 0
	bbRotateEntity cam, 0, yaw, 0
	bbRotateEntity ye.light, 0, yaw, 0
	
	cx:Float = x+Sin( -bbEntityYaw( grafic )+180 )*5.0
	cy:Float = y+2.5
	cz:Float = z+Cos( -bbEntityYaw( grafic )+180 )*7.0
	
	bbPositionEntity cam, cx, cy, cz
	
	EndMethod
	'///////////////move/////////
		
	Method move()
		
	    'if debug mod exit
		If make_map Then Return
		
		
		cam = ye.camera
		'z axis
		If kd( 200 ) Then 
	    '	bbMoveEntity cam, 0, 0, cams
			speedz = speedz + 1
		EndIf
		
		If kd( 208 ) Then 
	    '	bbMoveEntity cam, 0, 0, -cams
			speedz = speedz - 1
			
		EndIf
		
		
		If Not kd( 200 ) And Not kd( 208 ) Then speedz = 0
		
		

		'left right
		' If kd( 203 ) Then 
		' '	bbMoveEntity cam, -cams, 0, 0
		' 	speedx = speedx - 1
		' EndIf
		
		' If kd( 205 ) Then
		' 	' bbMoveEntity cam, cams, 0, 0
		' 	 speedx = speedx + 1
			
		' EndIf
		
		If Not kd( 203 ) And Not kd( 205 ) Then speedx = 0
		

	

		
		'jump
		If kd( 57 ) And Not jumping And canJump Then
			

			 speedy = speedy + jump_power
			 jumping = True
		 	 grav = ograv
		EndIf

		'gravity
		If y < -15  Then
			jumping = False
			 bbPositionEntity cam, 0, 0, -4
			 gw:game_world = game_world( world )
			 gw.restartLevel()
			
		Else


		EndIf
		
		speedy = speedy - grav
		
		'click , to enter edit mod
		If kd( 51 ) Then
			 make_map = True
		EndIf
	
		
	
	End Method'end move
	'/////////////edit move/////////////
		
	Method editMove()
		
		If Not make_map Then Return
		cam = ye.camera

		If kd( 200 ) Then 
	    '	bbMoveEntity cam, 0, 0, cams
	    	bbMoveEntity grafic, 0, 0, cams
		EndIf
		
		If kd( 208 ) Then 
	    '	bbMoveEntity cam, 0, 0, -cams
	    	bbMoveEntity grafic, 0, 0, -cams
		EndIf

		'left right
		' If kd( 203 ) Then 
		' '	bbMoveEntity cam, -speed, 0, 0
		' 	move_by( -speed, 0, 0 )
		' EndIf
		' If kd( 205 ) Then
		' 	 bbMoveEntity cam, speed, 0, 0
		' 	 move_by( speed, 0, 0 )
		' EndIf
		
		'up down
		If kd( 30 ) And make_map Then
			' bbMoveEntity cam, 0, speed,0
			 move_by( 0, speed, 0 )
		EndIf
		
		If kd( 44 ) And make_map Then
			' bbMoveEntity cam, 0, -speed, 0
			 move_by( 0, -speed, 0 )
		EndIf
		
		
		
		o:obstacle = obstacle( collide( "obstacle" ) )
		wint = collide( "win" )
		col_coin = collide( "coin" )
		'place tile
		If kd( 57 ) And make_map And  Not o And Not wint And Not col_coin Then tmap.make_tile( x, y, z, currt )
		
		If kd( 11 ) And make_map Then currt = 0
		If kd( 2 ) And make_map Then currt = 1
		If kd( 3 ) And make_map Then currt = 2
		If kd( 4 ) And make_map Then currt = 3
		If kd( 5 ) And make_map Then currt = 4
		If kd( 6 ) And make_map Then currt = 5
		 
		If kd( 29 ) Or kd( 157 ) And kd( 31 ) Then
				 tmap.saveMap()
				 Print "YOU JUST SAVED THE MAP!!!!!!!!"
		EndIf

		'click . to exit edit mode
		If kd( 52 ) Then
		 	make_map = False
			tmap.saveMap()
		    Print "YOU JUST SAVED THE MAP!!!!!!!!"
		EndIf
		'click , to enter edit mod
		If kd( 51 ) Then
			 make_map = True
		EndIf
	EndMethod
	
	
	'////////adjust pos///////
		
	Method adjustPosX()
		

		xs = ysign( speedx )
		i = 0
		While i <= ylabs( speedx )
			
			If Not collide( "obstacle", xs ) Then
					move_by( xs*hspeed ); 
				Else
					speedx = 0
					Exit 'break
						
			EndIf
			
			i = i+1
		Wend
		
	EndMethod 'adjustPosX
	
	
	
	Method adjustPosY()
		

		ys = ysign( speedy )
		i = 0
		While i <= ylabs( speedy )
			
			If Not collide( "obstacle", 0, ys ) Then
					move_by( 0, ys*vspeed );
					
				Else
					speedy = 0
					Exit 'break
						
			EndIf
			
			i = i+1
		Wend
		
	EndMethod 'adjustPosY
		
	Method adjustPosZ()
		

		zs = ysign( speedz )
		i = 0
		While i <= ylabs( speedz )
			
			If Not collide( "obstacle", 0, 0, zs ) Then
					move_by( 0, 0, zs*dspeed );
				Else
					speedz = 0
					
					Exit 'break
						
			EndIf
			
			i = i+1
		Wend
		
	EndMethod 'adjustPosZ
	
	'////////////collision detection///////////
	
	Method hit()
	
		If make_map Then Return

		'collide obstacle cast yentity to obstacle
		o:obstacle = obstacle( collide( "obstacle" ) )
		
		sp =  collide( "spikes" )
		hit_win =  collide( "win" )
		hit_coin =  collide( "coin" )
		hit_i_coin:obstacle =  obstacle( collide( "i_coin" ) )
		
		top:yentity = collide( "obstacle", 0, -1 )
		

		
		
		If top Then 
			'Print "hit top"
			jumping = False
		Else
			
			
		EndIf
		
		'/////action collide
		If hit_win Then
			'Print  o.yaction'-----the error

			bbPositionEntity ye.camera, 0, 0, -4
			gw:game_world = game_world( world )
			gw.nextLevel()
			ye.change_world( "win_world" )
		EndIf'win
		
		If hit_coin Then
			gw:game_world = game_world( world )
			gw.score = gw.score + 5
			gw.remove( hit_coin )
		EndIf
		If hit_i_coin Then
			gw:game_world = game_world( world )
			If hit_i_coin.activated Then
				gw.score = gw.score + 5
				hit_i_coin.activated = False
			EndIf
		EndIf
		
		If sp Then
				bbPositionEntity ye.camera, 0, 0, -4
				gw:game_world = game_world( world )
				gw.restartLevel()
		EndIf
	
	End Method'end collide ////////////////////
	
	'/////////////hendale effects///////////
		
	Method set_effect( e:String )
		
		effect = e
	EndMethod
	

	
	Method update_effects()
		
		If effect = "nogravity" Then
			canJump = False
			grav = 0
			power_up = True
			If powerupTimer.finished() And power_up Then
				power_up = False
				grav = ograv
				canJump = True
				effect = "none"
			EndIf
		EndIf
	EndMethod
	
	'///////constructor////////
	
	Function Create:player( x:Float, y:Float, z:Float, grafic:Int, speed:Float )
		
		e:player =  New player
		
		e.x = x
		e.y = y
		e.z = z
		e.speed = speed
		e.grafic = grafic
		e.ytype = "player"

		
		Return e
	
	EndFunction

EndType


'////////////////end player////////////////////