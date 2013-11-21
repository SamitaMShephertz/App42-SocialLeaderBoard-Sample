import com.shephertz.app42.paas.sdk.as3.App42CallBack;
import com.shephertz.app42.paas.sdk.as3.App42Exception;
import com.shephertz.app42.paas.sdk.as3.App42Log;
import com.shephertz.app42.paas.sdk.as3.game.Game;
import com.shephertz.app42.paas.sdk.as3.social.Social;

import starling.display.Button;
import starling.text.TextField;

var loginToggleBtn:Button;
var headerLine1:TextField;
var fbErrorText:TextField;
var alreadyLoginBtn:Button;
var tryAgain:Button;
var logoutBtn:TextField;
var GREY:uint = 0x999999;
var BLACK:uint = 0x000000;
var WHITE:uint = 0xFFFFFF;

class callBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		if(res is Social)
		{
			var social:Social = Social(res);
			App42Log.debug("Response is : " + social);
		}
		
	}
	public function onException(excption:App42Exception):void
	{
		App42Log.debug("Exception is : " + excption);
	}
}

package  
{
	import com.facebook.graph.Facebook;
	import com.facebook.graph.data.FacebookAuthResponse;
	import com.shephertz.app42.paas.sdk.as3.App42API;
	import com.shephertz.app42.paas.sdk.as3.App42Log;
	import com.shephertz.app42.paas.sdk.as3.social.SocialService;
	
	import Screens.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class FaceBookLogin extends Sprite
	{
		protected static const APP_ID:String = "386763061449222"; //Place your application id here
		private var screen:Sprite ;
		public static var fbJSON:Object ="";
		public function FaceBookLogin()
		{
			super();
			App42API.initialize("<Enter_your_APIKey>","<Enter_your_SecretKey>");
			initialize();
			
			var bg:Image = new Image(Assets.getTextue("bg"));
			this.addChild(bg);
			
			var headerLine1:Image = new Image(Assets.getTextue("gameHeaderLine"));
			headerLine1.x = 110;
			headerLine1.y = 100;
			this.addChild(headerLine1);
			
			loginToggleBtn = new Button(Assets.getTextue("loginfacebook"));
			loginToggleBtn.x = 250;
			loginToggleBtn.y = 240;
			this.addChild(loginToggleBtn);
			loginToggleBtn.addEventListener(Event.TRIGGERED, handleLoginClick);
			
			tryAgain= new Button(Assets.getTextue("alreadylogin"));
			tryAgain.x = 300;
			tryAgain.y = 240;
			this.addChild(tryAgain);
			tryAgain.visible=false;
			tryAgain.addEventListener(Event.TRIGGERED, tryAgain_click);
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 510;
			this.addChild(msg);
			
		}
		protected function initialize():void {
			
			//Initialize Facebook library
			Facebook.init(APP_ID, onInit);                        
		}
		
		protected function onInit(result:Object, fail:Object):void {                                                
			if (result) { 
				var screen:Sprite = new Menu;
				this.parent.addChild(screen);
				this.removeFromParent(true);
				var response:FacebookAuthResponse = result as FacebookAuthResponse;
				fbJSON =response;
				App42Log.debug("response is : "+ response.toString())
				var socialService:SocialService = App42API.buildSocialService();
				socialService.linkUserFacebookAccount(fbJSON.uid,fbJSON.accessToken,new callBack());
			} else {
				
				loginToggleBtn.visible=true;;
			}
		}
		
	
		protected function handleLoginClick(event:Event):void {
			
			if (loginToggleBtn) {                                
				var opts:Object = {perms:"user_birthday,user_photos,read_stream, publish_stream, read_requests"};
				Facebook.login(onLogin, opts);
			}
		}
		
		protected function onLogin(result:Object, fail:Object):void {
			if (result) { 
				var screen:Sprite = new Menu;
				this.parent.addChild(screen);
				this.removeFromParent(true); 
				var response:FacebookAuthResponse = result as FacebookAuthResponse;
				fbJSON =response;
				var socialService:SocialService = App42API.buildSocialService();
				socialService.linkUserFacebookAccount(fbJSON.uid,fbJSON.accessToken,new callBack());
				
			} else { 
				loginToggleBtn.visible = false;
				tryAgain.visible = true;
				
			}
		}
		private  function tryAgain_click(e:Event):void
		{
			var screen:Sprite = new FaceBookLogin;
			this.parent.addChild(screen);
			this.removeFromParent(true); 
		}
	}
}