package com.getoffmyroof.screens
{
   import SWFStats.Log;
   import com.getoffmyroof.assets.Assets;
   import com.getoffmyroof.controllers.PlayerController;
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.engine.GameEngine;
   import com.getoffmyroof.engine.GameEvent;
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.entity.PlayerEvent;
   import com.getoffmyroof.levels.GameLevelEvent;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.popups.PopupManager;
   import com.getoffmyroof.rewards.LevelRewards;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.getoffmyroof.rewards.RewardSystemEvent;
   import com.getoffmyroof.save.SaveLoadManager;
   import com.getoffmyroof.ui.GameButton;
   import com.getoffmyroof.ui.PlayerUI;
   import com.greensock.TweenMax;
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.audio.AudioTypes;
   import com.whatthefawk.display.DisplayManager;
   import com.whatthefawk.entity.GameWorld;
   import com.whatthefawk.entity.ICollisionProcess;
   import com.whatthefawk.entity.ICollisionResponse;
   import com.whatthefawk.entity.IMessageDispatcher;
   import com.whatthefawk.entity.SpatialCollisionProcess;
   import com.whatthefawk.math.Vector2D;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.utils.FPS;
   import com.whatthefawk.utils.Input;
   import com.whatthefawk.utils.KeyCode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class GameScreen extends AScreen
   {
      
      private var m_audioManager:AudioManager;
      
      private var m_isPaused:Boolean = false;
      
      private var m_isComplete:Boolean = false;
      
      private var m_fps:FPS;
      
      private var m_displayManager:DisplayManager;
      
      private var m_isTutorialShowing:Boolean = false;
      
      private var m_gameLevelManager:GameLevelManager;
      
      private var m_gameComponents:GameComponents;
      
      private var m_pauseDelay:int = 0;
      
      private var m_tutorialButton:GameButton;
      
      private var m_playerUI:PlayerUI;
      
      private var m_endingAnimation:MovieClip;
      
      private var m_screenManager:ScreenManager;
      
      private var m_rewardSystem:RewardSystem;
      
      private var m_saveLoadManager:SaveLoadManager;
      
      private var m_countdownAnimation:MovieClip;
      
      private var m_gameFactory:GameFactory;
      
      private var m_gameWorld:GameWorld;
      
      private var m_playerController:PlayerController;
      
      private var m_popupManager:PopupManager;
      
      private var m_player:Player;
      
      public function GameScreen(param1:IScreenItem = null)
      {
         super(param1);
         Root.stage.focus = this;
         this.m_fps = new FPS(Root.stage);
         this.m_gameComponents = GameComponents.instance;
         this.m_gameFactory = this.m_gameComponents.getGameFactory();
         this.m_popupManager = this.m_gameComponents.getComponent("PopupManager");
         this.m_rewardSystem = this.m_gameComponents.getComponent("RewardSystem");
         this.m_audioManager = this.m_gameComponents.getAudioManager();
         this.m_screenManager = this.m_gameComponents.getScreenManager();
         this.m_displayManager = this.m_gameComponents.getDisplayManager();
         this.m_gameLevelManager = this.m_gameComponents.getComponent("GameLevelManager");
         this.m_saveLoadManager = this.m_gameComponents.getComponent("SaveLoadManager");
         this.m_playerController = this.m_gameComponents.getComponent("PlayerController");
         this.m_audioManager.fadeOut("MenuMusic");
         this.m_countdownAnimation = new Assets.COUNTDOWN_ANIMATION();
         this.m_countdownAnimation.x = Root.WIDTH / 2;
         this.m_countdownAnimation.y = Root.HEIGHT / 2;
         this.m_gameLevelManager.addEventListener(GameLevelEvent.LEVEL_COUNTDOWN_START,this.onLevelCountdownStart,false,0,true);
         this.m_gameLevelManager.addEventListener(GameLevelEvent.LEVEL_COMPLETE,this.onLevelComplete,false,0,true);
         this.m_rewardSystem.addEventListener(RewardSystemEvent.POINTS,this.onRewardSystemPoints,false,0,true);
         this.m_gameComponents.registerComponent("GameScreen",this);
         this.loadGameWorld();
         this.loadDisplayManager();
         this.loadPlayer();
         this.loadGameUI();
         this.loadGameLevel();
      }
      
      private function onRewardSystemPoints(param1:RewardSystemEvent) : void
      {
         var _loc2_:Object = param1.data;
         this.m_popupManager.deployPointsPopup(_loc2_.position,_loc2_.points);
      }
      
      public function loadGameWorld() : void
      {
         var _loc1_:Vector2D = new Vector2D(640,480);
         var _loc2_:Vector2D = new Vector2D(640,480);
         var _loc3_:ICollisionResponse = this.m_gameComponents.getCollisionResponse();
         var _loc4_:ICollisionProcess = new SpatialCollisionProcess(_loc1_.x,_loc1_.y,46,_loc3_);
         var _loc5_:IMessageDispatcher = this.m_gameComponents.getMessageDispatcher();
         this.m_gameWorld = this.m_gameFactory.createGameWorld(_loc1_,_loc2_,this,_loc4_,_loc5_);
         var _loc6_:int = 525;
         var _loc7_:int = 470;
         this.m_gameWorld.bounds.set(new Vector2D(_loc6_ * 0.5,_loc7_ * 0.5),_loc6_,_loc7_);
      }
      
      private function handleInput() : void
      {
         var _loc1_:Input = Input.instance;
         if(_loc1_.isKeyPressed(KeyCode.P))
         {
            if(!this.m_isComplete)
            {
               this.togglePauseScreen();
            }
         }
      }
      
      public function onLevelCountdownEnd(param1:Event) : void
      {
         var _loc2_:String = this.m_gameLevelManager.currentLevel.music;
         this.m_audioManager.play(_loc2_,100,0.5,0,"LevelMusic");
         this.m_countdownAnimation.removeEventListener(Event.COMPLETE,this.onLevelCountdownEnd);
         removeChild(this.m_countdownAnimation);
         Log.Play();
         Log.LevelCounterMetric("Played",this.m_gameLevelManager.currentLevel.id);
         if(this.m_gameLevelManager.currentLevel.id == "level001")
         {
            if(!this.m_playerController.hasSeenTutorial)
            {
               TweenMax.delayedCall(0.75,this.showTutorial);
            }
         }
      }
      
      private function showEnding() : void
      {
         this.m_screenManager.setScreen("OutroScreen");
      }
      
      public function loadGameUI() : void
      {
         this.m_playerUI = this.m_gameFactory.getEntity("PlayerUI");
         this.m_playerUI.setPlayer(this.m_player);
         this.m_playerUI.setGameScreen(this);
         this.m_playerUI.setRewardSystem(this.m_rewardSystem);
         this.m_playerUI.setGameLevelManager(this.m_gameLevelManager);
         this.m_tutorialButton = new Assets.TUTORIAL_BUTTON();
         this.m_tutorialButton.x += 60;
         this.m_tutorialButton.y = this.m_gameWorld.bounds.height - this.m_tutorialButton.height + 7;
         this.m_tutorialButton.addEventListener(MouseEvent.CLICK,this.onTutorialClick,false,0,true);
         addChild(this.m_tutorialButton);
      }
      
      public function loadDisplayManager() : void
      {
         this.m_displayManager.addDisplay("ParticleEffectDisplayTop",this.m_gameFactory.getEntity("ParticleEffectDisplayTop"));
         this.m_displayManager.addDisplay("ParticleEffectDisplayBottom",this.m_gameFactory.getEntity("ParticleEffectDisplayBottom"));
         this.m_displayManager.setGameCamera(this.m_gameWorld.camera);
      }
      
      public function get gameLevelManager() : GameLevelManager
      {
         return this.m_gameLevelManager;
      }
      
      private function onPauseScreenClose(param1:Event) : void
      {
         this.togglePauseScreen();
      }
      
      override public function dispose() : void
      {
         this.m_fps.dispose();
         this.m_fps = null;
         this.m_isPaused = true;
         this.m_gameLevelManager.reset();
         this.m_rewardSystem.removeEventListener(RewardSystemEvent.POINTS,this.onRewardSystemPoints);
         this.m_gameLevelManager.removeEventListener(GameLevelEvent.LEVEL_COUNTDOWN_START,this.onLevelCountdownStart);
         this.m_gameLevelManager.removeEventListener(GameLevelEvent.LEVEL_COMPLETE,this.onLevelComplete);
         this.m_audioManager.stopType(AudioTypes.SOUND);
         this.m_gameComponents.unregisterComponent("GameScreen");
         this.m_gameWorld.dispose();
         this.m_gameWorld = null;
         this.m_gameFactory = null;
         this.m_gameComponents = null;
         this.m_popupManager = null;
         this.m_rewardSystem = null;
         this.m_audioManager = null;
         this.m_screenManager = null;
         this.m_displayManager = null;
         this.m_gameLevelManager = null;
         this.m_saveLoadManager = null;
         this.m_playerController = null;
         this.m_player = null;
         this.m_playerUI = null;
         this.m_countdownAnimation = null;
         this.m_tutorialButton.removeEventListener(MouseEvent.CLICK,this.onTutorialClick);
         this.m_tutorialButton = null;
         super.dispose();
      }
      
      private function onTutorialClose(param1:Event) : void
      {
         this.m_isTutorialShowing = false;
         this.m_isPaused = !this.m_isPaused;
         var _loc2_:TutorialScreen = param1.target as TutorialScreen;
         _loc2_.removeEventListener(Event.CLOSE,this.onTutorialClose);
         this.m_screenManager.removeChildScreen("TutorialScreen",this);
         Root.stage.focus = this;
      }
      
      private function onPlayerDead(param1:Event = null) : void
      {
         this.m_isComplete = true;
         var _loc2_:String = this.m_gameLevelManager.currentLevel.music;
         this.m_audioManager.crossFade("LoseLevelMusic",_loc2_);
         this.updatePlayerRewards(false);
         this.m_saveLoadManager.save("local",this.m_playerController.getValueObject());
         this.m_gameLevelManager.isLevelActive = false;
         this.m_screenManager.addChildScreen("LevelFailedScreen",this);
         getChildScreen("LevelFailedScreen").addEventListener(Event.CLOSE,this.onPlayerDeadScreenClose);
      }
      
      private function onPlayerDeadScreenClose(param1:Event) : void
      {
         this.m_isComplete = false;
         removeChildScreen("LevelFailedScreen");
         Root.stage.focus = this;
      }
      
      private function onTutorialClick(param1:Event) : void
      {
         this.showTutorial();
      }
      
      public function get gameFactory() : GameFactory
      {
         return this.m_gameFactory;
      }
      
      private function togglePauseScreen() : void
      {
         if(this.m_isTutorialShowing)
         {
            return;
         }
         this.m_isPaused = !this.m_isPaused;
         if(this.m_isPaused)
         {
            this.m_countdownAnimation.stop();
            this.m_screenManager.addChildScreen("PauseScreen",this);
            getChildScreen("PauseScreen").addEventListener(Event.CLOSE,this.onPauseScreenClose,false,0,true);
            this.m_audioManager.pause();
            dispatchEvent(new Event(GameEvent.PAUSE));
            this.m_gameWorld.update(1);
         }
         else
         {
            this.m_countdownAnimation.play();
            getChildScreen("PauseScreen").removeEventListener(Event.CLOSE,this.onPauseScreenClose);
            removeChildScreen("PauseScreen");
            this.m_audioManager.unpause();
            Root.stage.focus = this;
         }
      }
      
      private function onLevelComplete(param1:GameLevelEvent = null) : void
      {
         this.m_isComplete = true;
         this.m_isPaused = true;
         this.m_pauseDelay = 99;
         var _loc2_:String = this.m_gameLevelManager.currentLevel.music;
         this.m_audioManager.crossFade("WinLevelMusic",_loc2_);
         this.updatePlayerRewards(true);
         this.m_saveLoadManager.save("local",this.m_playerController.getValueObject());
         this.m_screenManager.addChildScreen("LevelPassedScreen",this);
         getChildScreen("LevelPassedScreen").addEventListener(Event.CLOSE,this.onLevelCompleteScreenClose);
      }
      
      private function onLevelCompleteScreenClose(param1:Event) : void
      {
         this.m_isComplete = false;
         this.m_isPaused = false;
         removeChildScreen("LevelPassedScreen");
         Root.stage.focus = this;
      }
      
      private function updatePlayerRewards(param1:Boolean = false) : void
      {
         this.m_rewardSystem.lock();
         var _loc2_:LevelRewards = new LevelRewards();
         _loc2_.levelID = this.m_gameLevelManager.currentLevel.id;
         _loc2_.time = this.m_rewardSystem.timePassed;
         _loc2_.kills = this.m_rewardSystem.kills;
         _loc2_.points = this.m_rewardSystem.points;
         _loc2_.killTypes = this.m_rewardSystem.killTypes;
         _loc2_.highCombo = this.m_rewardSystem.highCombo;
         _loc2_.playerHealth = this.m_playerController.player.lifeSystem.life;
         _loc2_.playerWetnaps = this.m_playerController.player.numWetnaps;
         _loc2_.complete = param1;
         _loc2_.generateMedal();
         this.m_playerController.rewards.updateRewards(_loc2_);
         Log.LevelAverageMetric("FPS",_loc2_.levelID,this.m_fps.average);
         var _loc3_:LevelRewards = this.m_playerController.rewards.getLevelRewards(_loc2_.levelID);
         if(param1)
         {
            Log.LevelCounterMetric("Completed",_loc2_.levelID);
            Log.LevelAverageMetric("Completed Time",_loc2_.levelID,_loc2_.time / 1000);
            Log.LevelAverageMetric("Completed Points",_loc2_.levelID,_loc2_.points);
            Log.LevelAverageMetric("Completed Combo",_loc2_.levelID,_loc2_.highCombo);
            Log.LevelAverageMetric("Deaths",_loc2_.levelID,_loc3_.numDeaths);
            Log.LevelRangedMetric("Health",_loc2_.levelID,_loc2_.playerHealth + _loc2_.playerWetnaps);
            Log.LevelRangedMetric("Medal",_loc2_.levelID,_loc2_.medal);
         }
         else
         {
            Log.LevelCounterMetric("Failed",_loc2_.levelID);
            Log.LevelAverageMetric("Failed Time",_loc2_.levelID,_loc2_.time / 1000);
            Log.LevelAverageMetric("Failed Points",_loc2_.levelID,_loc2_.points);
            Log.LevelAverageMetric("Failed Combo",_loc2_.levelID,_loc2_.highCombo);
            Log.LevelRangedMetric("Failed Wave",_loc2_.levelID,this.m_gameLevelManager.currentLevel.currentSpawnGroup);
         }
      }
      
      public function get gameEngine() : GameEngine
      {
         return parentScreen as GameEngine;
      }
      
      public function set pauseDelay(param1:int) : void
      {
         this.m_pauseDelay = param1;
      }
      
      public function loadPlayer() : void
      {
         this.m_player = this.m_playerController.loadPlayer();
         this.m_playerController.loadEquipment();
         this.m_gameWorld.camera.followPos(this.m_player.newPos);
         this.m_player.newPos.x = this.m_gameWorld.bounds.halfWidth;
         this.m_player.newPos.y = this.m_gameWorld.bounds.height - this.m_player.bounds.halfHeight;
         this.m_player.addEventListener(PlayerEvent.DIE,this.onPlayerDead);
      }
      
      override public function update(param1:int) : void
      {
         var _loc2_:int = 0;
         super.update(param1);
         this.m_pauseDelay -= param1;
         if(this.m_pauseDelay < 0)
         {
            this.m_pauseDelay = 0;
         }
         if(!this.m_isPaused || this.m_pauseDelay > 0)
         {
            this.m_gameWorld.update(param1);
            _loc2_ = getTimer();
            this.m_gameLevelManager.update(param1);
            this.m_rewardSystem.update(param1);
            this.m_playerController.update(param1);
            this.m_displayManager.update(param1);
         }
         this.handleInput();
      }
      
      public function loadGameLevel() : void
      {
         this.m_gameLevelManager.setGameWorld(this.m_gameWorld);
         this.m_gameLevelManager.loadSelectedGameLevel();
         this.m_gameLevelManager.startLevelCountdown();
      }
      
      public function onLevelCountdownStart(param1:Event) : void
      {
         this.m_fps.reset();
         this.m_rewardSystem.reset();
         this.m_rewardSystem.unlock();
         this.m_playerController.resetPlayer();
         addChild(this.m_countdownAnimation);
         this.m_countdownAnimation.gotoAndPlay(1);
         this.m_countdownAnimation.addEventListener(Event.COMPLETE,this.onLevelCountdownEnd,false,0,true);
      }
      
      public function get isPaused() : Boolean
      {
         return this.m_isPaused;
      }
      
      private function showTutorial() : void
      {
         if(this.m_isTutorialShowing || this.m_isPaused)
         {
            return;
         }
         this.m_isTutorialShowing = true;
         this.m_isPaused = !this.m_isPaused;
         this.m_screenManager.addChildScreen("TutorialScreen",this);
         getChildScreen("TutorialScreen").addEventListener(Event.CLOSE,this.onTutorialClose,false,0,true);
      }
   }
}

