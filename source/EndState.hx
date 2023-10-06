package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;

class EndState extends FlxState
{

	private var endTxt:FlxText;
	private var twitterTxt:FlxText;

	override public function create()
	{
		super.create();

		FlxG.mouse.visible=false;

		endTxt = new FlxText(0,80, FlxG.width, "Merry Christmas!!!",80);
		endTxt.alignment = FlxTextAlign.CENTER;
		endTxt.color = 0xffe60016;
		endTxt.setBorderStyle(FlxTextBorderStyle.SHADOW, 0xff23c700, 3);
		add(endTxt);

		twitterTxt = new FlxText(0, FlxG.height-30, FlxG.width, "@papa_oom_mowmow",25);
		twitterTxt.color = 0xff3cafab;
		add(twitterTxt);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
	
}