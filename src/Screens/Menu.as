import starling.text.TextField;
var headerLine1:TextField;
package Screens
{
	import com.facebook.graph.Facebook;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class Menu extends Sprite
	{
		public function Menu()
		{
			super();
			
			var bg:Image = new Image(Assets.getTextue("bg"));
			this.addChild(bg);
			
			var logo:Image = new Image(Assets.getTextue("logo"));
			logo.x = 250;
			logo.y = 60;
			this.addChild(logo);
			
			var playText:Image = new Image(Assets.getTextue("playText"));
			playText.x = 290;
			playText.y = 260;
			this.addChild(playText);
			
			var btn:Button = new Button(Assets.getTextue("playBtn"));
			btn.x = 400;
			btn.y = 230;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, plyBtn_Click);
			
			var userScore:Button = new Button(Assets.getTextue("leaderboard"));
			userScore.x = 270;
			userScore.y = 360;
			this.addChild(userScore);
			userScore.addEventListener(Event.TRIGGERED, userScore_Click);
			
			var logout:Button = new Button(Assets.getTextue("fb_logout_button"));
			logout.x = 500;
			logout.y = 480;
			this.addChild(logout);
			logout.addEventListener(Event.TRIGGERED, fbLogout_Click);
			
			
			headerLine1 = new TextField(500,150,"","Verdana",20,0x000000,true);
			headerLine1.x = 180;
			headerLine1.y = 10;
			this.addChild(headerLine1);
			headerLine1.visible = false;
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 510;
			this.addChild(msg);
		}
		
		public function plyBtn_Click(event:Event):void
		{
			var screen:Sprite = new SinglePlayer();
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
		
		public function userScore_Click(event:Event):void
		{
			var screen:Sprite = new App42LeaderBoard(FaceBookLogin.fbJSON);
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
		
		public function fbLogout_Click(event:Event):void
		{
			Facebook.logout(onLogout);	;
		}
		protected function onLogout(success:Boolean):void {  
			var screen:Sprite = new FaceBookLogin();
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
	}
}