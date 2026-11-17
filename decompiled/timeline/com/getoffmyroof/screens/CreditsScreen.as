package com.getoffmyroof.screens
{
   import com.getoffmyroof.engine.GameComponents;
   import com.whatthefawk.screens.AScreen;
   import com.whatthefawk.screens.IScreenItem;
   import com.whatthefawk.screens.ScreenManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class CreditsScreen extends AScreen
   {
      
      public var btn_main_menu:btn_main_menu_class;
      
      private var m_screenManager:ScreenManager;
      
      public function CreditsScreen(param1:IScreenItem = null)
      {
         super(param1);
         this.m_screenManager = GameComponents.instance.getScreenManager();
         this.initButtons();
      }
      
      private function initButtons() : void
      {
         this.btn_main_menu.addEventListener(MouseEvent.CLICK,this.onMainMenuClick,false,0,true);
      }
      
      private function onMainMenuClick(param1:Event) : void
      {
         this.m_screenManager.setScreen("MainScreen");
      }
      
      override public function dispose() : void
      {
         this.m_screenManager = null;
         this.btn_main_menu.removeEventListener(MouseEvent.CLICK,this.onMainMenuClick);
         super.dispose();
      }
   }
}

