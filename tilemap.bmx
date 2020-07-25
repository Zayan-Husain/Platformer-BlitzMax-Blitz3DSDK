

'////////////////tilemap////////////////////
	
Type ytilemap Extends yentity

	'mx =margin x
	Field lmap:TList, mx = -13, mz = 6, sx = 1, sz = 1
	
	
	Method init()
	
		ytype = "tilemap"
	End Method'end init
	
	
	Method make_tile( x:Float, y:Float, z:Float, id:String )
		
		'floor
		If id = 1 Then
			c =  bbCreateCube()
			o:obstacle =  obstacle.Create( x, y, z, c, 0 )
			o.tile_type = id
			world.add( o )
		EndIf
		
		If id = 2 Then
			s = bbCreateCone()
			bbEntityColor s, 25, 25, 25
			o:obstacle = obstacle.Create( x, y, z, s, 0 )
			o.tile_type = id
			o.ytype = "spikes"
			world.add( o )
			o.collide_c = 0.1
		EndIf
		
		If id = 3 Then
			
			c =  bbCreateCube()
			bbEntityColor c, 0, 255, 0
			o:obstacle =  obstacle.Create( x, y, z, c, 0 )
			o.tile_type = id
			o.yaction = "win"
			world.add( o )
		EndIf
		
		If id = 4 Then
			c = bbCreateSphere()
			bbEntityColor c, 255, 255, 0
			o:obstacle = obstacle.Create( x, y, z, c, 0 )
			o.tile_type = id
			o.yaction = "coin"
			world.add( o )
		EndIf
		If id = 5 Then
			c = bbCreateCube()
			o:obstacle = obstacle.Create( x, y, z, c, 0 )
			o.tile_type = id
			o.alpha( 0 )
			world.add( o )
		EndIf

	
	End Method'end make_tile

	Method removeLevel()
		
		result:TList = get_by_type( "obstacle" )
		For i:yentity = EachIn result
			world.remove( i )
		Next
	EndMethod
		
	Method make_tilemap()
		
		
		'init temp string andstring array
		Local sr:String[]	

		
		'loop all row strings in lmap
		For s:String = EachIn lmap
		  'sr it the current element array
		  sr = s.split( "," )
		
		 'extrary pos cords from sr array
		  tx:Float =  Float( sr[0] )
		  ty:Float = Float( sr[1] )
		  tz:Float = Float( sr[2] )
		  'tile type
		  tilet:String = sr[3]
		  make_tile(  tx, ty, tz, tilet )


		Next
	End Method'end make_tilemap
	
	
	Method load_map( filen:String )
		
		'get file
		mapfile = ReadFile( filen )
		'if no file exit
		If Not mapfile Then Return
		' Print "--map file "+filen+" loaded--"
		'init temp string andstring array
		Local sr:String[]
		Local s:String
		tempr:TList =  New TList 'temporery list to be converted to lmap

		i = 0'iterator
		'loop all file lines
		While Not Eof( mapfile )
			'read current line and put it on temp string
			s = ReadLine( mapfile )
			'Print s
			'split string to array
			'sr = s.split(",")
			'add it to tile map array
			tempr.AddLast s
			i = i+1
		Wend
		
		'copy to lmap
		lmap = tempr.Copy()	

		'close file stream
		CloseStream mapfile
	EndMethod 'end load_map
		
	Method saveMap()
		
						
		'write file
		file = WriteFile( "new_map.txt" )
		
		If Not file RuntimeError "failed to open test.txt file"
	
		
		maptxt:String = ""
		os:TList = get_by_type( "obstacle" )
		For e:yentity = EachIn os
			o:obstacle = obstacle( e )
			l:String = String( o.x ) + "," + String( o.y ) + "," + String( o.z ) + "," + o.tile_type' + "\n"
			WriteLine file, l
			maptxt = maptxt + l
		Next
		spk:TList = get_by_type( "spikes" )
		For e:yentity = EachIn spk
			o:obstacle = obstacle( e )
			l:String = String( o.x ) + "," + String( o.y ) + "," + String( o.z ) + "," + o.tile_type' + "\n"
			WriteLine file, l
			maptxt = maptxt + l
		Next
		'Print maptxt
		
	
		
		
		CloseStream file
		
	EndMethod
	
	Function Create:ytilemap( x:Float = 0, y:Float = 0, z:Float = 0, grafic:Int = 0, speed:Float = 0 )
		
		e:ytilemap =  New ytilemap
		'lmap = lmap2
		e.x = 0
		e.y = 0
		e.z = 0
		e.speed = 0
		e.grafic = 0
		e.ytype = "tilemap"

		
		Return e
	
	EndFunction
	
	

EndType


'////////////////end tilemap////////////////////