package com.getoffmyroof.screens
{
   import SWFStats.Log;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quad;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.utils.TimeUtil;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import fog.as3.FogDevAPI;
   
   public class BaseLevelOverScreen extends AScreen
   {
      
      private var m_timeLeft:Number = 0;
      
      private var m_tallyTime:int = 100;
      
      private var m_pointsTallySpeed:Number;
      
      private var m_comboTallySpeed:Number;
      
      protected var _rewardSystem:RewardSystem;
      
      protected var _screenManager:ScreenManager;
      
      private var m_pointsDone:Boolean = false;
      
      private var m_timeLeftDone:Boolean = false;
      
      protected var _playerController:PlayerController;
      
      private var m_combo:Number = 0;
      
      protected var _audioManager:AudioManager;
      
      private var m_comboDone:Boolean = false;
      
      private var m_timeLeftTallySpeed:Number;
      
      private var m_isFinishedTallyingPoints:Boolean = false;
      
      private var m_points:Number = 0;
      
      protected var _gameLevelManager:GameLevelManager;
      
      public function BaseLevelOverScreen(param1:IScreenItem = null)
      {
         super(param1);
         this._rewardSystem = GameComponents.instance.getComponent("RewardSystem");
         this._audioManager = GameComponents.instance.getAudioManager();
         this._screenManager = GameComponents.instance.getScreenManager();
         this._gameLevelManager = GameComponents.instance.getComponent("GameLevelManager");
         this._playerController = GameComponents.instance.getComponent("PlayerController");
         x = Root.WIDTH / 2 - width / 2 - 57;
         y = Root.HEIGHT / 2 - height / 2;
         TweenMax.from(this,1,{
            "alpha":0,
            "ease":Quad.easeOut
         });
         this.initButtons(this);
         this.initTallySpeeds();
      }
      
      protected function onBuyNewWeaponsClick(param1:Event) : void
      {
         if(!this.m_isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onBuyNewWeapons
         });
      }
      
      protected function onPlayMoreGamesClick(param1:Event) : void
      {
         var _loc2_:FogDevAPI = GameComponents.instance.getComponent("FogAPI");
         _loc2_.Tracking.GotoURL("http://www.freeonlinegames.com/tag/Arcade_Games");
      }
      
      protected function onMainMenuClick(param1:Event) : void
      {
         if(!this.m_isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onMainMenu
         });
      }
      
      public function get gameLevelManager() : GameLevelManager
      {
         return this._gameLevelManager;
      }
      
      private function onBuyNewWeapons() : void
      {
         this._screenManager.setScreen("ItemShopScreen");
      }
      
      protected function onLevelSelectionClick(param1:Event) : void
      {
         if(!this.m_isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onLevelSelection
         });
      }
      
      private function onLevelSelection() : void
      {
         this._screenManager.setScreen("LevelSelectScreen");
      }
      
      protected function onReplayLevelClick(param1:Event) : void
      {
         if(!this.m_isFinishedTallyingPoints)
         {
            return;
         }
         TweenMax.to(this,0.5,{
            "alpha":0,
            "ease":Quad.easeOut,
            "onComplete":this.onReplay
         });
      }
      
      private function onReplay() : void
      {
         Log.LevelCounterMetric("Replay",this._gameLevelManager.currentLevel.id);
         this._gameLevelManager.selectGameLevel(this._gameLevelManager.currentLevel.id);
         this._screenManager.setScreen("GameScreen");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._rewardSystem = null;
         this._audioManager = null;
         this._screenManager = null;
         this._gameLevelManager = null;
         removeEventListener(MouseEvent.CLICK,this.onClick);
         getChildByName("btn_replay_level").removeEventListener(MouseEvent.CLICK,this.onReplayLevelClick);
         getChildByName("btn_level_selection").removeEventListener(MouseEvent.CLICK,this.onLevelSelectionClick);
         getChildByName("btn_buy_new_weapons").removeEventListener(MouseEvent.CLICK,this.onBuyNewWeaponsClick);
         getChildByName("btn_main_menu").removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         getChildByName("btn_play_more_xxx_games").removeEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick);
      }
      
      private function onMainMenu() : void
      {
         this._screenManager.setScreen("MainScreen");
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.tally(this);
      }
      
      protected function quickTallyPoints() : void
      {
         this.m_points = this._rewardSystem.points;
         this.m_pointsDone = true;
         this.m_combo = this._rewardSystem.highCombo;
         this.m_comboDone = true;
         this.m_timeLeft = this._gameLevelManager.levelTimer.time;
         this.m_timeLeftDone = true;
         this.tally(this);
      }
      
      public function get isFinishedTallyingPoints() : Boolean
      {
         return this.m_isFinishedTallyingPoints;
      }
      
      protected function initButtons(param1:*) : void
      {
         addEventListener(MouseEvent.CLICK,this.onClick,false,0,true);
         param1.btn_replay_level.addEventListener(MouseEvent.CLICK,this.onReplayLevelClick,false,0,true);
         param1.btn_level_selection.addEventListener(MouseEvent.CLICK,this.onLevelSelectionClick,false,0,true);
         param1.btn_buy_new_weapons.addEventListener(MouseEvent.CLICK,this.onBuyNewWeaponsClick,false,0,true);
         param1.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
         param1.btn_play_more_xxx_games.addEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick,false,0,true);
      }
      
      private function initTallySpeeds() : void
      {
         this.m_pointsTallySpeed = this._rewardSystem.points / this.m_tallyTime;
         this.m_comboTallySpeed = this._rewardSystem.highCombo / this.m_tallyTime;
         this.m_timeLeftTallySpeed = this._gameLevelManager.levelTimer.time / this.m_tallyTime;
      }
      
      protected function onClick(param1:Event) : void
      {
         if(this.m_isFinishedTallyingPoints)
         {
            return;
         }
         this.quickTallyPoints();
      }
      
      protected function tally(param1:*) : void
      {
         if(this.m_isFinishedTallyingPoints)
         {
            return;
         }
         if(!this.m_pointsDone)
         {
            if(this.m_points < this._rewardSystem.points)
            {
               this.m_points += this.m_pointsTallySpeed;
            }
            else
            {
               this.m_points = this._rewardSystem.points;
               this.m_pointsDone = true;
            }
         }
         if(!this.m_comboDone)
         {
            if(this.m_combo < this._rewardSystem.highCombo)
            {
               this.m_combo += this.m_comboTallySpeed;
            }
            else
            {
               this.m_combo = this._rewardSystem.highCombo;
               this.m_comboDone = true;
            }
         }
         if(!this.m_timeLeftDone)
         {
            if(this.m_timeLeft < this._gameLevelManager.levelTimer.time)
            {
               this.m_timeLeft += this.m_timeLeftTallySpeed;
            }
            else
            {
               this.m_timeLeft = this._gameLevelManager.levelTimer.time;
               this.m_timeLeftDone = true;
            }
         }
         param1.txt_points.htmlText = "<b>" + int(this.m_points) + "</b>";
         param1.txt_combo.htmlText = "<b>" + int(this.m_combo) + "</b>";
         param1.txt_time.htmlText = "<b>" + TimeUtil.formatTime(this.m_timeLeft) + "</b>";
         if(this.m_pointsDone && this.m_comboDone && this.m_timeLeftDone)
         {
            this.m_isFinishedTallyingPoints = true;
         }
      }
   }
}

