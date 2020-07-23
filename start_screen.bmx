


'////////////////start_screen_world/////////////////////

Type start_screen Extends yworld	

	Field start_btn:yentity
	
	Method init()
		
		Super.init()
		
		c =  bbCreateCube()
		
		bbScaleEntity c,2,0.5,1
		startimg = bbLoadTexture( "gfx/playNow.png" )
		bbEntityTexture c, startimg
		
		start_btn =yentity.Create(-2, 0, 3, c, 0)

		add(start_btn)
		
		font = bbLoadFont( "Courier", 20 )
		bbSetFont( font )
		
	EndMethod
	
	Method twodupdate()
		
		
		bbText 20, 40, "Created by: Zayan"
		
	EndMethod
	
	Method update()
		
		Super.update()
		start_click()
	EndMethod
	
	Method start_click()
		
		If start_btn.click() Then
			ye.change_world( "game_world",1 )
		EndIf 
	EndMethod
	
	Function Create:start_screen()
		
		tst:start_screen =  New start_screen

		
		Return tst
	
	EndFunction

EndType


'////////////////end start_screen_world/////////////////////