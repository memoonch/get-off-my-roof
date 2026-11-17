package com.getoffmyroof.screens
{
   import com.getoffmyroof.rewards.LevelRewards;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.whatthefawk.screens.IScreenItem;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class LevelPassedScreen extends BaseLevelOverScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      public var silver_medal:MovieClip;
      
      public var star_medal:MovieClip;
      
      public var bronze_medal:MovieClip;
      
      public var btn_play_more_xxx_games:btn_play_more_xxx_games_class;
      
      public var txt_points:TextField;
      
      public var btn_buy_new_weapons:btn_buy_new_weapons_class;
      
      public var gold_medal:MovieClip;
      
      public var btn_continue:btn_continue_class;
      
      public var btn_level_selection:btn_level_selection_class;
      
      public var btn_replay_level:btn_replay_level_class;
      
      protected var _lastLevelID:String = "level025";
      
      public var no_medal:MovieClip;
      
      public var btn_next_level:btn_next_level_class;
      
      public var txt_time:TextField;
      
      public var txt_combo:TextField;
      
      public function LevelPassedScreen(param1:IScreenItem = null)
      {
         super(param1);
         var _loc2_:LevelRewards = _playerController.rewards.lastLevelRewards;
         var _loc3_:int = _loc2_.medal;
         if(_loc3_ == LevelRewards.GOLD_STAR_MEDAL)
         {
            this.star_medal.alpha = 1;
         }
         else if(_loc3_ == LevelRewards.GOLD_MEDAL)
         {
            this.gold_medal.alpha = 1;
         }
         else if(_loc3_ == LevelRewards.SILVER_MEDAL)
         {
            this.silver_medal.alpha = 1;
         }
         else if(_loc3_ == LevelRewards.BRONZE_MEDAL)
         {
            this.bronze_medal.alpha = 1;
         }
         else if(_loc3_ == LevelRewards.NO_MEDAL)
         {
            this.no_medal.alpha = 1;
         }
      }
      
      private function onNextLevel() : void
      {
         gameLevelManager.loadSelectedGameLevel();
         gameLevelManager.startLevelCountdown();
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onContinueClick(param1:Event) : void
      {
         if(!isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onContinue
         });
      }
      
      override protected function initButtons(param1:*) : void
      {
         super.initButtons(param1);
         if(_gameLevelManager.currentLevel.id == this._lastLevelID)
         {
            this.btn_next_level.visible = false;
            this.btn_continue.addEventListener(MouseEvent.CLICK,this.onContinueClick,false,0,true);
         }
         else
         {
            this.btn_continue.visible = false;
            this.btn_next_level.addEventListener(MouseEvent.CLICK,this.onNextLevelClick,false,0,true);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.btn_continue.removeEventListener(MouseEvent.CLICK,this.onContinueClick);
         this.btn_next_level.removeEventListener(MouseEvent.CLICK,this.onNextLevelClick);
      }
      
      private function onContinue() : void
      {
         _screenManager.setScreen("OutroScreen");
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onNextLevelClick(param1:Event) : void
      {
         if(!isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onNextLevel
         });
      }
   }
}

