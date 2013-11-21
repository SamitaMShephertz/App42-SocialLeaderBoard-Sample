import com.adobe.serialization.json.JSON;
import com.shephertz.app42.paas.sdk.as3.App42CallBack;
import com.shephertz.app42.paas.sdk.as3.App42Exception;
import com.shephertz.app42.paas.sdk.as3.App42Log;
import com.shephertz.app42.paas.sdk.as3.game.FacebookProfile;
import com.shephertz.app42.paas.sdk.as3.game.Game;
import com.shephertz.app42.paas.sdk.as3.game.Score;
import com.shephertz.app42.paas.sdk.as3.game.ScoreBoardService;

import starling.text.TextField;

var fbUserId:String = ""
var headerLine1:TextField;
var fbAccessToken:String = ""
var firstUser:TextField;
var exceptionMessage:TextField;
var firstUserRank:TextField;
var firstUserScore:TextField;
var secondUser:TextField;
var secondUserRank:TextField;
var secondUserScore:TextField;
var thirdUserScore:TextField;
var thirdUser:TextField;
var thirdUserRank:TextField;
var fourthUser:TextField;
var fourthUserRank:TextField;
var fourthUserScore:TextField;
var fifthUser:TextField;
var fifthUserRank:TextField;
var fifthUserScore:TextField;
var clearbtn:TextField;
var scoreBoardService:ScoreBoardService;
var gameName:String = "<Enter_your_game_name>";
class app42CallBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		
		if(res is Game)
		{
			var game:Game = Game(res);
			if(Score(game.getScoreList()[0]) != null) {
				firstUser.text = FacebookProfile(Score(game.getScoreList()[0]).getFacebookList()[0]).getName() ;
				firstUserScore.text =""+ Score(game.getScoreList()[0]).getValue();
				firstUserRank.text = "1";
			}
			if(Score(game.getScoreList()[1]) != null) {
				secondUser.text =  FacebookProfile(Score(game.getScoreList()[1]).getFacebookList()[1]).getName();
				secondUserScore.text =""+ Score(game.getScoreList()[1]).getValue();
				secondUserRank.text = "2";
			}
			if(Score(game.getScoreList()[2]) != null) {
				thirdUser.text =  FacebookProfile(Score(game.getScoreList()[2]).getFacebookList()[2]).getName() ;
				thirdUserScore.text =""+ Score(game.getScoreList()[2]).getValue();
				thirdUserRank.text = "3";
			}
			
			if(Score(game.getScoreList()[3]) != null) {
				fourthUser.text =  FacebookProfile(Score(game.getScoreList()[3]).getFacebookList()[3]).getName() ;
				fourthUserScore.text =""+ Score(game.getScoreList()[3]).getValue();
				fourthUserRank.text = "4";
			}
			if(Score(game.getScoreList()[4]) != null) {
				fifthUser.text =  FacebookProfile(Score(game.getScoreList()[4]).getFacebookList()[4]).getName() ;
				fifthUserScore.text =""+ Score(game.getScoreList()[4]).getValue();
				fifthUserRank.text = "5";
			}	
		}
	}
	public function onException(excption:App42Exception):void
	{
		App42Log.debug("Exception is : " + excption);
		if(excption.getAppErrorCode() == 1401)
		{
			var objectMessage:Object = com.adobe.serialization.json.JSON.decode(excption.message);
			var message:String  = objectMessage["app42Fault"]["details"];
			exceptionMessage.text = message + " please check your credentials.";
		}
	}
}

class saveUserScoreCallBack implements App42CallBack{
	
	public function onSuccess(res:Object):void
	{
		
		if(res is Game)
		{
			var game:Game = Game(res);
			App42Log.debug("response is : " + game)			
		}
	}
	public function onException(excption:App42Exception):void
	{
		App42Log.debug("Exception is : " + excption);
	}
}

package
{
	import com.shephertz.app42.paas.sdk.as3.App42API;
	
	import Screens.Menu;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;
	
	
	public class App42LeaderBoard extends Sprite
	{
		public function App42LeaderBoard(jsonObject:Object) {
			super();
			fbUserId = jsonObject.uid;
			fbAccessToken = jsonObject.accessToken;
			var bg:Image = new Image(Assets.getTextue("bg"));
			this.addChild(bg);
			
			headerLine1 = new TextField(500,150,"","Verdana",20,0x000000,true);
			headerLine1.x = 180;
			headerLine1.y = 10;
			this.addChild(headerLine1);
			headerLine1.visible  = false;
			firstUser = new TextField(500,150,"","Verdana",14,0x000000,true);
			this.addChild(firstUser);
			
			firstUserScore = new TextField(1100,150,"","Verdana",14,0x000000,true);
			this.addChild(firstUserScore);
			
			firstUserRank = new TextField(100,150,"","Verdana",14,0x000000,true);
			this.addChild(firstUserRank);
			
			secondUser = new TextField(500,200,"","Verdana",14,0x000000,false);
			this.addChild(secondUser);
			
			secondUserScore = new TextField(1100,200,"","Verdana",14,0x000000,false);
			this.addChild(secondUserScore);
			
			secondUserRank = new TextField(100,200,"","Verdana",14,0x000000,false);
			this.addChild(secondUserRank);
			
			thirdUser = new TextField(500,250,"","Verdana",14,0x000000,false);
			this.addChild(thirdUser);
			
			thirdUserScore = new TextField(1100,250,"","Verdana",14,0x000000,false);
			this.addChild(thirdUserScore);
			
			thirdUserRank = new TextField(100,250,"","Verdana",14,0x000000,false);
			this.addChild(thirdUserRank);
			
			fourthUser = new TextField(500,300,"","Verdana",14,0x000000,false);
			this.addChild(fourthUser);
			
			fourthUserScore = new TextField(1100,300,"","Verdana",14,0x000000,false);
			this.addChild(fourthUserScore);
			
			fourthUserRank = new TextField(100,300,"","Verdana",14,0x000000,false);
			this.addChild(fourthUserRank);
			
			fifthUser = new TextField(500,350,"","Verdana",14,0x000000,false);
			this.addChild(fifthUser);
			
			fifthUserScore = new TextField(1100,350,"","Verdana",14,0x000000,false);
			this.addChild(fifthUserScore);
			
			fifthUserRank = new TextField(100,350,"","Verdana",14,0x000000,false);
			this.addChild(fifthUserRank);
			
			exceptionMessage = new TextField(650,200,"","Verdana",20,Color.GRAY,true);
			this.addChild(exceptionMessage);
			
			var btn:Button = new Button(Assets.getTextue("menubtn"));
			btn.x = 345;
			btn.y = 340;
			this.addChild(btn);
			btn.addEventListener(Event.TRIGGERED, menuBtn_Click);
			
			var msg:Image = new Image(Assets.getTextue("copyright"));
			msg.x = 0;
			msg.y = 510;
			this.addChild(msg);
			
			var header:Image = new Image(Assets.getTextue("header"));
			header.x = 0;
			header.y = 10;
			this.addChild(header);
			getTopScorerOfTheGame();
			
		}
		
		private function getTopScorerOfTheGame():void
		{
			scoreBoardService = App42API.buildScoreBoardService();
			scoreBoardService.getTopNRankersFromFacebook(gameName,fbAccessToken,5,new app42CallBack());
		}
		
		public function saveUserScore(score:int):void{
			scoreBoardService = App42API.buildScoreBoardService();
			scoreBoardService.saveUserScore(gameName,fbUserId,score,new saveUserScoreCallBack());
		}
		
		public function menuBtn_Click(event:Event):void
		{
			var screen:Sprite = new Menu;
			this.parent.addChild(screen);
			this.removeFromParent(true);
		}
	}
}