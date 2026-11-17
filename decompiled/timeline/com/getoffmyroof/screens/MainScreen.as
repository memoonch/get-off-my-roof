package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.levels.GameLevelManager;
   import com.greensock.TweenMax;
   import com.whatthefawk.audio.AudioManager;
   import com.whatthefawk.rewards.achievements.AchievementManager;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import com.whatthefawk.utils.Input;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import fog.as3.FogDevAPI;
   
   public class MainScreen extends AScreen
   {
      
      public var btn_credits:btn_credits_class;
      
      private var m_audioManager:AudioManager;
      
      private var m_screenManager:ScreenManager;
      
      private var m_achievementManager:AchievementManager;
      
      public var btn_play_more_games:btn_play_more_games_class;
      
      public var btn_player_setup:btn_player_setup_class;
      
      public var btn_achievements:btn_achievements_class;
      
      private var m_gameLevelManager:GameLevelManager;
      
      public var btn_play:btn_play_class;
      
      public var btn_add_to_website:btn_add_to_website_class;
      
      public var btn_options:btn_options_class;
      
      public var btn_item_shop:btn_item_shop_class;
      
      public function MainScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_audioManager = GameComponents.instance.getAudioManager();
         this.m_screenManager = GameComponents.instance.getScreenManager();
         this.m_gameLevelManager = GameComponents.instance.getComponent("GameLevelManager");
         this.m_achievementManager = GameComponents.instance.getComponent("AchievementManager");
         this.initButtons();
      }
      
      private function onItemShopClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("ItemShopScreen");
      }
      
      private function handleInput() : void
      {
         var _loc1_:Input = Input.instance;
      }
      
      private function onPlayGameClick(param1:Event = null) : void
      {
         this.m_screenManager.setScreen("LevelSelectScreen");
      }
      
      private function onPlayerSetupClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("PlayerSetupScreen");
      }
      
      private function onCreditsClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("CreditsScreen");
      }
      
      private function initButtons() : void
      {
         this.btn_play.addEventListener(MouseEvent.CLICK,this.onPlayGameClick,false,0,true);
         this.btn_player_setup.addEventListener(MouseEvent.CLICK,this.onPlayerSetupClick,false,0,true);
         this.btn_achievements.addEventListener(MouseEvent.CLICK,this.onAchievementsClick,false,0,true);
         this.btn_item_shop.addEventListener(MouseEvent.CLICK,this.onItemShopClick,false,0,true);
         this.btn_options.addEventListener(MouseEvent.CLICK,this.onOptionsClick,false,0,true);
         this.btn_credits.addEventListener(MouseEvent.CLICK,this.onCreditsClick,false,0,true);
         this.btn_play_more_games.addEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick,false,0,true);
         this.btn_add_to_website.addEventListener(MouseEvent.CLICK,this.onAddToWebsiteClick,false,0,true);
         TweenMax.from(this.btn_play,0.5,{
            "alpha":0,
            "delay":0
         });
         TweenMax.from(this.btn_player_setup,0.5,{
            "alpha":0,
            "delay":0.2
         });
         TweenMax.from(this.btn_achievements,0.5,{
            "alpha":0,
            "delay":0.4
         });
         TweenMax.from(this.btn_item_shop,0.5,{
            "alpha":0,
            "delay":0.6
         });
         TweenMax.from(this.btn_options,0.5,{
            "alpha":0,
            "delay":0.8
         });
         TweenMax.from(this.btn_credits,0.5,{
            "alpha":0,
            "delay":1
         });
         TweenMax.from(this.btn_play_more_games,0.5,{
            "alpha":0,
            "delay":1.2
         });
         TweenMax.from(this.btn_add_to_website,0.5,{
            "alpha":0,
            "delay":1.4
         });
      }
      
      private function onPlayMoreGamesClick(param1:Event) : void
      {
         var _loc2_:FogDevAPI = GameComponents.instance.getComponent("FogAPI");
         _loc2_.Tracking.GotoURL("http://www.freeonlinegames.com/tag/Arcade_Games");
      }
      
      override public function update(param1:int) : void
      {
         super.update(param1);
         this.handleInput();
      }
      
      private function onAchievementsClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("AchievementsScreen");
      }
      
      override public function dispose() : void
      {
         this.m_audioManager = null;
         this.m_screenManager = null;
         this.m_gameLevelManager = null;
         this.btn_play.removeEventListener(MouseEvent.CLICK,this.onPlayGameClick);
         this.btn_player_setup.removeEventListener(MouseEvent.CLICK,this.onPlayerSetupClick);
         this.btn_achievements.removeEventListener(MouseEvent.CLICK,this.onAchievementsClick);
         this.btn_item_shop.removeEventListener(MouseEvent.CLICK,this.onItemShopClick);
         this.btn_options.removeEventListener(MouseEvent.CLICK,this.onOptionsClick);
         this.btn_credits.removeEventListener(MouseEvent.CLICK,this.onCreditsClick);
         this.btn_play_more_games.removeEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick);
         this.btn_add_to_website.removeEventListener(MouseEvent.CLICK,this.onAddToWebsiteClick);
         super.dispose();
      }
      
      private function onAddToWebsiteClick(param1:Event) : void
      {
         var _loc2_:FogDevAPI = GameComponents.instance.getComponent("FogAPI");
         _loc2_.Tracking.GotoURL(_loc2_.Tracking.FGFYWURL);
      }
      
      private function onOptionsClick(param1:Event) : void
      {
         this.m_screenManager.addChildScreen("OptionsScreen",this);
         getChildScreen("OptionsScreen").addEventListener(Event.CLOSE,this.onOptionsScreenClose,false,0,true);
      }
      
      private function onOptionsScreenClose(param1:Event) : void
      {
         getChildScreen("OptionsScreen").removeEventListener(Event.CLOSE,this.onOptionsScreenClose);
         this.m_screenManager.removeChildScreen("OptionsScreen",this);
      }
   }
}

