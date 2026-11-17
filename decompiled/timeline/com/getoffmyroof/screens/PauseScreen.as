package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.getoffmyroof.ui.dialog.Dialog;
   import com.getoffmyroof.ui.dialog.DialogEvent;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.Root;
   import com.whatthefawk.screens.ScreenManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import fog.as3.FogDevAPI;
   
   public class PauseScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      private var m_screenManager:ScreenManager;
      
      public var btn_play_more_xxx_games:btn_play_more_xxx_games_class;
      
      public var btn_buy_new_weapons:btn_buy_new_weapons_class;
      
      public var btn_return_to_game:btn_return_to_game_class;
      
      public var btn_level_selection:btn_level_selection_class;
      
      public var btn_replay_level:btn_replay_level_class;
      
      public var btn_options:btn_options_class;
      
      public function PauseScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_screenManager = GameComponents.instance.getScreenManager();
         x = Root.WIDTH / 2 - width / 2;
         y = Root.HEIGHT / 2 - height / 2;
         this.initButtons();
      }
      
      private function onLevelSelectClick(param1:Event) : void
      {
         var _loc2_:* = new Dialog(Dialog.YES_NO,"Are you sure you wish to exit this level?");
         _loc2_.addEventListener(DialogEvent.CLICKED,this.onLevelSelectDialogClick,false,0,true);
         parent.addChild(_loc2_);
         this.visible = false;
      }
      
      private function onReplayLevelDialogClick(param1:DialogEvent) : void
      {
         var _loc2_:String = param1.data.button;
         if(_loc2_ == "yes")
         {
            this.m_screenManager.setScreen("GameScreen");
         }
         else
         {
            this.visible = true;
         }
      }
      
      private function onBuyNewWeaponsClick(param1:Event) : void
      {
         var _loc2_:* = new Dialog(Dialog.YES_NO,"Are you sure you wish to exit this level?");
         _loc2_.addEventListener(DialogEvent.CLICKED,this.onBuyNewWeaponsDialogClick,false,0,true);
         parent.addChild(_loc2_);
         this.visible = false;
      }
      
      private function onReturnToGameClick(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
      }
      
      private function onOptionsClick(param1:Event) : void
      {
         this.m_screenManager.addChildScreen("OptionsScreen",parentScreen);
         parentScreen.getChildScreen("OptionsScreen").addEventListener(Event.CLOSE,this.onOptionsScreenClose,false,0,true);
         this.visible = false;
      }
      
      private function initButtons() : void
      {
         this.btn_return_to_game.addEventListener(MouseEvent.CLICK,this.onReturnToGameClick,false,0,true);
         this.btn_replay_level.addEventListener(MouseEvent.CLICK,this.onReplayLevelClick,false,0,true);
         this.btn_level_selection.addEventListener(MouseEvent.CLICK,this.onLevelSelectClick,false,0,true);
         this.btn_buy_new_weapons.addEventListener(MouseEvent.CLICK,this.onBuyNewWeaponsClick,false,0,true);
         this.btn_options.addEventListener(MouseEvent.CLICK,this.onOptionsClick,false,0,true);
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
         this.btn_play_more_xxx_games.addEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick,false,0,true);
      }
      
      private function onPlayMoreGamesClick(param1:Event) : void
      {
         var _loc2_:FogDevAPI = GameComponents.instance.getComponent("FogAPI");
         _loc2_.Tracking.GotoURL("http://www.freeonlinegames.com/tag/Arcade_Games");
      }
      
      private function onLevelSelectDialogClick(param1:DialogEvent) : void
      {
         var _loc2_:String = param1.data.button;
         if(_loc2_ == "yes")
         {
            this.m_screenManager.setScreen("LevelSelectScreen");
         }
         else
         {
            this.visible = true;
         }
      }
      
      private function onMainMenuClick(param1:Event) : void
      {
         var _loc2_:* = new Dialog(Dialog.YES_NO,"Are you sure you wish to exit this level?");
         _loc2_.addEventListener(DialogEvent.CLICKED,this.onMainMenuDialogClick,false,0,true);
         parent.addChild(_loc2_);
         this.visible = false;
      }
      
      private function onBuyNewWeaponsDialogClick(param1:DialogEvent) : void
      {
         var _loc2_:String = param1.data.button;
         if(_loc2_ == "yes")
         {
            this.m_screenManager.setScreen("ItemShopScreen");
         }
         else
         {
            this.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_screenManager = null;
         this.btn_return_to_game.removeEventListener(MouseEvent.CLICK,this.onReturnToGameClick);
         this.btn_replay_level.removeEventListener(MouseEvent.CLICK,this.onReplayLevelClick);
         this.btn_level_selection.removeEventListener(MouseEvent.CLICK,this.onLevelSelectClick);
         this.btn_buy_new_weapons.removeEventListener(MouseEvent.CLICK,this.onBuyNewWeaponsClick);
         this.btn_options.removeEventListener(MouseEvent.CLICK,this.onOptionsClick);
         this.btn_main_menu.removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         this.btn_play_more_xxx_games.removeEventListener(MouseEvent.CLICK,this.onPlayMoreGamesClick);
      }
      
      private function onMainMenuDialogClick(param1:DialogEvent) : void
      {
         var _loc2_:String = param1.data.button;
         if(_loc2_ == "yes")
         {
            this.m_screenManager.setScreen("MainScreen");
         }
         else
         {
            this.visible = true;
         }
      }
      
      private function onOptionsScreenClose(param1:Event) : void
      {
         parentScreen.getChildScreen("OptionsScreen").removeEventListener(Event.CLOSE,this.onOptionsScreenClose);
         this.m_screenManager.removeChildScreen("OptionsScreen",parentScreen);
         this.visible = true;
      }
      
      private function onReplayLevelClick(param1:Event) : void
      {
         var _loc2_:* = new Dialog(Dialog.YES_NO,"Are you sure you wish to replay this level?");
         _loc2_.addEventListener(DialogEvent.CLICKED,this.onReplayLevelDialogClick,false,0,true);
         parent.addChild(_loc2_);
         this.visible = false;
      }
   }
}

