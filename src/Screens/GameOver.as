import com.shephertz.app42.paas.sdk.as3.App42CallBack;
import com.shephertz.app42.paas.sdk.as3.App42Exception;
import com.shephertz.app42.paas.sdk.as3.social.Social;

import starling.display.Button;
import starling.text.TextField;

var share:Button ;
var headerLine1:TextField;
class callBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		if(res is Social)
		{
			var social:Social = res as Social;
			headerLine1.text = "Your Score has been successfully updated on your wall"
		}
	}
	public function onException(excption:App42Exception):void
	{
		headerLine1.text = excption.message
		
	}
}
package Screens
{
	import com.shephertz.app42.paas.sdk.as3.App42API;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.social.SocialService;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	
	public class GameOver extends Sprite
	{
		private var score:int;
		public function GameOver(s:int)
		{
			super();
			score = s;
			new App42LeaderBoard(FBSample.fbJSON).saveUserScore(score);
			var bg:Image = new Image(Assets.getTextue("bg"));
			this.addChild(bg);
			App42Log.setDebug(true);	
			var logo:Image = new Image(Assets.getTextue("logo"));
			logo.x = 250;
			logo.y = 60;
			this.addChild(logo);
			
			var playText:Image = new Image(Assets.getTextue("playAgainText"));
			playText.x = 280;
			playText.y = 210;
			this.addChild(playText);
			
			var gameover:Button = new Button(Assets.getTextue("playAgain"));
			gameover.x = 420;
			gameover.y = 200;
			this.addChild(gameover);
			gameover.addEventListener(Event.TRIGGERED, plyAgainBtn_Click);
			
			share = new Button(Assets.getTextue("share"));
			share.x = 150;
			share.y = 390;
			this.addChild(share);
			share.addEventListener(Event.TRIGGERED, share_click);
			
			var btn:Button = new Button(Assets.getTextue("menubtn"));
			btn.x = 380;
			btn.y = 350;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, menuBtn_Click);
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 510;
			this.addChild(msg);
			
			headerLine1 = new TextField(500,150,"","jing jing",20,Color.GRAY,true);
			headerLine1.x = 150;
			headerLine1.y = 390;
			this.addChild(headerLine1);
			headerLine1.visible  = false;
				
		}
		
		public function menuBtn_Click(event:Event):void
		{
			var screen:Sprite = new Menu;
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
		
		
		public function share_click(event:Event):void
		{
			var socialService:SocialService = App42API.buildSocialService();
			var status:String = "Hey! I scored "+ score + " in Snake War";
			var source:String ="../../assets/images/gameHeaderLine.png" ;
			trace(source);
			socialService.facebookLinkPostWithCustomThumbnail(FBSample.fbJSON.accessToken,"http://api.shephertz.com/",status,
				"../../assets/images/logo.png"
				,"Snake War","Success",new callBack());
			headerLine1.visible = true
			share.visible = false
		}
		public function plyAgainBtn_Click(event:Event):void
		{
			var screen:Sprite = new SinglePlayer();
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
	}
}