package com.getoffmyroof.screens
{
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.rewards.PlayerRewards;
   import com.getoffmyroof.ui.AchievementBox;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.rewards.achievements.AchievementManager;
   import com.whatthefawk.rewards.achievements.IAchievement;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class AchievementsScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      public var player_stats_container:MovieClip;
      
      protected var _achievements_container:Sprite;
      
      protected var _screenManager:ScreenManager;
      
      public var achievements_container:MovieClip;
      
      protected var _player_stats_container:Sprite;
      
      protected var _audioManager:AudioManager;
      
      protected var _playerController:PlayerController;
      
      protected var _achievementManager:AchievementManager;
      
      public function AchievementsScreen(param1:IScreenItem = null)
      {
         super(param1);
         this._audioManager = GameComponents.instance.getAudioManager();
         this._screenManager = GameComponents.instance.getScreenManager();
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         this._achievementManager = GameComponents.instance.getComponent("AchievementManager");
         if(!this._audioManager.isPlaying("MenuMusic"))
         {
            this._audioManager.play("MenuMusic",100,1,0,"MenuMusic");
         }
         this._player_stats_container = this.player_stats_container;
         this._achievements_container = this.achievements_container;
         this.initButtons();
         this.initScreen();
      }
      
      protected function initButtons() : void
      {
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
      }
      
      protected function initScreen() : void
      {
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:int = 0;
         var _loc13_:String = null;
         var _loc14_:IAchievement = null;
         var _loc15_:String = null;
         var _loc16_:AchievementBox = null;
         var _loc17_:String = null;
         var _loc1_:int = 0;
         var _loc2_:Array = this._achievementManager.achievements;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc14_ = _loc2_[_loc4_];
            _loc15_ = "<b>" + (_loc4_ < 9 ? " " : "") + (_loc4_ + 1) + ".)</b>  " + _loc14_.name;
            _loc16_ = new Assets.UI_ACHIEVEMENT_BOX();
            _loc16_.init(_loc15_,_loc14_.description);
            _loc16_.y = (_loc16_.height + _loc1_) * _loc4_;
            _loc16_.lock.visible = !_loc14_.isComplete;
            this._achievements_container.addChild(_loc16_);
            _loc4_++;
         }
         _loc1_ = 2;
         var _loc5_:PlayerRewards = this._playerController.rewards;
         var _loc9_:int = 0;
         var _loc10_:RegExp = new RegExp(/level0*/g);
         _loc6_ = new Assets.UI_PLAYER_STAT_BOX();
         _loc6_.text.htmlText = "<b>Highest Score:</b> ";
         _loc6_.text.htmlText += _loc5_.highPoints > 0 ? _loc5_.highPoints + " on Day " + _loc5_.highPointsLevelID.replace(_loc10_,"") : "0";
         this._player_stats_container.addChild(_loc6_);
         _loc6_ = new Assets.UI_PLAYER_STAT_BOX();
         _loc6_.text.htmlText = "<b>Highest Combo:</b> ";
         _loc6_.text.htmlText += _loc5_.highCombo > 0 ? _loc5_.highCombo + " on Day " + _loc5_.highComboLevelID.replace(_loc10_,"") : "0";
         _loc6_.y = (_loc6_.height + _loc1_) * ++_loc8_;
         this._player_stats_container.addChild(_loc6_);
         _loc6_ = new Assets.UI_PLAYER_STAT_BOX();
         _loc6_.text.htmlText = "<b>Total Points Earned:</b> " + _loc5_.totalPoints;
         _loc6_.y = (_loc6_.height + _loc1_) * ++_loc8_;
         this._player_stats_container.addChild(_loc6_);
         _loc6_ = new Assets.UI_PLAYER_STAT_BOX();
         _loc6_.text.htmlText = "<b>Total Pigeons Eliminated:</b> " + _loc5_.totalKills;
         _loc6_.y = (_loc6_.height + _loc1_) * ++_loc8_;
         this._player_stats_container.addChild(_loc6_);
         var _loc11_:Array = ["Pigeon","Fat Pigeon","Soldier Pigeon","Crazy Pigeon","Bomber Pigeon","Black Pigeon","Black Fat Pigeon","Black Soldier Pigeon","Black Crazy Pigeon","Black Bomber Pigeon","Brown Pigeon","Brown Fat Pigeon","Brown Soldier Pigeon","Brown Crazy Pigeon","Brown Bomber Pigeon"];
         _loc8_ = 0;
         _loc1_ = 1;
         _loc9_ = _loc6_.y + 4;
         var _loc12_:Dictionary = this._playerController.rewards.killTypes;
         for each(_loc13_ in _loc11_)
         {
            _loc17_ = _loc13_.replace(/\s+/g,"");
            if(_loc12_[_loc17_] != undefined)
            {
               _loc7_ = new Assets.UI_PIGEON_KILLS_BOX();
               _loc7_.text.htmlText = "<b>" + _loc13_ + ":</b> " + _loc12_[_loc17_];
               _loc7_.x = this._player_stats_container.width * 0.5 - _loc7_.width * 0.5;
               _loc7_.y = _loc9_ + (_loc7_.height + _loc1_) * ++_loc8_;
               this._player_stats_container.addChild(_loc7_);
            }
         }
      }
      
      protected function onMainMenuClick(param1:Event) : void
      {
         this._screenManager.setScreen("MainScreen");
      }
      
      override public function dispose() : void
      {
         this._screenManager = null;
         this.btn_main_menu.removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         super.dispose();
      }
   }
}

