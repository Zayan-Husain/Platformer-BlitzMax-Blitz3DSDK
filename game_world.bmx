



'////////////////game_world/////////////////////

Type game_world Extends yworld
	
Field cl = 1, tm:ytilemap, score = 0, lives = 3, maxLevels, yhp:helperPivot, ypick, p:player 
Field deletingMode
		
	Method update()
		
		Super.update()
		
		pickDo()
		click_action()
		deleteBlock()
	EndMethod
	
	Method twodupdate()
		
		bbText 75, 20, "Score: " + String( score )
	EndMethod
		
	Method init()
		
		Super.init()
		Print deletingMode
		yhp =  helperPivot.Create()
		
		'init skybox
		skybox = bbCreateSphere( 12 )
		clouds = bbLoadTexture( "gfx/realsky.bmp" )
		bbScaleEntity skybox, 100, 100, 100
		bbEntityTexture skybox, clouds
		'bbScaleTexture clouds, 0.25, 0.25
		bbEntityOrder skybox, 1
		bbFlipMesh skybox
		bbEntityAlpha skybox, 0.25
		bbEntityFX skybox, 8
		skb = yentity.Create( 0, -5, 0, skybox )
		add( skb )


		'init level tilemap
		tm = ytilemap.Create()
		add( tm )
		tm.load_map( "maps/map" + cl + ".txt" )
		tm.make_tilemap()
		'tm.removeLevel()
		'nextLevel()
		
		
		'init player
		c =  bbCreateCube()
		p = player.Create( -3, 0, 7, c, 0.2 )
		add( p )
		p.make_map = True
		spawners:TList = p.get_by_type( "spawn" )
		Print "Count: " + spawners.Count()
		If spawners.Count() > 0 Then
			spawner:obstacle = obstacle( spawners.First() )
			p.sxyz( spawner.x, spawner.y + 1.5, spawner.z )
			spawner.alpha( 0.5 ) 
		EndIf
		
		Rem c2 =  bbCreateCube()
		add( obstacle.Create( 0, -5, 18, c2, 0 ) )
		c3 =  bbCreateCube()
		add( obstacle.Create( -3, -3, 18, c3, 0 ) )
		EndRem

	
	EndMethod' init
	
	
	Method nextLevel()
		
		cl = cl + 1
		Print cl
		Print maxLevels
		If cl > maxLevels Then
			Print "max level reached"
			cl = 1
		EndIf
		init()

		
	EndMethod
		
	Method restartLevel()
		
		lives = lives - 1
		init()
		If lives <= 0 Then

			
			ye.change_world( "game_over" )
		EndIf

	EndMethod
	
	Method pickDo()
		
		yx = bbMouseX()
		yy = bbMouseY()
		mypic = bbCameraPick( ye.camera, yx, yy )
		ypick = mypic
		Return mypic 
	EndMethod 'pickDo
	
	Method deleteBlock()
		
		If kd( 14 ) Then deletingMode = True
		
		If deletingMode Then
			yhp.hide()
			bbPositionEntity yhp.ACube, p.x, p.y, p.z
			If kd( 28 ) Then deletingMode = False

			
		EndIf
		
	EndMethod
	
	Method click_action()
		
		If Not p.make_map Or deletingMode  Then Return

		If ypick <> 0 And yhp.isHelperCube( ypick ) = 1
		
			'move helper pivot to pick
			bbPositionEntity yhp.ACube, bbEntityX( ypick ), bbEntityY( ypick ), bbEntityZ( ypick )
			bbShowEntity yhp.ACube	
			
		
		EndIf
		Local  apos:Float[]
		apos:Float = yhp.getPosf()'get apos piv position xyz as int array
		If bbMouseHit( 1 ) And  ypick <> 0 And dist <= 5 Then CreateBlockOnPick( apos ) 'add cube
	EndMethod
	
	
	
	
	Method CreateBlockOnPick( apos:Float[] )
	
			piv = bbCreatePivot()
			
	
			pick2 = pickDo()
			'Print apos[0]+" "+apos[1]+" "+apos[2]+" "+bbEntityName(pick2)
			Select bbEntityName( pick2 )
							
			   Case "top" 
				bbPositionEntity piv, apos[0], apos[1]+2, apos[2]
							
			   Case "bottom"
				 bbPositionEntity piv, apos[0], apos[1]-2, apos[2]
							
			   Case "front"
				 bbPositionEntity piv, apos[0], apos[1], apos[2]+2
							
			   Case "back"
				 bbPositionEntity piv, apos[0], apos[1], apos[2]-2
							
			   Case "left"
				 bbPositionEntity piv, apos[0]-2, apos[1], apos[2]
							
			   Case "right"
				 bbPositionEntity piv, apos[0]+2, apos[1], apos[2]
			EndSelect
			tm.make_tile( bbEntityX( piv ), bbEntityY( piv ), bbEntityZ( piv ), p.currt )
			'CreateBlock(bbEntityX(piv),bbEntityY(piv),bbEntityZ(piv),"ground")
			bbFreeEntity piv
	
	EndMethod
		
	
		
	Function Create:game_world()
		
		tst:game_world =  New game_world

		
		Return tst
	
	EndFunction

EndType


'////////////////end game_world/////////////////////