


'////////////////win_world/////////////////////

Type win_world Extends yworld	

	Method init()
		
		Super.init()
		
		
		
	EndMethod
	
	Method twodupdate()
		
		bbText 20, 20, "you win"
		bbText 20, 40, "press space to continue"
		
	EndMethod
	
	Method update()
		
		Super.update()
		nextLevel()
	EndMethod
	
	Method nextLevel()
		
		If bbKeyDown( 57 ) Then
			
			ye.change_world( "game_world" )
		EndIf
	EndMethod
	
	Function Create:win_world()
		
		tst:win_world =  New win_world

		
		Return tst
	
	EndFunction

EndType


'////////////////end win_world/////////////////////