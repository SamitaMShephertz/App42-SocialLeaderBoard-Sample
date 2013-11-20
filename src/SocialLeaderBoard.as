package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(frameRate="250" , width="800", height="620")]
	
	public class SocialLeaderBoard extends Sprite
	{
		private var mystarling:Starling;
		
		public function SocialLeaderBoard()
		{
			mystarling = new Starling(FBSample, stage);
			mystarling.antiAliasing = 2;
			mystarling.start();
		}
	}
}