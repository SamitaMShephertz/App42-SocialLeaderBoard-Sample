package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class Assets
	{
		[Embed(source="../assets/images/logo.png")]
		public static const logo:Class;
		
		[Embed(source="../assets/images/plybtn.png")]
		public static const playBtn:Class;
		
		[Embed(source="../assets/images/leaderboard.png")]
		public static const leaderboard:Class;
		
		[Embed(source="../assets/images/copyright.png")]
		public static const copyright:Class;
		
		[Embed(source="../assets/images/bg.png")]
		public static const bg:Class;
		
		[Embed(source="../assets/images/block.png")]
		public static const block:Class;
		
		[Embed(source="../assets/images/block2.png")]
		public static const block2:Class;
		
		[Embed(source="../assets/images/playAgain.png")]
		public static const playAgain:Class;
		
		[Embed(source="../assets/images/menubtn.png")]
		public static const menubtn:Class;
		
		[Embed(source="../assets/images/share.png")]
		public static const share:Class;
		
		[Embed(source="../assets/images/playAgainText.png")]
		public static const playAgainText:Class;
		
		[Embed(source="../assets/images/gameHeaderLine.png")]
		public static const gameHeaderLine:Class;
		
		[Embed(source="../assets/images/playText.png")]
		public static const playText:Class;
		
		[Embed(source="../assets/images/fb_logout_button.png")]
		public static const fb_logout_button:Class;
		
		[Embed(source="../assets/images/alreadylogin.png")]
		public static const alreadylogin:Class;
		
		[Embed(source="../assets/images/loginfacebook.png")]
		public static const loginfacebook:Class;
		
		
		[Embed(source="../assets/images/header.png")]
		public static const header:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		public static function getTextue(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new Assets[name]();
				gameTextures[name] = Texture.fromBitmap(bitmap);
			}
			
			return gameTextures[name];
		}
	}
}