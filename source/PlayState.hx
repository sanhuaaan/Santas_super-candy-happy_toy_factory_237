package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import flixel.group.FlxGroup;
import flixel.util.FlxSort;
import flixel.system.FlxSound;

class PlayState extends FlxState
{
	private var player:Player;
	private var deskGroup:FlxGroup;
	private var spritesGroup:FlxTypedGroup<FlxSprite>;
	private var songFragment:FlxSound;
	private var i:Int;
	private var whipTxt:FlxText;
	private var txtBlinkTime:Float = 0.1;
	private var txtBlinkPhase:Float = 0;

	override public function create():Void
	{
		super.create();

		FlxG.mouse.visible=false;

		var bg:FlxSprite = new FlxSprite(0,0,"assets/images/bg.png");
		add(bg);

		for (i in 0 ... 5) {
			var tamborrero:FlxSprite = new FlxSprite(100*(i+1),235);
			tamborrero.loadGraphic("assets/images/tamborrero.png",true,48,48);
			tamborrero.animation.add("toca",[0,1,1,2,3,3],4);
			tamborrero.animation.play("toca");
			add(tamborrero);
		}

		spritesGroup = new FlxTypedGroup<FlxSprite>();
		deskGroup = new FlxGroup();
		for (i in 0 ... 13) {
			var esclavo:FlxSprite = new Slelve(i*48+20, i%4*45+295);		
			spritesGroup.add(esclavo);
			var collider:FlxSprite = new FlxSprite(esclavo.x -10, esclavo.y + 28);
			collider.makeGraphic(57,22,FlxColor.BLUE);
			collider.immovable = true;
			deskGroup.add(collider);
		}
		deskGroup.visible = false;
		add(deskGroup);

		player = new Player(319,296);
		add(player);
		
		spritesGroup.add(player.playerSprite);
		spritesGroup.add(player.whipSprite);
		add(spritesGroup);

		i=1;
		songFragment = new FlxSound();
		songFragment.loadEmbedded("assets/sounds/"+i+".ogg");
		songFragment.play(false);		

		whipTxt = new FlxText(0,80, FlxG.width, "Whip 'em!",80);
		whipTxt.setBorderStyle(FlxTextBorderStyle.OUTLINE, 0xff8f000e, 3);
		whipTxt.centerOrigin();
		whipTxt.alignment = FlxTextAlign.CENTER;
		whipTxt.color = 0xff42d823;
		add(whipTxt);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
//FlxG.log.add(player.playerDesksCollider.x);
		FlxG.collide(deskGroup, player.playerDesksCollider);
		//Se coloca playerSprite después del collide, porque si no, tiembla
		player.playerSprite.x = player.playerDesksCollider.x;
		player.playerSprite.y = player.playerDesksCollider.y-30;
		spritesGroup.sort(FlxSort.byY, FlxSort.ASCENDING);

		FlxG.overlap(player.whipSprite,spritesGroup, function(p:Player, s:Slelve){			
			if(player.whipSprite.visible && s.animation.name == "work")
			{	
				s.whipped();
				if(!songFragment.playing)
				{
					i++;
					songFragment.loadEmbedded("assets/sounds/"+i+".ogg");
					songFragment.play();		
					if(i==27)
						songFragment.onComplete = function(){FlxG.switchState(new EndState());};								
				}				
			}
		});

		if(!songFragment.playing)
		{
			txtBlinkPhase += elapsed;
			if(txtBlinkPhase >= txtBlinkTime)
			{
				txtBlinkPhase = 0;
				whipTxt.visible = !whipTxt.visible;
			}	
		}
		else
			whipTxt.visible = false;
			
	}

	//************MECÁNICA
	//Si pasas mucho tiempo entre látigazo y latigazo->mal
	//si pegas siempre al/los mismo(s) -> mal
}