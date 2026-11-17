package com.getoffmyroof.ui
{
   import com.getoffmyroof.engine.GameEvent;
   import com.getoffmyroof.entity.Player;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.getoffmyroof.rewards.RewardSystem;
   import com.getoffmyroof.screens.GameScreen;
   import com.whatthefawk.entity.MovingEntity;
   import flash.events.Event;
   
   public class PlayerUI extends MovingEntity
   {
      
      private var m_gameLevelManager:GameLevelManager;
      
      private var m_gameScreen:GameScreen;
      
      private var m_player:Player;
      
      private var m_rewardSystem:RewardSystem;
      
      public function PlayerUI(param1:PlayerUIParams)
      {
         super(param1);
      }
      
      public function get player() : Player
      {
         return this.m_player;
      }
      
      public function setGameScreen(param1:GameScreen) : void
      {
         this.m_gameScreen = param1;
         this.m_gameScreen.addEventListener(GameEvent.PAUSE,this.onGameScreenPause,false,0,true);
      }
      
      public function setPlayer(param1:*) : void
      {
         this.m_player = param1;
      }
      
      public function get levelPoints() : int
      {
         return this.m_rewardSystem.points;
      }
      
      public function get levelHighCombo() : int
      {
         return this.m_rewardSystem.highCombo;
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
      }
      
      public function get levelCombo() : int
      {
         return this.m_rewardSystem.currentCombo;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_gameScreen.removeEventListener(GameEvent.PAUSE,this.onGameScreenPause);
         this.m_player = null;
         this.m_gameScreen = null;
         this.m_gameLevelManager = null;
      }
      
      public function get levelCurrentWave() : int
      {
         return this.m_gameLevelManager.currentLevel.currentSpawnGroup;
      }
      
      public function get levelTime() : int
      {
         return this.m_gameLevelManager.levelTimer.time;
      }
      
      public function get levelNumWaves() : int
      {
         return this.m_gameLevelManager.currentLevel.numSpawnGroups;
      }
      
      public function setRewardSystem(param1:RewardSystem) : void
      {
         this.m_rewardSystem = param1;
      }
      
      private function onGameScreenPause(param1:Event) : void
      {
         dispatchEvent(new Event(GameEvent.PAUSE));
      }
      
      public function setGameLevelManager(param1:GameLevelManager) : void
      {
         this.m_gameLevelManager = param1;
      }
      
      public function get rewardSystem() : RewardSystem
      {
         return this.m_rewardSystem;
      }
      
      public function get isPaused() : Boolean
      {
         return this.m_gameScreen.isPaused;
      }
   }
}

